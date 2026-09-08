/* Audio: lib.PlayMIDI (looping music) and lib.PlayWAV (one-shot SFX).
 *
 * The original used BASS + BASSMIDI + smpeg. Despite the name, PlayMIDI is
 * handed an .mp3 path here (CONFIG.MP3 = 1 selects "game%02d.mp3"), and
 * PlayMPEG is never called by the scripts at all -- so no MIDI synthesis and
 * no video decoding are needed.
 *
 * Decoding goes through AudioToolbox's ExtAudioFile, which reads MP3 and WAV
 * with no third-party dependency, and mixing is left to SDL3: several
 * AudioStreams bound to one device are summed automatically.
 */
#include "engine.h"
#include <AudioToolbox/AudioToolbox.h>
#include <string.h>
#include <stdlib.h>

#define RATE 44100
#define CHANNELS 2
#define SFX_VOICES 8
#define SFX_CACHE 64

typedef struct {
    int16_t *pcm;
    size_t   bytes;
} Clip;

static SDL_AudioDeviceID g_dev;
static SDL_AudioStream  *g_music;
static SDL_AudioStream  *g_sfx[SFX_VOICES];
static Clip              g_music_clip;
static struct {
    char path[320];
    Clip clip;
} g_sfx_cache[SFX_CACHE];
static int  g_nsfx;
static bool g_ready;

/* Decoding a full track costs ~0.6s for a 5-minute MP3, which would stall the
 * game loop, so music is decoded on a worker thread and handed over here. A
 * generation counter makes sure only the most recent request wins. */
static SDL_Mutex    *g_mtx;
static Clip          g_incoming;
static bool          g_incoming_ready;
static SDL_AtomicInt g_music_gen;

/* Decode any AudioToolbox-supported file to s16 stereo @ 44100. */
static bool decode_file(const char *path, Clip *out) {
    memset(out, 0, sizeof(*out));

    CFURLRef url = CFURLCreateFromFileSystemRepresentation(NULL, (const UInt8 *)path,
                                                           (CFIndex)strlen(path), false);
    if (!url) return false;

    ExtAudioFileRef af = NULL;
    OSStatus        st = ExtAudioFileOpenURL(url, &af);
    CFRelease(url);
    if (st != noErr || !af) return false;

    AudioStreamBasicDescription fmt = {0};
    fmt.mSampleRate                 = RATE;
    fmt.mFormatID                   = kAudioFormatLinearPCM;
    fmt.mFormatFlags      = kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
    fmt.mBytesPerPacket   = 2 * CHANNELS;
    fmt.mFramesPerPacket  = 1;
    fmt.mBytesPerFrame    = 2 * CHANNELS;
    fmt.mChannelsPerFrame = CHANNELS;
    fmt.mBitsPerChannel   = 16;
    if (ExtAudioFileSetProperty(af, kExtAudioFileProperty_ClientDataFormat, sizeof fmt,
                                &fmt) != noErr) {
        ExtAudioFileDispose(af);
        return false;
    }

    size_t   cap = 1 << 20, len = 0;
    int16_t *buf = (int16_t *)malloc(cap);
    if (!buf) {
        ExtAudioFileDispose(af);
        return false;
    }

    for (;;) {
        if (len + 65536 > cap) {
            cap *= 2;
            int16_t *nb = (int16_t *)realloc(buf, cap);
            if (!nb) break;
            buf = nb;
        }
        UInt32          frames          = 8192;
        AudioBufferList abl             = {0};
        abl.mNumberBuffers              = 1;
        abl.mBuffers[0].mNumberChannels = CHANNELS;
        abl.mBuffers[0].mDataByteSize   = frames * 2 * CHANNELS;
        abl.mBuffers[0].mData           = (uint8_t *)buf + len;
        if (ExtAudioFileRead(af, &frames, &abl) != noErr || frames == 0) break;
        len += (size_t)frames * 2 * CHANNELS;
    }
    ExtAudioFileDispose(af);

    if (!len) {
        free(buf);
        return false;
    }
    out->pcm   = buf;
    out->bytes = len;
    return true;
}

bool jy_audio_init(void) {
    SDL_AudioSpec spec = {SDL_AUDIO_S16LE, CHANNELS, RATE};

    if (!SDL_InitSubSystem(SDL_INIT_AUDIO)) {
        jy_log("audio: SDL_INIT_AUDIO failed: %s", SDL_GetError());
        return false;
    }
    g_mtx = SDL_CreateMutex();
    g_dev = SDL_OpenAudioDevice(SDL_AUDIO_DEVICE_DEFAULT_PLAYBACK, &spec);
    if (!g_dev) {
        jy_log("audio: no device: %s", SDL_GetError());
        return false;
    }

    g_music = SDL_CreateAudioStream(&spec, &spec);
    if (g_music) SDL_BindAudioStream(g_dev, g_music);
    for (int i = 0; i < SFX_VOICES; i++) {
        g_sfx[i] = SDL_CreateAudioStream(&spec, &spec);
        if (g_sfx[i]) SDL_BindAudioStream(g_dev, g_sfx[i]);
    }
    SDL_ResumeAudioDevice(g_dev);
    g_ready = true;
    jy_log("audio: %d Hz stereo, %d sfx voices", RATE, SFX_VOICES);
    return true;
}

void jy_audio_shutdown(void) {
    if (!g_ready) return;
    SDL_AddAtomicInt(&g_music_gen, 1);
    if (g_music) SDL_DestroyAudioStream(g_music);
    for (int i = 0; i < SFX_VOICES; i++)
        if (g_sfx[i]) SDL_DestroyAudioStream(g_sfx[i]);
    if (g_dev) SDL_CloseAudioDevice(g_dev);
    free(g_music_clip.pcm);
    free(g_incoming.pcm);
    for (int i = 0; i < g_nsfx; i++) free(g_sfx_cache[i].clip.pcm);
    if (g_mtx) SDL_DestroyMutex(g_mtx);
    g_ready = false;
}

typedef struct {
    char path[512];
    int  gen;
} MusicReq;

static int SDLCALL music_worker(void *ud) {
    MusicReq *req = (MusicReq *)ud;
    Clip      c;
    bool      ok = decode_file(req->path, &c);
    if (!ok) {
        jy_log("PlayMIDI: cannot decode %s", req->path);
    } else if (SDL_GetAtomicInt(&g_music_gen) != req->gen) {
        free(c.pcm); /* superseded while decoding */
    } else {
        SDL_LockMutex(g_mtx);
        free(g_incoming.pcm);
        g_incoming       = c;
        g_incoming_ready = true;
        SDL_UnlockMutex(g_mtx);
        jy_log("PlayMIDI: %s (%.1fs, looping)", req->path,
               (double)c.bytes / (RATE * 2.0 * CHANNELS));
    }
    free(req);
    return 0;
}

/* Music: replace whatever is playing and loop it. Decoded off-thread. */
void jy_play_music(const char *path) {
    if (!g_ready || !g_music || !path) return;
    MusicReq *req = (MusicReq *)calloc(1, sizeof(MusicReq));
    if (!req) return;
    snprintf(req->path, sizeof(req->path), "%s", path);
    req->gen      = SDL_AddAtomicInt(&g_music_gen, 1) + 1;
    SDL_Thread *t = SDL_CreateThread(music_worker, "jy-music", req);
    if (t) SDL_DetachThread(t);
    else { free(req); }
}

void jy_stop_music(void) {
    if (!g_ready) return;
    SDL_AddAtomicInt(&g_music_gen, 1); /* invalidate any in-flight decode */
    if (g_music) SDL_ClearAudioStream(g_music);
    free(g_music_clip.pcm);
    memset(&g_music_clip, 0, sizeof(g_music_clip));
    SDL_LockMutex(g_mtx);
    free(g_incoming.pcm);
    memset(&g_incoming, 0, sizeof(g_incoming));
    g_incoming_ready = false;
    SDL_UnlockMutex(g_mtx);
}

/* Called from the engine's idle tick: re-queue the track when it drains. */
void jy_audio_update(void) {
    if (!g_ready || !g_music) return;

    if (g_incoming_ready) { /* a worker finished a track */
        SDL_LockMutex(g_mtx);
        Clip c = g_incoming;
        memset(&g_incoming, 0, sizeof(g_incoming));
        g_incoming_ready = false;
        SDL_UnlockMutex(g_mtx);
        SDL_ClearAudioStream(g_music);
        free(g_music_clip.pcm);
        g_music_clip = c;
        if (g_music_clip.pcm)
            SDL_PutAudioStreamData(g_music, g_music_clip.pcm, (int)g_music_clip.bytes);
    }
    if (!g_music_clip.pcm) return;
    if (SDL_GetAudioStreamAvailable(g_music) <= 0)
        SDL_PutAudioStreamData(g_music, g_music_clip.pcm, (int)g_music_clip.bytes);
}

/* SFX: decoded once, then fired on the first idle voice. */
void jy_play_sound(const char *path) {
    if (!g_ready || !path) return;

    Clip *clip = NULL;
    for (int i = 0; i < g_nsfx; i++)
        if (strcmp(g_sfx_cache[i].path, path) == 0) {
            clip = &g_sfx_cache[i].clip;
            break;
        }

    if (!clip) {
        if (g_nsfx >= SFX_CACHE) return;
        Clip c;
        if (!decode_file(path, &c)) {
            jy_log("PlayWAV: cannot decode %s", path);
            return;
        }
        snprintf(g_sfx_cache[g_nsfx].path, sizeof(g_sfx_cache[0].path), "%s", path);
        g_sfx_cache[g_nsfx].clip = c;
        clip                     = &g_sfx_cache[g_nsfx].clip;
        g_nsfx++;
        jy_log("PlayWAV: %s (%.2fs, cached)", path,
               (double)clip->bytes / (RATE * 2.0 * CHANNELS));
    }
    if (!clip->pcm) return;

    for (int i = 0; i < SFX_VOICES; i++) {
        if (g_sfx[i] && SDL_GetAudioStreamAvailable(g_sfx[i]) <= 0) {
            SDL_PutAudioStreamData(g_sfx[i], clip->pcm, (int)clip->bytes);
            return;
        }
    }
    /* all voices busy: drop the sound rather than cutting one off */
}

package com.airsnap.airsnap

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.ComponentName
import android.content.Intent
import android.media.AudioAttributes
import android.media.AudioFocusRequest
import android.media.AudioManager
import android.os.Build
import android.os.IBinder
import android.support.v4.media.session.MediaSessionCompat
import android.support.v4.media.session.PlaybackStateCompat
import android.view.KeyEvent
import androidx.core.app.NotificationCompat

class ShutterService : Service() {

    private var mediaSession: MediaSessionCompat? = null
    private var audioFocusRequest: AudioFocusRequest? = null

    companion object {
        private var instance: ShutterService? = null
        fun emitKey(keyCode: Int) {
            instance?.let { MainActivity.onMediaButton(keyCode) }
        }
    }

    override fun onCreate() {
        super.onCreate()
        instance = this
        createNotificationChannel()
        startForeground(1, buildNotification())
        setupMediaSession()
        requestAudioFocus()
    }

    private fun setupMediaSession() {
        val receiver = ComponentName(this, MediaButtonReceiver::class.java)
        mediaSession = MediaSessionCompat(this, "AirSnapService", receiver, null).also { s ->
            s.setPlaybackState(
                PlaybackStateCompat.Builder()
                    .setState(PlaybackStateCompat.STATE_PLAYING, 0, 1f)
                    .setActions(PlaybackStateCompat.ACTION_PLAY_PAUSE or
                            PlaybackStateCompat.ACTION_SKIP_TO_NEXT or
                            PlaybackStateCompat.ACTION_SKIP_TO_PREVIOUS)
                    .build()
            )
            s.setCallback(object : MediaSessionCompat.Callback() {
                override fun onMediaButtonEvent(intent: Intent): Boolean {
                    val ev = intent.getParcelableExtra<KeyEvent>(Intent.EXTRA_KEY_EVENT)
                    if (ev?.action == KeyEvent.ACTION_DOWN) {
                        MainActivity.onMediaButton(ev.keyCode)
                    }
                    return true
                }
                override fun onPlay() { MainActivity.onMediaButton(KeyEvent.KEYCODE_MEDIA_PLAY_PAUSE) }
                override fun onPause() { MainActivity.onMediaButton(KeyEvent.KEYCODE_MEDIA_PLAY_PAUSE) }
            })
            s.isActive = true
        }
    }

    private fun requestAudioFocus() {
        val am = getSystemService(AUDIO_SERVICE) as AudioManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val req = AudioFocusRequest.Builder(AudioManager.AUDIOFOCUS_GAIN)
                .setAudioAttributes(
                    AudioAttributes.Builder()
                        .setUsage(AudioAttributes.USAGE_MEDIA)
                        .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                        .build()
                )
                .setWillPauseWhenDucked(false)
                .setOnAudioFocusChangeListener {}
                .build()
            am.requestAudioFocus(req)
            audioFocusRequest = req
        } else {
            @Suppress("DEPRECATION")
            am.requestAudioFocus(null, AudioManager.STREAM_MUSIC, AudioManager.AUDIOFOCUS_GAIN)
        }
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                "airsnap_shutter",
                "AirSnap Shutter",
                NotificationManager.IMPORTANCE_LOW
            ).apply { setShowBadge(false) }
            getSystemService(NotificationManager::class.java).createNotificationChannel(channel)
        }
    }

    private fun buildNotification(): Notification =
        NotificationCompat.Builder(this, "airsnap_shutter")
            .setContentTitle("AirSnap")
            .setContentText("Listening for shutter button…")
            .setSmallIcon(android.R.drawable.ic_menu_camera)
            .setSilent(true)
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .build()

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onDestroy() {
        super.onDestroy()
        instance = null
        mediaSession?.isActive = false
        mediaSession?.release()
        val am = getSystemService(AUDIO_SERVICE) as AudioManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            audioFocusRequest?.let { am.abandonAudioFocusRequest(it) }
        } else {
            @Suppress("DEPRECATION")
            am.abandonAudioFocus(null)
        }
    }
}

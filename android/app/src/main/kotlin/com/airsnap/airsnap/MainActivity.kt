package com.airsnap.airsnap

import android.content.ComponentName
import android.content.Intent
import android.database.ContentObserver
import android.media.AudioManager
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.os.PowerManager
import android.provider.Settings
import android.support.v4.media.session.MediaSessionCompat
import android.support.v4.media.session.PlaybackStateCompat
import android.text.TextUtils
import android.view.KeyEvent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private var eventSink: EventChannel.EventSink? = null
    private var wakeLock: PowerManager.WakeLock? = null
    private var mediaSession: MediaSessionCompat? = null
    private var lastVolume = -1

    // Detects BT headset volume buttons via system volume changes.
    private val volumeObserver = object : ContentObserver(Handler(Looper.getMainLooper())) {
        override fun onChange(selfChange: Boolean) {
            val am = getSystemService(AUDIO_SERVICE) as AudioManager
            val current = am.getStreamVolume(AudioManager.STREAM_MUSIC)
            if (lastVolume >= 0 && current != lastVolume) {
                eventSink?.success(
                    if (current > lastVolume) KeyEvent.KEYCODE_VOLUME_UP
                    else KeyEvent.KEYCODE_VOLUME_DOWN
                )
            }
            lastVolume = current
        }
    }

    companion object {
        private var instance: MainActivity? = null

        fun onMediaButton(keyCode: Int) {
            instance?.eventSink?.success(keyCode)
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        instance = this

        // Start foreground service to hold audio focus → BT headset media buttons reach us.
        val svc = Intent(this, ShutterService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) startForegroundService(svc)
        else startService(svc)

        // Accessibility helper channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.airsnap.airsnap/accessibility")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "isAccessibilityEnabled" -> result.success(isAccessibilityEnabled())
                    "openAccessibilitySettings" -> {
                        startActivity(Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS))
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }

        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.airsnap.airsnap/volume"
        ).setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, sink: EventChannel.EventSink?) {
                eventSink = sink
            }
            override fun onCancel(arguments: Any?) {
                eventSink = null
            }
        })
    }

    override fun onResume() {
        super.onResume()

        val pm = getSystemService(POWER_SERVICE) as PowerManager
        @Suppress("DEPRECATION")
        wakeLock = pm.newWakeLock(
            PowerManager.SCREEN_BRIGHT_WAKE_LOCK or PowerManager.ACQUIRE_CAUSES_WAKEUP,
            "airsnap:camera"
        )
        wakeLock?.acquire(10 * 60 * 1000L)

        // ContentObserver: catches BT headset volume buttons via system volume changes.
        val am = getSystemService(AUDIO_SERVICE) as AudioManager
        lastVolume = am.getStreamVolume(AudioManager.STREAM_MUSIC)
        contentResolver.registerContentObserver(
            android.provider.Settings.System.CONTENT_URI, true, volumeObserver
        )

        // Register as priority media button receiver so BT headsets reach us
        // even when other media apps are running.
        val receiver = ComponentName(this, MediaButtonReceiver::class.java)
        @Suppress("DEPRECATION")
        am.registerMediaButtonEventReceiver(receiver)

        mediaSession = MediaSessionCompat(this, "AirSnap", receiver, null).also { s ->
            s.setPlaybackState(
                PlaybackStateCompat.Builder()
                    .setState(PlaybackStateCompat.STATE_PLAYING, 0, 1f)
                    .setActions(PlaybackStateCompat.ACTION_PLAY_PAUSE)
                    .build()
            )
            s.setCallback(object : MediaSessionCompat.Callback() {
                override fun onMediaButtonEvent(intent: Intent): Boolean {
                    val ev = intent.getParcelableExtra<KeyEvent>(Intent.EXTRA_KEY_EVENT)
                    if (ev?.action == KeyEvent.ACTION_DOWN) {
                        eventSink?.success(ev.keyCode)
                    }
                    return true
                }
            })
            s.isActive = true
        }
    }

    override fun onPause() {
        super.onPause()
        contentResolver.unregisterContentObserver(volumeObserver)
        wakeLock?.release()
        wakeLock = null
        mediaSession?.isActive = false
        mediaSession?.release()
        mediaSession = null
        val am = getSystemService(AUDIO_SERVICE) as AudioManager
        @Suppress("DEPRECATION")
        am.unregisterMediaButtonEventReceiver(
            ComponentName(this, MediaButtonReceiver::class.java)
        )
    }

    private fun isAccessibilityEnabled(): Boolean {
        val service = "$packageName/${AirSnapAccessibilityService::class.java.canonicalName}"
        val enabledServices = Settings.Secure.getString(
            contentResolver, Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES
        ) ?: return false
        return TextUtils.SimpleStringSplitter(':').apply { setString(enabledServices) }
            .any { it.equals(service, ignoreCase = true) }
    }

    override fun onDestroy() {
        super.onDestroy()
        instance = null
    }

    // Catches volume keys + physical keyboard keys directly.
    override fun dispatchKeyEvent(event: KeyEvent): Boolean {
        if (event.action == KeyEvent.ACTION_DOWN) {
            val ignored = setOf(
                KeyEvent.KEYCODE_HOME, KeyEvent.KEYCODE_BACK,
                KeyEvent.KEYCODE_APP_SWITCH, KeyEvent.KEYCODE_POWER
            )
            if (event.keyCode !in ignored) {
                eventSink?.success(event.keyCode)
                return true
            }
        }
        return super.dispatchKeyEvent(event)
    }
}

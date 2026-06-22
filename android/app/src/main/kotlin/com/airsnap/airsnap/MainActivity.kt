package com.airsnap.airsnap

import android.os.PowerManager
import android.view.KeyEvent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel

class MainActivity : FlutterActivity() {

    private var eventSink: EventChannel.EventSink? = null
    private var wakeLock: PowerManager.WakeLock? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
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
        // Keep screen on while camera is active so BT remote always reaches onKeyDown.
        val pm = getSystemService(POWER_SERVICE) as PowerManager
        @Suppress("DEPRECATION")
        wakeLock = pm.newWakeLock(
            PowerManager.SCREEN_BRIGHT_WAKE_LOCK or PowerManager.ACQUIRE_CAUSES_WAKEUP,
            "airsnap:camera"
        )
        wakeLock?.acquire(10 * 60 * 1000L) // max 10 min
    }

    override fun onPause() {
        super.onPause()
        wakeLock?.release()
        wakeLock = null
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        // Block system keys that must not be consumed.
        val systemKeys = setOf(
            KeyEvent.KEYCODE_HOME,
            KeyEvent.KEYCODE_BACK,
            KeyEvent.KEYCODE_APP_SWITCH,
            KeyEvent.KEYCODE_POWER
        )
        return if (keyCode !in systemKeys) {
            eventSink?.success(keyCode)
            true
        } else {
            super.onKeyDown(keyCode, event)
        }
    }
}

package com.airsnap.airsnap

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.view.KeyEvent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel

class MainActivity : FlutterActivity() {

    private var eventSink: EventChannel.EventSink? = null

    // Receptor para el botón de auriculares con cable (HEADSETHOOK)
    // que Android envia como broadcast, no como KeyEvent directo.
    private val headsetReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            if (intent?.action == Intent.ACTION_MEDIA_BUTTON) {
                val event = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    intent.getParcelableExtra(Intent.EXTRA_KEY_EVENT, KeyEvent::class.java)
                } else {
                    @Suppress("DEPRECATION")
                    intent.getParcelableExtra(Intent.EXTRA_KEY_EVENT)
                }
                if (event?.action == KeyEvent.ACTION_DOWN) {
                    eventSink?.success(event.keyCode)
                }
            }
        }
    }

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

    override fun onStart() {
        super.onStart()
        val filter = IntentFilter(Intent.ACTION_MEDIA_BUTTON)
        filter.priority = IntentFilter.SYSTEM_HIGH_PRIORITY
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            registerReceiver(headsetReceiver, filter, Context.RECEIVER_EXPORTED)
        } else {
            registerReceiver(headsetReceiver, filter)
        }
    }

    override fun onStop() {
        super.onStop()
        unregisterReceiver(headsetReceiver)
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        // Enviamos CUALQUIER tecla a Flutter para diagnóstico y disparo.
        // Las teclas del sistema que no queremos consumir las dejamos pasar.
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

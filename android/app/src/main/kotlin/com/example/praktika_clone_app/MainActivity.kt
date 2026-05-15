package com.arenax.app

import android.content.Context
import android.content.Intent
import android.media.AudioManager
import android.os.Bundle
import android.speech.RecognizerIntent
import android.speech.SpeechRecognizer
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private lateinit var audioManager: AudioManager
    private var speechRecognizer: SpeechRecognizer? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
        speechRecognizer = SpeechRecognizer.createSpeechRecognizer(this)
    }

    private fun startListening() {
        // Switch to communication mode to mute system UI sounds
        audioManager.mode = AudioManager.MODE_IN_COMMUNICATION
        audioManager.setStreamMute(AudioManager.STREAM_SYSTEM, true)

        val intent = Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH).apply {
            putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM)
            putExtra(RecognizerIntent.EXTRA_CALLING_PACKAGE, packageName)
        }

        speechRecognizer?.startListening(intent)
    }

    private fun stopListening() {
        speechRecognizer?.stopListening()
        // Restore normal audio mode
        audioManager.setStreamMute(AudioManager.STREAM_SYSTEM, false)
        audioManager.mode = AudioManager.MODE_NORMAL
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "speech_recognition_channel").setMethodCallHandler { call, result ->
            when (call.method) {
                "startListening" -> {
                    startListening()
                    result.success(null)
                }
                "stopListening" -> {
                    stopListening()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }
}
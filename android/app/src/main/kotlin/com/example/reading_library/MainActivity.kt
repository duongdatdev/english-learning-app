package com.example.reading_library

import android.speech.tts.TextToSpeech
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.Locale

class MainActivity : FlutterActivity() {
    private var textToSpeech: TextToSpeech? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "page1.local_tts")
            .setMethodCallHandler { call, result ->
                if (call.method != "speak") {
                    result.notImplemented()
                    return@setMethodCallHandler
                }
                val text = call.argument<String>("text")?.takeIf { it.isNotBlank() }
                if (text == null) {
                    result.error("empty_text", "Text to speak is required.", null)
                    return@setMethodCallHandler
                }
                speak(text, result)
            }
    }

    private fun speak(text: String, result: MethodChannel.Result) {
        val current = textToSpeech
        if (current != null) {
            speakWith(current, text, result)
            return
        }
        textToSpeech = TextToSpeech(this) { status ->
            val engine = textToSpeech
            if (status != TextToSpeech.SUCCESS || engine == null) {
                result.error("tts_init_failed", "Text to speech is unavailable.", null)
            } else {
                speakWith(engine, text, result)
            }
        }
    }

    private fun speakWith(engine: TextToSpeech, text: String, result: MethodChannel.Result) {
        val languageStatus = engine.setLanguage(Locale.US)
        if (languageStatus == TextToSpeech.LANG_MISSING_DATA ||
            languageStatus == TextToSpeech.LANG_NOT_SUPPORTED
        ) {
            result.error("tts_language_unavailable", "English voice data is not installed.", null)
            return
        }
        val status = engine.speak(text, TextToSpeech.QUEUE_FLUSH, null, "page1-pronunciation")
        if (status == TextToSpeech.SUCCESS) {
            result.success(true)
        } else {
            result.error("tts_speak_failed", "Could not start speech playback.", null)
        }
    }

    override fun onDestroy() {
        textToSpeech?.stop()
        textToSpeech?.shutdown()
        textToSpeech = null
        super.onDestroy()
    }
}

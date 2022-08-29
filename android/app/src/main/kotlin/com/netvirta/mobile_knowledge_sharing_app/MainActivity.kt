package com.netvirta.mobile_knowledge_sharing_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.io.IOException

class MainActivity : FlutterActivity() {
    private lateinit var channel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "mobilesdk")
        channel.setMethodCallHandler { call, result ->
            val value =
                GeneratedFlutterVerifytPlatformSDK.values().first { it.funcName == call.method }
            CoroutineScope(Dispatchers.Main).launch {
                when (value) {
                    GeneratedFlutterVerifytPlatformSDK.INITIALIZE -> TODO()
                    GeneratedFlutterVerifytPlatformSDK.TRIGGER -> {
                        throw IOException("BOOM!!")
                    }
                }
            }
        }
    }
}

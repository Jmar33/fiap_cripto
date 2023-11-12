package com.example.tictactoe_3aojr


import android.os.Bundle
import android.os.Handler
import android.util.Log
import com.pubnub.api.PubNub
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val METHOD_CHANNEL = "game/exchange"
    private var channel_pubNub: String? = null
    private var pubNub: PubNub? = null
    private var handler: Handler? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        handler = Handler()

        val pnConfiguration = PNConfiguration("MyUniqueUUID")
        pnConfiguration.subscribeKey =
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL)
        methodChannel.setMethodCallHandler {call, result ->
            if(call.method == "subscribe"){
                subscribeChannel(call.argument<String>("channel"))
                result.success(true)
            }
        }
    }

    fun subscribeChannel(channelName: String?){
        channel_pubNub = channelName
        Log.d("Android", "Chegou no Android: $channelName")
    }
}

package com.example.absensi_app

// import android.os.Bundle
// import android.util.Log
import io.flutter.embedding.android.FlutterActivity
// import io.flutter.embedding.engine.FlutterEngine
// import io.flutter.plugin.common.MethodChannel
// import com.example.absensi_app.UsageLogger

class MainActivity: FlutterActivity() {

}
// {
    // private val CHANNEL = "com.example.absensi_app/usage_logger"

    // override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    //     super.configureFlutterEngine(flutterEngine)
    //     MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
    //         when (call.method) {
    //             "startLogging" -> {
    //                 val usage = call.argument<String>("usage")
    //                 usage?.let {
    //                     UsageLogger.startLoggingCpuAndMemoryUsage(this, it)
    //                     result.success(null)
    //                 } ?: result.error("ERROR", "Usage parameter is null", null)
    //             }
    //             "stopLogging" -> {
    //                 UsageLogger.stopLoggingCpuAndMemoryUsage()
    //                 result.success(null)
    //             }
    //             else -> result.notImplemented()
    //         }
    //     }
    // }
// }

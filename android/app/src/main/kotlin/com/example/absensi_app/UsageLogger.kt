// package com.example.absensi_app

// import android.app.ActivityManager
// import android.content.Context
// import android.os.SystemClock
// import android.util.Log
// import java.io.RandomAccessFile

// object UsageLogger {
//     @Volatile
//     private var isLogging = false
//     private var loggingThread: Thread? = null

//     private var previousTotalTime: Double = 0.0
//     private var previousUptime: Double = 0.0

//     fun startLoggingCpuAndMemoryUsage(context: Context, usage: String) {
//         if (isLogging) return
//         isLogging = true

//         // Reset variables
//         previousTotalTime = 0.0
//         previousUptime = SystemClock.elapsedRealtime().toDouble() / 1000.0

//         val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
//         val runtime = Runtime.getRuntime()

//         loggingThread = object : Thread() {
//             override fun run() {
//                 while (isLogging) {
//                     try {
//                         val memoryInfo = ActivityManager.MemoryInfo()
//                         activityManager.getMemoryInfo(memoryInfo)

//                         val usedMemoryInMB = (runtime.totalMemory() - runtime.freeMemory()) / 1048576L
//                         val maxHeapSizeInMB = runtime.maxMemory() / 1048576L
//                         val availHeapSizeInMB = maxHeapSizeInMB - usedMemoryInMB

//                         val memoryUsage = "Used Memory: ${usedMemoryInMB}MB, Max Heap Size: ${maxHeapSizeInMB}MB, Available Heap Size: ${availHeapSizeInMB}MB"

//                         Log.d("$usage Usage", memoryUsage)

//                         // Mengukur penggunaan CPU
//                         val cpuUsage = getCpuUsage()
//                         Log.d("$usage Usage", "CPU Usage: $cpuUsage%")

//                         sleep(1000)
//                     } catch (e: InterruptedException) {
//                         e.printStackTrace()
//                     }
//                 }
//             }
//         }
//         loggingThread!!.start()
//     }

//     private fun getCpuUsage(): String {
//         return try {
//             val pid = android.os.Process.myPid()
//             val reader = RandomAccessFile("/proc/$pid/stat", "r")
//             val stat = reader.readLine().split(" ")

//             val utime = stat[13].toLong()
//             val stime = stat[14].toLong()
//             val cutime = stat[15].toLong()
//             val cstime = stat[16].toLong()
//             val starttime = stat[21].toLong()

//             reader.close()

//             val uptime = SystemClock.elapsedRealtime().toDouble() / 1000.0
//             val totalTime = (utime + stime + cutime + cstime) / 100.0
//             val seconds = uptime - previousUptime

//             val cpuUsage = if (seconds > 0) {
//                 val usage = ((totalTime - previousTotalTime) / seconds) * 100.0
//                 previousTotalTime = totalTime
//                 previousUptime = uptime
//                 usage
//             } else {
//                 0.0
//             }

//             "%.2f".format(cpuUsage) + "%"
//         } catch (e: Exception) {
//             e.printStackTrace()
//             "N/A"
//         }
//     }

//     fun stopLoggingCpuAndMemoryUsage() {
//         isLogging = false
//         loggingThread?.interrupt()
//         loggingThread = null
//     }
// }
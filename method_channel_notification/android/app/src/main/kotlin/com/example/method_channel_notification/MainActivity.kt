package com.example.method_channel_notification

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "notification"
    private val CHANNEL_ID = "100"
    private val not_id = 1

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "showNotification") {
                showNotification()
                result.success("Service is started !")
            }
            if(call.method == "removeNotification"){
                removeNotification()
                result.success("Notification removed !")
            }
        }
    }

    private fun showNotification() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val builder = NotificationCompat.Builder(this, CHANNEL_ID)
                    .setContentTitle("Native Notification")
                    .setContentText("Flutter notification with platform channel.")
                    .setSmallIcon(R.mipmap.ic_launcher)
                    .setPriority(NotificationCompat.PRIORITY_DEFAULT)

            val notificationChannel = NotificationChannel(CHANNEL_ID, "name", NotificationManager.IMPORTANCE_DEFAULT)

            val notificationManager: NotificationManager =
                    getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(notificationChannel)

            with(NotificationManagerCompat.from(this)) {
                notify(not_id, builder.build())
            }
        }
    }

    private fun removeNotification(){
        val notificationManager: NotificationManager =
                getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        notificationManager.cancel(not_id)
    }
}

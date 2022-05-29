package de.lukasreining.handball_ergebnisse.services

import android.os.Build
import android.os.Handler
import android.os.Looper
import androidx.annotation.RequiresApi
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import de.lukasreining.handball_ergebnisse.services.NotificationActionService
import de.lukasreining.handball_ergebnisse.services.NotificationRegistrationService

class PushNotificationsFirebaseMessagingService : FirebaseMessagingService() {

    companion object {
        var token: String? = null
        var notificationRegistrationService: NotificationRegistrationService? = null
        var notificationActionService: NotificationActionService? = null
    }

    override fun onNewToken(token: String) {
        PushNotificationsFirebaseMessagingService.token = token
        notificationRegistrationService?.refreshRegistration()
    }

    @RequiresApi(Build.VERSION_CODES.N)
    override fun onMessageReceived(message: RemoteMessage) {
        message.data.let {
            Handler(Looper.getMainLooper()).post {
                notificationActionService?.triggerAction(it.getOrDefault("action", "action"))
            }
        }
    }
}
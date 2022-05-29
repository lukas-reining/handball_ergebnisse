package de.lukasreining.handball_ergebnisse

import io.flutter.embedding.android.FlutterActivity

import android.content.Intent
import android.os.Bundle
import com.google.android.gms.tasks.OnCompleteListener
import com.google.firebase.messaging.FirebaseMessaging
import de.lukasreining.handball_ergebnisse.services.DeviceInstallationService
import de.lukasreining.handball_ergebnisse.services.NotificationActionService
import de.lukasreining.handball_ergebnisse.services.NotificationRegistrationService
import de.lukasreining.handball_ergebnisse.services.PushNotificationsFirebaseMessagingService

class MainActivity : FlutterActivity() {
    private lateinit var deviceInstallationService: DeviceInstallationService

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        flutterEngine?.let {
            deviceInstallationService = DeviceInstallationService(context, it)
            PushNotificationsFirebaseMessagingService.notificationActionService = NotificationActionService(it)
            PushNotificationsFirebaseMessagingService.notificationRegistrationService = NotificationRegistrationService(it)
        }

        println("**************")
        println(deviceInstallationService.playServicesAvailable)

        if (deviceInstallationService.playServicesAvailable) {
            FirebaseMessaging.getInstance().token
                    .addOnCompleteListener(OnCompleteListener { task ->
                        if (!task.isSuccessful)
                            return@OnCompleteListener
                        PushNotificationsFirebaseMessagingService.token = task.result
                        PushNotificationsFirebaseMessagingService.notificationRegistrationService?.refreshRegistration()
                    })
        }

        processNotificationActions(this.intent, true)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        processNotificationActions(intent)
    }

    private fun processNotificationActions(intent: Intent, launchAction: Boolean = false) {
        if (intent.hasExtra("action")) {
            val action = intent.getStringExtra("action");

            if (action!!.isNotEmpty()) {
                if (launchAction) {
                    PushNotificationsFirebaseMessagingService.notificationActionService?.launchAction = action
                } else {
                    PushNotificationsFirebaseMessagingService.notificationActionService?.triggerAction(action)
                }
            }
        }
    }
}

import Foundation

class NotificationRegistrationService {

    let NOTIFICATION_REGISTRATION_CHANNEL = "de.lukasreining.handball_ergebnisse/notifications_registration"
    let REFRESH_REGISTRATION = "refreshRegistration"

    private let notificationRegistrationChannel : FlutterMethodChannel

    init(withBinaryMessenger binaryMessenger : FlutterBinaryMessenger) {
       notificationRegistrationChannel = FlutterMethodChannel(name: NOTIFICATION_REGISTRATION_CHANNEL, binaryMessenger: binaryMessenger)
    }

    func refreshRegistration() {
        notificationRegistrationChannel.invokeMethod(REFRESH_REGISTRATION, arguments: nil)
    }
}

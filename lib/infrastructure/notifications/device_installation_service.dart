import 'package:flutter/services.dart';

class DeviceInstallationService {
  static const deviceInstallation = const MethodChannel(
    'de.lukasreining.handball_ergebnisse/notifications_deviceinstallation',
  );

  static const String getDeviceIdChannelMethod = "getDeviceId";
  static const String getDeviceTokenChannelMethod = "getDeviceToken";
  static const String getDevicePlatformChannelMethod = "getDevicePlatform";

  Future<String> getDeviceId() async {
    final result = await deviceInstallation.invokeMethod<String>(
      getDeviceIdChannelMethod,
    );

    return result!;
  }

  Future<String> getDeviceToken() async {
    final result = await deviceInstallation.invokeMethod<String>(
      getDeviceTokenChannelMethod,
    );

    return result!;
  }

  Future<String> getDevicePlatform() async {
    final result = await deviceInstallation.invokeMethod<String>(
      getDevicePlatformChannelMethod,
    );

    return result!;
  }
}

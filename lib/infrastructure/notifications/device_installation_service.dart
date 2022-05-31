import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

class DeviceInstallationService {
  static const _deviceInstallation = const MethodChannel(
    'de.lukasreining.handball_ergebnisse/notifications_deviceinstallation',
  );

  static const String _getDeviceTokenChannelMethod = "getDeviceToken";
  static const String _getDevicePlatformChannelMethod = "getDevicePlatform";

  Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return info.androidId!;
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return info.identifierForVendor!;
    } else if (Platform.isLinux) {
      final info = await deviceInfo.linuxInfo;
      return info.machineId!;
    } else if (Platform.isMacOS) {
      final info = await deviceInfo.macOsInfo;
      return info.systemGUID!;
    }

    throw UnsupportedError('Unsupported platform');
  }

  Future<String> getDeviceToken() async {
    final result = await _deviceInstallation.invokeMethod<String>(
      _getDeviceTokenChannelMethod,
    );

    return result!;
  }

  Future<String> getDevicePlatform() async {
    final result = await _deviceInstallation.invokeMethod<String>(
      _getDevicePlatformChannelMethod,
    );

    return result!;
  }
}

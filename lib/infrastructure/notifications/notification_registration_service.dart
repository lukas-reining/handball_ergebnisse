import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:handball_ergebnisse/infrastructure/repositories/handballergebnisse/api_http_client.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'device_installation.dart';
import 'device_installation_service.dart';

class NotificationRegistrationService {
  static const _notificationRegistration = const MethodChannel(
      'de.lukasreining.handball_ergebnisse/notifications_registration');

  static const String _refreshRegistrationChannelMethod = "refreshRegistration";
  static const String _cachedDeviceTokenKey = "cached_device_token";
  static const String _cachedTagsKey = "cached_tags";

  final _deviceInstallationService = DeviceInstallationService();
  final _secureStorage = FlutterSecureStorage();

  NotificationRegistrationService() {
    _notificationRegistration
        .setMethodCallHandler(handleNotificationRegistrationCall);
  }

  String get installationsUrl =>
      "${HandballErgebnisseApiHttpClient.BASE_URL}/notifications/installations";

  Future<void> deregisterDevice() async {
    final cachedToken = await _secureStorage.read(key: _cachedDeviceTokenKey);
    final serializedTags = await _secureStorage.read(key: _cachedTagsKey);

    if (cachedToken == null || serializedTags == null) {
      return;
    }

    var deviceId = await _deviceInstallationService.getDeviceId();

    if (deviceId.isEmpty) {
      throw "Unable to resolve an ID for the device.";
    }

    var response = await http.delete(Uri.parse("$installationsUrl/$deviceId"));

    if (response.statusCode != 200) {
      throw "Deregister request failed: ${response.reasonPhrase}";
    }

    await _secureStorage.delete(key: _cachedDeviceTokenKey);
    await _secureStorage.delete(key: _cachedTagsKey);
  }

  Future<void> registerDevice([List<String> tags = const []]) async {
    try {
      final deviceId = await _deviceInstallationService.getDeviceId();
      final platform = await _deviceInstallationService.getDevicePlatform();
      final token = await _deviceInstallationService.getDeviceToken();

      final deviceInstallation = DeviceInstallation(
        deviceId,
        platform,
        token,
        tags,
      );

      final response = await http.post(
        Uri.parse(installationsUrl),
        body: jsonEncode(deviceInstallation),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode != 201) {
        throw "Register request failed: ${response.reasonPhrase}";
      }

      final serializedTags = jsonEncode(tags);

      await _secureStorage.write(key: _cachedDeviceTokenKey, value: token);
      await _secureStorage.write(key: _cachedTagsKey, value: serializedTags);
    } on PlatformException catch (e) {
      print(e);
      throw e;
    } catch (e) {
      throw "Unable to register device: $e";
    }
  }

  Future<void> refreshRegistration() async {
    final currentToken = await _deviceInstallationService.getDeviceToken();
    final cachedToken = await _secureStorage.read(key: _cachedDeviceTokenKey);
    final serializedTags = await _secureStorage.read(key: _cachedTagsKey);

    if (cachedToken == null ||
        serializedTags == null ||
        currentToken == cachedToken) {
      return;
    }

    final tags = jsonDecode(serializedTags).cast<String>();

    return registerDevice(tags);
  }

  Future<bool> isRegistered() async {
    final cachedToken = await _secureStorage.read(key: _cachedDeviceTokenKey);
    return cachedToken != null;
  }

  Future<void> handleNotificationRegistrationCall(MethodCall call) async {
    switch (call.method) {
      case _refreshRegistrationChannelMethod:
        return refreshRegistration();
      default:
        throw MissingPluginException();
        break;
    }
  }
}

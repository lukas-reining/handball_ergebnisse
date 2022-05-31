import 'package:flutter/services.dart';
import 'dart:async';

class NotificationActionService {
  static const _notificationAction = const MethodChannel(
      'de.lukasreining.handball_ergebnisse/notifications_action');
  static const String _triggerActionChannelMethod = "triggerAction";
  static const String _getLaunchActionChannelMethod = "getLaunchAction";

  final _actionTriggeredController = StreamController.broadcast();

  NotificationActionService() {
    _notificationAction.setMethodCallHandler(_handleNotificationActionCall);
  }

  Stream get actionTriggered => _actionTriggeredController.stream;

  Future<void> _triggerAction({action: String}) async {
    _actionTriggeredController.add(action);
  }

  Future<void> checkLaunchAction() async {
    final launchAction = await _notificationAction
        .invokeMethod<String>(_getLaunchActionChannelMethod);

    if (launchAction != null) {
      _triggerAction(action: launchAction);
    }
  }

  Future<void> _handleNotificationActionCall(MethodCall call) async {
    switch (call.method) {
      case _triggerActionChannelMethod:
        return _triggerAction(action: call.arguments as String);
      default:
        throw MissingPluginException();
        break;
    }
  }
}

import 'package:flutter/services.dart';
import 'dart:async';

import 'notification_action.dart';

class NotificationActionService {
  static const notificationAction = const MethodChannel(
      'de.lukasreining.handball_ergebnisse/notifications_action');
  static const String triggerActionChannelMethod = "triggerAction";
  static const String getLaunchActionChannelMethod = "getLaunchAction";

  final actionMappings = {
    'action_a': NotificationAction.actionA,
    'action_b': NotificationAction.actionB
  };

  final actionTriggeredController = StreamController.broadcast();

  NotificationActionService() {
    notificationAction.setMethodCallHandler(handleNotificationActionCall);
  }

  Stream get actionTriggered => actionTriggeredController.stream;

  Future<void> triggerAction({action: String}) async {
    if (!actionMappings.containsKey(action)) {
      return;
    }

    actionTriggeredController.add(actionMappings[action]);
  }

  Future<void> checkLaunchAction() async {
    final launchAction = await notificationAction
        .invokeMethod<String>(getLaunchActionChannelMethod);

    if (launchAction != null) {
      triggerAction(action: launchAction);
    }
  }

  Future<void> handleNotificationActionCall(MethodCall call) async {
    switch (call.method) {
      case triggerActionChannelMethod:
        return triggerAction(action: call.arguments as String);
      default:
        throw MissingPluginException();
        break;
    }
  }
}

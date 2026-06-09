import 'package:flutter/foundation.dart';

class NotificationService {
  static Future<void> initialize() async {
    debugPrint(
      '[NotificationService] Initialized',
    );
  }

  static Future<void> requestPermission() async {
    debugPrint(
      '[NotificationService] Permission Requested',
    );
  }

  static Future<void> showLocalNotification({
    required String title,
    required String body,
  }) async {
    debugPrint(
      '[Notification] $title - $body',
    );
  }

  static Future<void> subscribeToAuthorityAlerts() async {
    debugPrint(
      '[NotificationService] Authority Alerts Subscription Ready',
    );
  }
}

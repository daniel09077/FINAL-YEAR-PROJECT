import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final _messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    // Request permissions on iOS
    await _messaging.requestPermission();

    // Get token (for future use)
    final token = await _messaging.getToken();
    debugPrint("FCM Token: $token");

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        debugPrint("Foreground Message: ${message.notification!.title}");
      }
    });

    // Handle background tap/open
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("Notification clicked: ${message.notification?.title}");
      // TODO: Navigate to detail screen if needed
    });
  }
}

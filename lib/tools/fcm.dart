import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:odm/utils/print.dart';

class FireBaseMessage {
  static final FireBaseMessage _instance = FireBaseMessage._internal();

  factory FireBaseMessage() => _instance;
  FireBaseMessage._internal() {
    init();
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void init() async {
    final token = await FirebaseMessaging.instance.getToken();
    Print.i("FCM Token: $token");

    if (Platform.isIOS) {
      await requestPermission();
    }
    _addListener();
  }

  void _addListener() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_firebaseMessagingForgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    Print.i("Handling a background message: ${message.notification?.title}");
  }

  Future<void> _firebaseMessagingForgroundHandler(RemoteMessage message) async {
    Print.i("Handling a foreGround message: ${message.notification?.title}");
  }

  Future requestPermission() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      Print.i('User granted permission');
    } else {
      Print.i('User declined or has not accepted permission');
    }
  }
}

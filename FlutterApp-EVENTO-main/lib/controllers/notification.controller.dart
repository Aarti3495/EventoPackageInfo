import 'package:evento_package/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<String> getFCMToken() async {
      _firebaseMessaging.requestPermission();
    final fcmToken =
        await _firebaseMessaging.getToken().then((token) => token!);
    print("FCM Token ====== $fcmToken");
    return fcmToken;
  }

  void onMessageListener() =>
      FirebaseMessaging.onMessage.listen(showNotification);

  void onMessageOpenAppListener() =>
      FirebaseMessaging.onMessageOpenedApp.listen(showNotification);

  void showNotification(RemoteMessage event) {
    RemoteNotification? notification = event.notification!;
    AndroidNotification? android = event.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            color: Colors.blue,
            channelDescription: channel.description,
            playSound: true,
            icon: '@drawable/ic_notification',
          ),
        ),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings("ic_launcher_foreground");

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  logger.d("Notification has been initialize");
}

Future<void> showNotificacion({String channelId = 'default', String channelName = 'default', required String  title, required String content, required int id }) async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    "default",
    'default',
    importance: Importance.low,
    priority: Priority.low,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  await flutterLocalNotificationsPlugin.show(
      id,
      title,
      content,
      notificationDetails);
}
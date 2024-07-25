import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uuid/uuid.dart';


String generateOrderId() {
  const uuid = Uuid();
  return uuid.v4(); // Generate a random UUID
}

Color convertStringToColor(String hexColor) {
  // String hexColor = "#567890";
  Color color =
      Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
  return color;
}

pushAndRemoveUntil(context, screenName){
   Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => screenName),
    (route) => false,
  );
}

void showLocalNotification(
  String? channelId,
  String? title,
  String? body,
  BigTextStyleInformation? bigTextStyleInformation,
) {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    channelId ?? "1001",
    'EatEasyChannel',
    channelDescription: 'channel_description',
    importance: Importance.high,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
    showWhen: false,
    playSound: true,
    styleInformation: bigTextStyleInformation,
  );
  NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  FlutterLocalNotificationsPlugin().show(
    0,
    title,
    body,
    platformChannelSpecifics,
  );
}
String generateStaticId() {
  const uuid = Uuid();
  return uuid.v4();
}

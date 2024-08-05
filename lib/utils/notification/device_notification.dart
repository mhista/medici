import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/providers.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../features/call/controllers/call_controller.dart';

class NotificationService {
  final Ref ref;
  NotificationService({required this.ref}) {
    initialize();
  }

  // get an instance of the notification plugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // initialize the notifications plugin
  Future<void> initialize() async {
    // define the android initializaation setings
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    // define the Ios initialization settings
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();

    // combine the two initializations
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    // INITIALIZE THE PLUGIN WITH THE SPECIFIED SETTINGS
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );

    // request permission for android
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  // static final NotificationResponse notificationResponse =
  // notification to run when the notification is shown in background activity
  static Future<void> onDidReceiveBackgroundNotificationResponse(
      NotificationResponse response) async {
    // return response;
    debugPrint(response.payload);
  }

  // notification to run when the notification runs during app activity
  @pragma('vm:entry-point')
  Future<void> onDidReceiveNotificationResponse(
      NotificationResponse response) async {
    // debugPrint(response.payload);
    final id = response.id.toString();
    final actionId = response.actionId;

    debugPrint(response.actionId);
    if (id == '1') {
      ref.read(callController).goToCallScreen(response);
    }
  }

  // show an instant notification
  Future<void> showInstantNotification(
      {required String title,
      required String body,
      String? payload,
      String? channelName,
      String? channelId,
      String? description,
      String? category,
      required bool ongoing,
      int timeOutAfter = 5000,
      required String actionId,
      required int notificationId,
      List<AndroidNotificationAction>? notificationActions}) async {
    // Define Notification details
    NotificationDetails platformSpecificNotification = NotificationDetails(
        android: AndroidNotificationDetails("call_id", "channel_name",
            importance: Importance.max,
            priority: Priority.high,
            timeoutAfter: timeOutAfter,
            ongoing: ongoing,
            actions: notificationActions),
        iOS: const DarwinNotificationDetails());
    await flutterLocalNotificationsPlugin.show(
        notificationId, title, body, platformSpecificNotification,
        payload: payload);
  }

  // schedule the notification for the
  Future<void> scheduleNotification(
      String title, String body, DateTime scheduledDate) async {
    // Define Notification details
    const NotificationDetails platformSpecificNotification =
        NotificationDetails(
            android: AndroidNotificationDetails(
              "channel_id",
              "channel_name",
              importance: Importance.high,
              priority: Priority.high,
            ),
            iOS: DarwinNotificationDetails());
    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        platformSpecificNotification,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime);
  }
}

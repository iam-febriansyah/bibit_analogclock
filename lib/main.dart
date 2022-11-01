import 'package:analogclock_febriansyah/helpers/notification_helper.dart';
import 'package:analogclock_febriansyah/pages/page_splashscreen.dart';
import 'package:analogclock_febriansyah/sqlite/db.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    // This task has exceeded its allowed running-time.
    // You must stop what you're doing and immediately .finish(taskId)
    print("[BackgroundFetch] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }
  print('[BackgroundFetch] Headless event received.');
  // Do your work here...
  BackgroundFetch.finish(taskId);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbModel().initializeDB();
  runApp(const MyApp());
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final NotificationHelper notificationHelper = NotificationHelper();
  notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const PageSplashScreen(),
      debugShowCheckedModeBanner: false,
      title: "Analog Clock",
      theme: ThemeData(
          fontFamily: 'Poppins-Regular', applyElevationOverlayColor: true),
    );
  }
}

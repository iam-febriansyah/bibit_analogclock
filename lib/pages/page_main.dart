import 'dart:async';

import 'package:analogclock_febriansyah/controllers/ctrl_alarm.dart';
import 'package:analogclock_febriansyah/helpers/notification_helper.dart';
import 'package:analogclock_febriansyah/pages/add_alarm.dart';
import 'package:analogclock_febriansyah/pages/page_alarm.dart';
import 'package:analogclock_febriansyah/pages/widgets/w_jam.dart';
import 'package:analogclock_febriansyah/sqlite/db.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CtrlAlarm ctrlAlarm = Get.put(CtrlAlarm());

  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[Jam(), PageAlarm()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    await BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 15,
            stopOnTerminate: true,
            enableHeadless: true,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: NetworkType.NONE), (String taskId) async {
      print("[BackgroundFetch] Event received $taskId");
      Tbl_alarm data = Tbl_alarm();
      data.DAY = "";
      data.DESC = "A";
      data.TIME = "09:00";
      var result = await ctrlAlarm.addAlarm(data);
      showAlarmNotif();
      BackgroundFetch.finish(taskId);
    }, (String taskId) async {
      BackgroundFetch.finish(taskId);
    });
    if (!mounted) return;
  }

  showAlarmNotif() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    String now = DateFormat('HH:mm:ss').format(DateTime.now());
    print(now);
    var product = await Tbl_alarm().select().TIME.equals(now).toSingle();

    if (product != null) {
      final NotificationHelper notificationHelper = NotificationHelper();
      var title = product.DESC!.toUpperCase();
      var body = "Hayuuk bangun, sudah jam ${product.TIME!}";
      await notificationHelper.showNotification(
        title,
        body,
        product.TIME!,
        flutterLocalNotificationsPlugin,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      showAlarmNotif();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analog Clock"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white,
            onPressed: () async {
              Get.to(const PageAddAlarm());
            },
          ),
        ],
        elevation: 0,
      ),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.punch_clock),
            label: 'Jam',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_add),
            label: 'Alarm',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

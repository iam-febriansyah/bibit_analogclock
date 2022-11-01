import 'dart:async';

import 'package:analogclock_febriansyah/controllers/ctrl_alarm.dart';
import 'package:analogclock_febriansyah/pages/page_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageSplashScreen extends StatefulWidget {
  const PageSplashScreen({super.key});

  @override
  State<PageSplashScreen> createState() => _PageSplashScreenState();
}

class _PageSplashScreenState extends State<PageSplashScreen> {
  CtrlAlarm ctrlAlarm = Get.put(CtrlAlarm());
  String TAG = "BackGround_Work";

  getData() async {
    //SET YOUR WAITING DURATION BEFORE MOVE TO MAIN PAGE
    var duration = const Duration(seconds: 3);
    Timer(duration, () {
      //SET YOUR LOGIC BEFORE MOVE, LIKE SET SESSION OR WHAT EVER YU WANT
      Get.offAll(const MainPage(),
          transition: Transition.zoom, duration: const Duration(seconds: 1));
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: Get.height * 1,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(42),
            child: Center(
              child: Image.asset(
                "assets/images/clock.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

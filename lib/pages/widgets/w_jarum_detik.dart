import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JarumDetik extends StatefulWidget {
  const JarumDetik({super.key});

  @override
  State<JarumDetik> createState() => _JarumDetikState();
}

class _JarumDetikState extends State<JarumDetik> {
  var angleSecond = 97.39;
  var _angleDelta = 0.0;
  var _oldAngle = 0.0;
  Offset centerOfGestureDetector = const Offset(0, 34);
  var height = Get.size.height * 1;
  var second = DateTime.now().second.toDouble();
  var width = Get.size.width * 1;
  bool isPortait = true;

  getData() {
    final second = DateTime.now().second.toDouble();
    // angleSecond = (-pi * (second / -60)) * 2;
    print("DETIK KE " + second.toString() + " " + angleSecond.toString());
    isPortait = height > width;
  }

  @override
  void initState() {
    super.initState();

    // Timer.periodic(new Duration(seconds: 1), (timer) {
    getData();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 2,
      child: Transform.rotate(
        angle: angleSecond,
        child: Transform.translate(
          offset: centerOfGestureDetector,
          child: Center(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onPanStart: (details) {
                final touchPositionFromCenter =
                    details.localPosition - centerOfGestureDetector;
                _angleDelta = _oldAngle - touchPositionFromCenter.direction;
                print("details.localPosition : " +
                    details.localPosition.toString());
                print("_angleDelta : " + _angleDelta.toString());
              },
              onPanEnd: (details) {
                setState(() {
                  _oldAngle = angleSecond;
                });
              },
              onPanUpdate: (details) {
                var data = details.localPosition.distanceSquared;
                print(data.toString());
                final touchPositionFromCenter =
                    details.localPosition - centerOfGestureDetector;
                print("details : " + details.localPosition.toString());
                print("touchPositionFromCenter : " +
                    touchPositionFromCenter.toString());
                print("touchPositionFromCenter.direction : " +
                    touchPositionFromCenter.direction.toString());
                print("_angleDelta : " + _angleDelta.toString());
                setState(() {
                  var temp = touchPositionFromCenter.direction + _angleDelta;
                  print("Update OLD : " + temp.toString());

                  var center = touchPositionFromCenter;
                  var radius = min(center.dx, center.dy);
                  print(radius.toString());
                  var x1 = center.dx + radius * cos(1 * pi / 180);
                  print(x1.toString());

                  // double minutes = 60;
                  // if (temp != 0.0 && (temp > 0 && temp < 6.2)) {
                  //   if (temp < 0) {
                  //     minutes = -60;
                  //   }
                  //   //find hour = (minutes/2) / (newSecond/pi)
                  //   angleSecond = (minutes / 2) / (temp / pi);
                  // } else {
                  angleSecond = temp;
                  // }

                  // ignore: avoid_print
                  print("Update AFTER : " + angleSecond.toString());
                });
              },
              child: Container(
                height: isPortait ? height * 0.15 : width * 0.10,
                width: 5,
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

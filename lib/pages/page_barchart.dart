import 'package:d_chart/d_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PageBarChart extends StatefulWidget {
  final String timeAlarm;

  const PageBarChart({Key? key, required this.timeAlarm}) : super(key: key);

  @override
  State<PageBarChart> createState() => _PageBarChartState();
}

class _PageBarChartState extends State<PageBarChart> {
  bool loading = true;
  var hourNow = "0";
  var minuteNow = "0";
  var secondNow = "0";

  var hourAlarm = 0;
  var minuteAlarm = 0;
  var secondAlarm = 0;

  getData() {
    var alarm = widget.timeAlarm.split(":");
    setState(() {
      hourNow = DateFormat('HH').format(DateTime.now());
      minuteNow = DateFormat('mm').format(DateTime.now());
      secondNow = DateFormat('ss').format(DateTime.now());
      hourAlarm = int.parse(alarm[0]);
      minuteAlarm = int.parse(alarm[1]);
      secondAlarm = int.parse(alarm[2]);
      loading = false;
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
      appBar: AppBar(
        title: const Text("Alarm Now"),
        elevation: 0,
      ),
      body: Center(
        child: loading
            ? const CupertinoActivityIndicator()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: Get.height * 0.5,
                      child: DChartBar(
                        data: [
                          {
                            'id': 'Bar',
                            'data': [
                              {'domain': hourNow, 'measure': hourAlarm},
                              {'domain': minuteNow, 'measure': minuteAlarm},
                              {'domain': secondNow, 'measure': secondAlarm},
                            ],
                          },
                        ],
                        domainLabelPaddingToAxisLine: 16,
                        axisLineTick: 2,
                        axisLinePointTick: 2,
                        axisLinePointWidth: 10,
                        axisLineColor: Colors.green,
                        measureLabelPaddingToAxisLine: 16,
                        barColor: (barData, index, id) => Colors.green,
                        showBarValue: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text("WAKTU SEKARANG :  "),
                        Text("${hourNow}:${minuteNow}:${secondNow}")
                      ],
                    ),
                    Row(
                      children: [
                        const Text("WAKTU ALARM :  "),
                        Text("${hourAlarm}:${minuteAlarm}:${secondAlarm}")
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

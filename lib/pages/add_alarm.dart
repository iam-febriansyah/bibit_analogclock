// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:analogclock_febriansyah/controllers/ctrl_alarm.dart';
import 'package:analogclock_febriansyah/sqlite/db.dart';
import 'package:analogclock_febriansyah/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class PageAddAlarm extends StatefulWidget {
  const PageAddAlarm({super.key});

  @override
  State<PageAddAlarm> createState() => _PageAddAlarmState();
}

class _PageAddAlarmState extends State<PageAddAlarm> {
  CtrlAlarm ctrlAlarm = Get.put(CtrlAlarm());
  TextEditingController ctrlName = TextEditingController();
  TextEditingController ctrlTime = TextEditingController();

  void dismisKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  void submit() async {
    if (mounted) ToastContext().init(context);
    if (ctrlName.text == '') {
      Toast.show("Please enter alarm name", duration: 4, gravity: Toast.bottom);
    } else {
      if (ctrlTime.text == '') {
        Toast.show("Please enter your alarm time",
            duration: 4, gravity: Toast.bottom);
      } else {
        Tbl_alarm data = Tbl_alarm();
        data.DAY = "";
        data.DESC = ctrlName.text;
        data.TIME = ctrlTime.text;
        var result = await ctrlAlarm.addAlarm(data);
        if (result.status) {
          ctrlName.text = '';
          ctrlTime.text = '';
        }
        Toast.show(result.remarks, duration: 4, gravity: Toast.bottom);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Alarm"),
        elevation: 0,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            dismisKeyboard();
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: ColorsTheme.grey,
              child: Container(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: TextFormField(
                  controller: ctrlName,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    hintText: "Your alarm name",
                    border: InputBorder.none,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: ColorsTheme.grey,
              child: GestureDetector(
                onTap: () {
                  dismisKeyboard();
                  showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext builder) {
                        String jam = DateFormat('HH').format(DateTime.now());
                        String menit = DateFormat('mm').format(DateTime.now());
                        String detik = DateFormat('ss').format(DateTime.now());
                        Duration initialtimer = Duration(
                            hours: int.parse(jam),
                            minutes: int.parse(menit),
                            seconds: int.parse(detik));

                        return Container(
                          height: 200,
                          color: Colors.white,
                          child: CupertinoTimerPicker(
                            mode: CupertinoTimerPickerMode.hms,
                            minuteInterval: 1,
                            secondInterval: 1,
                            initialTimerDuration: initialtimer,
                            onTimerDurationChanged: (Duration value) {
                              var jamSelected =
                                  value.toString().replaceAll(".000000", "");
                              if (jamSelected.length == 7) {
                                jamSelected = "0${jamSelected}";
                              }
                              setState(() {
                                ctrlTime.text = jamSelected;
                              });
                            },
                          ),
                        );
                      });
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: TextFormField(
                    controller: ctrlTime,
                    enabled: false,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      hintText: "Set Your Time",
                      border: InputBorder.none,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: Get.size.width * 1,
              child: ElevatedButton(
                onPressed: () async {
                  if (!ctrlAlarm.loadingSubmit) {
                    if (mounted) ToastContext().init(context);
                    dismisKeyboard();
                    submit();
                  }
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(ColorsTheme.primary1),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: Text(
                    ctrlAlarm.loadingSubmit ? "Saving..." : "SAVE",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget pageRequest(BuildContext context) {
    return Card(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 4, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                      width: 150,
                      child: Text("NAME", style: TextStyle(fontSize: 14))),
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: ctrlName,
                          decoration:
                              const InputDecoration.collapsed(hintText: '____'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            jamPicker('dari'),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 4, left: 8, right: 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    dismisKeyboard();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorsTheme.primary1),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: Text(
                      "SIMPAN",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget jamPicker(dariSampai) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, left: 8, right: 8),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              dismisKeyboard();
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext builder) {
                    return Container(
                      height: 200,
                      color: Colors.white,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        use24hFormat: true,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (value) {
                          DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss")
                              .parse(value.toString());
                          String jamSelected =
                              DateFormat('HH:mm').format(tempDate);
                          setState(() {});
                        },
                      ),
                    );
                  });
            },
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Expanded(
            //         child: Text(dariSampai == 'dari' ? jamDari : jamSampai)),
            //     const Icon(
            //       Icons.timer,
            //       color: ColorsTheme.primary1,
            //     )
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}

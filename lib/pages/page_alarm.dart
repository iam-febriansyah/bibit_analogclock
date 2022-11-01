import 'package:analogclock_febriansyah/controllers/ctrl_alarm.dart';
import 'package:analogclock_febriansyah/pages/edit_alarm.dart';
import 'package:analogclock_febriansyah/sqlite/db.dart';
import 'package:analogclock_febriansyah/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageAlarm extends StatefulWidget {
  const PageAlarm({super.key});

  @override
  State<PageAlarm> createState() => _PageAlarmState();
}

class _PageAlarmState extends State<PageAlarm> {
  CtrlAlarm ctrlAlarm = Get.put(CtrlAlarm());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CtrlAlarm>(builder: (_c) {
      return _c.loadingList
          ? Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Center(child: CupertinoActivityIndicator()),
              ],
            )
          : SingleChildScrollView(
              child: ListView.builder(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.03, right: Get.width * 0.03),
                  shrinkWrap: true,
                  itemCount: _c.listAlarm.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Tbl_alarm item = _c.listAlarm[index];
                    return InkWell(
                        onTap: () async {
                          await Get.to(PageEditAlarm(data: item));
                        },
                        child: newCardHistory(item));
                  }),
            );
    });
  }

  Widget newCardHistory(Tbl_alarm item) {
    // String status = "";
    // String time = "";
    // String name = "";
    // Color? colorBorder;
    // Color? colorText;

    // if (item.STATUS == true) {
    //   status = "ACTIVE";
    //   colorBorder = ColorsTheme.primary1;
    //   colorText = ColorsTheme.primary1;
    // } else {
    //   status = "NOT ACTIVVE";
    //   colorBorder = Colors.red;
    //   colorText = Colors.red;
    // }
    return Card(
        elevation: 0.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.DESC!,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: ColorsTheme.primary1,
                              fontSize: Get.width * 0.05,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          item.TIME!,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: ColorsTheme.primary1,
                              fontSize: Get.width * 0.075),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

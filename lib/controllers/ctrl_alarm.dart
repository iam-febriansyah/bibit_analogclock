import 'package:analogclock_febriansyah/models/mdl_general.dart';
import 'package:analogclock_febriansyah/sqlite/db.dart';
import 'package:get/get.dart';

class CtrlAlarm extends GetxController {
  bool loadingList = false;
  bool errorList = false;
  String remarkList = "";

  bool loadingSubmit = false;
  bool errorSubmit = false;
  String remarkSubmit = "";

  List<Tbl_alarm> listAlarm = [];

  Future<ModelGeneral> getAlarm() async {
    loadingList = true;
    errorList = false;
    remarkList = "";
    update();
    try {
      listAlarm = await Tbl_alarm().select().toList();
      // await Tbl_alarm().select().delete();
      if (listAlarm.isEmpty) {
        remarkList = "Data Not Found!";
      }
      remarkList = "Succesfully";
    } catch (e) {
      errorList = true;
      remarkList = e.toString();
    }
    loadingList = false;
    update();
    return ModelGeneral(status: !errorSubmit, remarks: remarkSubmit);
  }

  Future<ModelGeneral> addAlarm(Tbl_alarm data) async {
    loadingSubmit = true;
    errorSubmit = false;
    remarkSubmit = "";
    update();
    try {
      final alarm = Tbl_alarm();
      alarm.DESC = data.DESC;
      alarm.TIME = data.TIME;
      alarm.STATUS = true;
      alarm.DAY = data.DAY;
      await alarm.save();
      remarkSubmit = "Succesfully";
      await getAlarm();
    } catch (e) {
      errorSubmit = true;
      remarkSubmit = e.toString();
    }
    loadingSubmit = false;

    update();
    return ModelGeneral(status: !errorSubmit, remarks: remarkSubmit);
  }

  Future<ModelGeneral> updateAlarm(Tbl_alarm data) async {
    loadingSubmit = true;
    errorSubmit = false;
    remarkSubmit = "";
    update();
    try {
      await Tbl_alarm().select().ROWID.equals(data.ROWID).update(
          {"STATUS": data.STATUS, "DESC": data.DESC, "TIME": data.TIME});
      remarkSubmit = "Succesfully";
      await getAlarm();
    } catch (e) {
      errorSubmit = true;
      remarkSubmit = e.toString();
    }
    loadingSubmit = false;
    update();
    return ModelGeneral(status: !errorSubmit, remarks: remarkSubmit);
  }

  Future<ModelGeneral> deleteAram(id) async {
    loadingSubmit = true;
    errorSubmit = false;
    remarkSubmit = "";
    update();
    try {
      await Tbl_alarm().select().ROWID.equals(id).delete();
      remarkSubmit = "Succesfully";
      await getAlarm();
    } catch (e) {
      errorSubmit = true;
      remarkSubmit = e.toString();
    }
    loadingSubmit = false;
    update();
    return ModelGeneral(status: !errorSubmit, remarks: remarkSubmit);
  }

  @override
  void onInit() async {
    super.onInit();
    await getAlarm();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

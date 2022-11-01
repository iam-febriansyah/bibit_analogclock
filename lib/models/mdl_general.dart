// To parse this JSON data, do
//
//     final modelGeneral = modelGeneralFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ModelGeneral modelGeneralFromJson(String str) =>
    ModelGeneral.fromJson(json.decode(str));

String modelGeneralToJson(ModelGeneral data) => json.encode(data.toJson());

class ModelGeneral {
  ModelGeneral({
    required this.status,
    required this.remarks,
  });

  bool status;
  String remarks;

  factory ModelGeneral.fromJson(Map<String, dynamic> json) => ModelGeneral(
        status: json["status"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "remarks": remarks,
      };
}

// To parse this JSON data, do
//
//     final changePasswordModel = changePasswordModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordModel changePasswordModelFromJson(String str) => ChangePasswordModel.fromJson(json.decode(str));

String changePasswordModelToJson(ChangePasswordModel data) => json.encode(data.toJson());

class ChangePasswordModel {
  final List<FitnessApp> fitnessApp;

  const ChangePasswordModel({required this.fitnessApp});

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) => ChangePasswordModel(fitnessApp: List<FitnessApp>.from(json["FITNESS_APP"].map((x) => FitnessApp.fromJson(x))));

  Map<String, dynamic> toJson() => {"FITNESS_APP": List<dynamic>.from(fitnessApp.map((x) => x.toJson()))};
}

class FitnessApp {
  final String msg;
  final String success;

  const FitnessApp({required this.msg, required this.success});

  factory FitnessApp.fromJson(Map<String, dynamic> json) => FitnessApp(msg: json["msg"], success: json["success"]);

  Map<String, dynamic> toJson() => {"msg": msg, "success": success};
}

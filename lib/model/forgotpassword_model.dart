// To parse this JSON data, do
//
//     final forgotPassWordModel = forgotPassWordModelFromJson(jsonString);

import 'dart:convert';

ForgotPassWordModel forgotPassWordModelFromJson(String str) => ForgotPassWordModel.fromJson(json.decode(str));

String forgotPassWordModelToJson(ForgotPassWordModel data) => json.encode(data.toJson());

class ForgotPassWordModel {
  ForgotPassWordModel({
   required this.fitnessApp,
  });

  final List<FitnessApp> fitnessApp;

  factory ForgotPassWordModel.fromJson(Map<String, dynamic> json) => ForgotPassWordModel(
    fitnessApp: List<FitnessApp>.from(json["FITNESS APP"].map((x) => FitnessApp.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "FITNESS APP": List<dynamic>.from(fitnessApp.map((x) => x.toJson())),
  };
}

class FitnessApp {
  FitnessApp({
   required this.msg,
   required this.success,
  });

  final String msg;
  final String success;

  factory FitnessApp.fromJson(Map<String, dynamic> json) => FitnessApp(
    msg: json["msg"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "success": success,
  };
}

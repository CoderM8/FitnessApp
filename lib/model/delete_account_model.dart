// To parse this JSON data, do
//
//     final deleteAccount = deleteAccountFromJson(jsonString);

import 'dart:convert';

DeleteAccount deleteAccountFromJson(String str) => DeleteAccount.fromJson(json.decode(str));

String deleteAccountToJson(DeleteAccount data) => json.encode(data.toJson());

class DeleteAccount {
  final List<FitnessApp> fitnessApp;

  const DeleteAccount({required this.fitnessApp});

  factory DeleteAccount.fromJson(Map<String, dynamic> json) => DeleteAccount(
        fitnessApp: List<FitnessApp>.from(json["FITNESS_APP"].map((x) => FitnessApp.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {"FITNESS_APP": List<dynamic>.from(fitnessApp.map((x) => x.toJson()))};
}

class FitnessApp {
  final String msg;
  final String success;

  const FitnessApp({required this.msg, required this.success});

  factory FitnessApp.fromJson(Map<String, dynamic> json) => FitnessApp(msg: json["msg"], success: json["success"]);

  Map<String, dynamic> toJson() => {"msg": msg, "success": success};
}

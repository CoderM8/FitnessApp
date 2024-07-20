// To parse this JSON data, do
//
//     final buySubscriptionModel = buySubscriptionModelFromJson(jsonString);

import 'dart:convert';

BuySubscriptionModel buySubscriptionModelFromJson(String str) => BuySubscriptionModel.fromJson(json.decode(str));

String buySubscriptionModelToJson(BuySubscriptionModel data) => json.encode(data.toJson());

class BuySubscriptionModel {
  BuySubscriptionModel({required this.fitnessApp});

  final List<FitnessApp> fitnessApp;

  factory BuySubscriptionModel.fromJson(Map<String, dynamic> json) => BuySubscriptionModel(
        fitnessApp: List<FitnessApp>.from(json["FITNESS_APP"].map((x) => FitnessApp.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {"FITNESS_APP": List<dynamic>.from(fitnessApp.map((x) => x.toJson()))};
}

class FitnessApp {
  const FitnessApp({required this.msg, required this.success});

  final String msg;
  final String success;

  factory FitnessApp.fromJson(Map<String, dynamic> json) => FitnessApp(msg: json["msg"], success: json["success"]);

  Map<String, dynamic> toJson() => {"msg": msg, "success": success};
}

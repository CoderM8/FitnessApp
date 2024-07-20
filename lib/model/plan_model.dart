// To parse this JSON data, do
//
//     final activeSubscriptionPlanModel = activeSubscriptionPlanModelFromJson(jsonString);

import 'dart:convert';

List<PlanModel> planModelFromJson(String str) => List<PlanModel>.from(json.decode(str).map((x) => PlanModel.fromJson(x)));

String planModelToJson(List<PlanModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlanModel {
  PlanModel({
    required this.id,
    required this.planName,
    required this.planDuration,
    required this.planType,
    required this.planPrice,
    required this.planDescription,
    required this.status,
  });

  final String id;
  final String planName;
  final String planDuration;
  final String planType;
  final String planPrice;
  final String planDescription;
  final String status;

  factory PlanModel.fromJson(Map<String, dynamic> json) => PlanModel(
    id: json["id"],
    planName: json["plan_name"],
    planDuration: json["plan_duration"],
    planType: json["plan_type"],
    planPrice: json["plan_price"],
    planDescription: json["plan_description"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "plan_name": planName,
    "plan_duration": planDuration,
    "plan_type": planType,
    "plan_price": planPrice,
    "plan_description": planDescription,
    "status": status,
  };
}

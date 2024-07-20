// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  final List<FitnessApp> fitnessApp;

  RegisterModel({required this.fitnessApp});

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(fitnessApp: List<FitnessApp>.from(json["FITNESS APP"].map((x) => FitnessApp.fromJson(x))));

  Map<String, dynamic> toJson() => {"FITNESS APP": List<dynamic>.from(fitnessApp.map((x) => x.toJson()))};
}

class FitnessApp {
  final String userId;
  final String name;
  final String email;
  final String msg;
  final String authId;
  final String success;
  final String userImage;
  final String age;
  final String weight;
  final String height;
  final String weightType;
  final String heightType;
  final String catId;
  final String goalWeight;
  final String goals;
  final String status;

  FitnessApp({
    required this.userId,
    required this.name,
    required this.email,
    required this.msg,
    required this.authId,
    required this.success,
    required this.userImage,
    required this.age,
    required this.weight,
    required this.height,
    required this.weightType,
    required this.heightType,
    required this.catId,
    required this.goalWeight,
    required this.goals,
    required this.status,
  });

  factory FitnessApp.fromJson(Map<String, dynamic> json) => FitnessApp(
        userId: json["user_id"] ?? "",
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        msg: json["MSG"] ?? "",
        authId: json["auth_id"] ?? "",
        success: json["success"] ?? "",
        userImage: json["user_image"] ?? "",
        age: json["age"] ?? "",
        weight: json["weight"] ?? "",
        height: json["height"] ?? "",
        weightType: json["weight_type"] ?? "",
        heightType: json["height_type"] ?? "",
        catId: json["cat_id"] ?? "",
        goalWeight: json["goalWeight"] ?? "",
        goals: json["goals"] ?? "",
        status: json["status"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "email": email,
        "MSG": msg,
        "auth_id": authId,
        "success": success,
        "user_image": userImage,
        "age": age,
        "weight": weight,
        "height": height,
        "weight_type": weightType,
        "height_type": heightType,
        "cat_id": catId,
        "goalWeight": goalWeight,
        "goals": goals,
        "status": status,
      };
}

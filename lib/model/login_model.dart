// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final List<FitnessApp> fitnessApp;

  const LoginModel({required this.fitnessApp});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(fitnessApp: List<FitnessApp>.from(json["FITNESS APP"].map((x) => FitnessApp.fromJson(x))));

  Map<String, dynamic> toJson() => {"FITNESS APP": List<dynamic>.from(fitnessApp.map((x) => x.toJson()))};
}

class FitnessApp {
  final String userId;
  final String name;
  final String userImage;
  final String email;
  final String phone;
  final String msg;
  final String success;
  final String age;
  final String weight;
  final String height;
  final String goals;
  final String weightType;
  final String heightType;
  final String catId;
  final String goalWeight;
  final String status;

  FitnessApp({
    required this.userId,
    required this.name,
    required this.userImage,
    required this.email,
    required this.phone,
    required this.msg,
    required this.success,
    required this.age,
    required this.weight,
    required this.height,
    required this.goals,
    required this.weightType,
    required this.heightType,
    required this.catId,
    required this.goalWeight,
    required this.status,
  });

  factory FitnessApp.fromJson(Map<String, dynamic> json) => FitnessApp(
        userId: json["user_id"] ?? "",
        name: json["name"] ?? "",
        userImage: json["user_image"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        msg: json["MSG"] ?? "",
        success: json["success"] ?? "",
        age: json["age"] ?? "",
        weight: json["weight"] ?? "",
        height: json["height"] ?? "",
        goals: json["goals"] ?? "",
        weightType: json["weight_type"] ?? "",
        heightType: json["height_type"] ?? "",
        catId: json["cat_id"] ?? "",
        goalWeight: json["goalWeight"] ?? "",
        status: json["status"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "user_image": userImage,
        "email": email,
        "phone": phone,
        "MSG": msg,
        "success": success,
        "age": age,
        "weight": weight,
        "height": height,
        "goals": goals,
        "weight_type": weightType,
        "height_type": heightType,
        "cat_id": catId,
        "goalWeight": goalWeight,
        "status": status,
      };
}

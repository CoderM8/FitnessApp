// To parse this JSON data, do

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
  final List<FitnessApp> fitnessApp;

  UserProfileModel({required this.fitnessApp});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(fitnessApp: List<FitnessApp>.from(json["FITNESS APP"].map((x) => FitnessApp.fromJson(x))));

  Map<String, dynamic> toJson() => {"FITNESS APP": List<dynamic>.from(fitnessApp.map((x) => x.toJson()))};
}

class FitnessApp {
  final String id;
  final String name;
  final String userImage;
  final String email;
  final String phone;
  final String success;
  final String age;
  final String weight;
  final String userHeight;
  final String weightType;
  final String heightType;
  final String catId;
  final String goalWeight;
  final String goals;

  FitnessApp({
    required this.id,
    required this.name,
    required this.userImage,
    required this.email,
    required this.phone,
    required this.success,
    required this.age,
    required this.weight,
    required this.userHeight,
    required this.weightType,
    required this.heightType,
    required this.catId,
    required this.goalWeight,
    required this.goals,
  });

  factory FitnessApp.fromJson(Map<String, dynamic> json) => FitnessApp(
        id: json["id"] ?? "",
        name: json["name"] ?? "Guest",
        userImage: json["user_image"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        success: json["success"] ?? "",
        age: json["age"] ?? "+18",
        weight: json["weight"] ?? "0",
        userHeight: json["user_height"] ?? "5",
        weightType: json["weight_type"] ?? "KG",
        heightType: json["height_type"] ?? "CM",
        catId: json["cat_id"] ?? "",
        goalWeight: json["goalWeight"] ?? "0",
        goals: json["goals"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_image": userImage,
        "email": email,
        "phone": phone,
        "success": success,
        "age": age,
        "weight": weight,
        "user_height": userHeight,
        "weight_type": weightType,
        "height_type": heightType,
        "cat_id": catId,
        "goalWeight": goalWeight,
        "goals": goals
      };
}

// To parse this JSON data, do
//
//     final workoutCategorylistModel = workoutCategorylistModelFromJson(jsonString);

import 'dart:convert';

WorkoutCategorylistModel workoutCategorylistModelFromJson(String str) => WorkoutCategorylistModel.fromJson(json.decode(str));

String workoutCategorylistModelToJson(WorkoutCategorylistModel data) => json.encode(data.toJson());

class WorkoutCategorylistModel {
  WorkoutCategorylistModel({required this.fitnessApp});

  final List<FitnessApp> fitnessApp;

  factory WorkoutCategorylistModel.fromJson(Map<String, dynamic> json) => WorkoutCategorylistModel(fitnessApp: List<FitnessApp>.from(json["FITNESS_APP"].map((x) => FitnessApp.fromJson(x))));

  Map<String, dynamic> toJson() => {"FITNESS_APP": List<dynamic>.from(fitnessApp.map((x) => x.toJson()))};
}

class FitnessApp {
  FitnessApp({
    required this.cid,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryImageThumb,
    this.categoryType,
  });

  final String cid;
  final String categoryName;
  final String categoryImage;
  final String categoryImageThumb;
  final String? categoryType;

  factory FitnessApp.fromJson(Map<String, dynamic> json) => FitnessApp(
        cid: json["cid"],
        categoryName: json["category_name"],
        categoryImage: json["category_image"],
        categoryImageThumb: json["category_image_thumb"],
        categoryType: json["category_type"],
      );

  Map<String, dynamic> toJson() => {
        "cid": cid,
        "category_name": categoryName,
        "category_image": categoryImage,
        "category_image_thumb": categoryImageThumb,
        "category_type": categoryType,
      };
}

// To parse this JSON data, do
//
//     final exerciseCategoryListModel = exerciseCategoryListModelFromJson(jsonString);

import 'dart:convert';

ExerciseCategoryListModel exerciseCategoryListModelFromJson(String str) => ExerciseCategoryListModel.fromJson(json.decode(str));

String exerciseCategoryListModelToJson(ExerciseCategoryListModel data) => json.encode(data.toJson());

class ExerciseCategoryListModel {
  ExerciseCategoryListModel({
    required this.fitnessApp,
  });

  final List<FitnessApp> fitnessApp;

  factory ExerciseCategoryListModel.fromJson(Map<String, dynamic> json) => ExerciseCategoryListModel(
    fitnessApp: List<FitnessApp>.from(json["FITNESS_APP"].map((x) => FitnessApp.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "FITNESS_APP": List<dynamic>.from(fitnessApp.map((x) => x.toJson())),
  };
}

class FitnessApp {
  FitnessApp({
    required this.cid,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryImageThumb,
  });

  final String cid;
  final String categoryName;
  final String categoryImage;
  final String categoryImageThumb;

  factory FitnessApp.fromJson(Map<String, dynamic> json) => FitnessApp(
    cid: json["cid"],
    categoryName: json["category_name"],
    categoryImage: json["category_image"],
    categoryImageThumb: json["category_image_thumb"],
  );

  Map<String, dynamic> toJson() => {
    "cid": cid,
    "category_name": categoryName,
    "category_image": categoryImage,
    "category_image_thumb": categoryImageThumb,
  };
}

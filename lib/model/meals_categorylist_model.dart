// To parse this JSON data, do
//
//     final mealsCategoryListModel = mealsCategoryListModelFromJson(jsonString);

import 'dart:convert';

MealsCategoryListModel mealsCategoryListModelFromJson(String str) => MealsCategoryListModel.fromJson(json.decode(str));

String mealsCategoryListModelToJson(MealsCategoryListModel data) => json.encode(data.toJson());

class MealsCategoryListModel {
  MealsCategoryListModel({required this.fitnessApp});

  final List<FitnessApp> fitnessApp;

  factory MealsCategoryListModel.fromJson(Map<String, dynamic> json) => MealsCategoryListModel(
        fitnessApp: List<FitnessApp>.from(json["FITNESS_APP"].map((x) => FitnessApp.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {"FITNESS_APP": List<dynamic>.from(fitnessApp.map((x) => x.toJson()))};
}

class FitnessApp {
  FitnessApp({
    required this.cid,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryImageThumb,
    required this.totalMeals,
  });

  final String cid;
  final String categoryName;
  final String categoryImage;
  final String categoryImageThumb;
  final String totalMeals;

  factory FitnessApp.fromJson(Map<String, dynamic> json) => FitnessApp(
        cid: json["cid"],
        categoryName: json["category_name"],
        categoryImage: json["category_image"],
        categoryImageThumb: json["category_image_thumb"],
        totalMeals: json["total_meals"],
      );

  Map<String, dynamic> toJson() =>
      {"cid": cid, "category_name": categoryName, "category_image": categoryImage, "category_image_thumb": categoryImageThumb, "total_meals": totalMeals};
}

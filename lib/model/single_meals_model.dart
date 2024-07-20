// To parse this JSON data, do
//
//     final singleMealsModel = singleMealsModelFromJson(jsonString);

import 'dart:convert';

import 'exercise.dart';

SingleMealsModel singleMealsModelFromJson(String str) => SingleMealsModel.fromJson(json.decode(str));

String singleMealsModelToJson(SingleMealsModel data) => json.encode(data.toJson());

class SingleMealsModel {
  SingleMealsModel({
    required this.fitnessApp,
  });

  final List<FitnessApp> fitnessApp;

  factory SingleMealsModel.fromJson(Map<String, dynamic> json) => SingleMealsModel(
    fitnessApp: List<FitnessApp>.from(json["FITNESS_APP"].map((x) => FitnessApp.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "FITNESS_APP": List<dynamic>.from(fitnessApp.map((x) => x.toJson())),
  };
}

class FitnessApp {
  FitnessApp({
    required this.id,
    required this.catId,
    required this.totalCategory,
    required this.categoryList,
    required this.featured,
    required this.mealsTitle,
    required this.mealsCoverImg,
    required this.mealsDescription,
    required this.mealsKcal,
    required this.mealsFat,
    required this.mealsProtein,
    required this.mealsCarbs,
    required this.foodId,
    required this.totalFood,
    required this.foodList,
    required this.totalRate,
    required this.rateAvg,
    required this.mealsViews,
  });

  final String id;
  final String catId;
  final int totalCategory;
  final List<Category> categoryList;
  final String featured;
  final String mealsTitle;
  final String mealsCoverImg;
  final String mealsDescription;
  final String mealsKcal;
  final String mealsFat;
  final String mealsProtein;
  final String mealsCarbs;
  final String foodId;
  final int totalFood;
  final List<FoodList> foodList;
  final String totalRate;
  final String rateAvg;
  final String mealsViews;

  factory FitnessApp.fromJson(Map<String, dynamic> json) => FitnessApp(
    id: json["id"],
    catId: json["cat_id"],
    totalCategory: json["total_category"],
    categoryList: List<Category>.from(json["category_list"].map((x) => Category.fromJson(x))),
    featured: json["featured"],
    mealsTitle: json["meals_title"],
    mealsCoverImg: json["meals_cover_img"],
    mealsDescription: json["meals_description"],
    mealsKcal: json["meals_kcal"],
    mealsFat: json["meals_fat"],
    mealsProtein: json["meals_protein"],
    mealsCarbs: json["meals_carbs"],
    foodId: json["food_id"],
    totalFood: json["total_food"],
    foodList: List<FoodList>.from(json["food_list"].map((x) => FoodList.fromJson(x))),
    totalRate: json["total_rate"],
    rateAvg: json["rate_avg"],
    mealsViews: json["meals_views"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cat_id": catId,
    "total_category": totalCategory,
    "category_list": List<dynamic>.from(categoryList.map((x) => x.toJson())),
    "featured": featured,
    "meals_title": mealsTitle,
    "meals_cover_img": mealsCoverImg,
    "meals_description": mealsDescription,
    "meals_kcal": mealsKcal,
    "meals_fat": mealsFat,
    "meals_protein": mealsProtein,
    "meals_carbs": mealsCarbs,
    "food_id": foodId,
    "total_food": totalFood,
    "food_list": List<dynamic>.from(foodList.map((x) => x.toJson())),
    "total_rate": totalRate,
    "rate_avg": rateAvg,
    "meals_views": mealsViews,
  };
}


class FoodList {
  FoodList({
    required this.id,
    required this.foodTitle,
    required this.foodCoverImg,
    required this.foodKcal,
    required this.foodFat,
    required this.foodProtein,
    required this.foodCarbs,
    required this.totalRate,
    required this.rateAvg,
    required this.foodViews,
  });

  final String id;
  final String foodTitle;
  final String foodCoverImg;
  final String foodKcal;
  final String foodFat;
  final String foodProtein;
  final String foodCarbs;
  final String totalRate;
  final String rateAvg;
  final String foodViews;

  factory FoodList.fromJson(Map<String, dynamic> json) => FoodList(
    id: json["id"],
    foodTitle: json["food_title"],
    foodCoverImg: json["food_cover_img"],
    foodKcal: json["food_kcal"],
    foodFat: json["food_fat"],
    foodProtein: json["food_protein"],
    foodCarbs: json["food_carbs"],
    totalRate: json["total_rate"],
    rateAvg: json["rate_avg"],
    foodViews: json["food_views"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "food_title": foodTitle,
    "food_cover_img": foodCoverImg,
    "food_kcal": foodKcal,
    "food_fat": foodFat,
    "food_protein": foodProtein,
    "food_carbs": foodCarbs,
    "total_rate": totalRate,
    "rate_avg": rateAvg,
    "food_views": foodViews,
  };
}

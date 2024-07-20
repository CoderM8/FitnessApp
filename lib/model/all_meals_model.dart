// To parse this JSON data, do
//
//     final allMealsModel = allMealsModelFromJson(jsonString);

import 'dart:convert';

AllMealsModel allMealsModelFromJson(String str) => AllMealsModel.fromJson(json.decode(str));

String allMealsModelToJson(AllMealsModel data) => json.encode(data.toJson());

class AllMealsModel {
  AllMealsModel({
   required this.fitnessApp,
  });

  final List<FitnessApp> fitnessApp;

  factory AllMealsModel.fromJson(Map<String, dynamic> json) => AllMealsModel(
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
   required this.mealsTitle,
   required this.mealsCoverImg,
   required this.mealsDescription,
   required this.mealsKcal,
   required this.mealsFat,
   required this.mealsProtein,
   required this.mealsCarbs,
   required this.mealsType,
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
  final List<CategoryList> categoryList;
  final String mealsTitle;
  final String mealsCoverImg;
  final String mealsDescription;
  final String mealsKcal;
  final String mealsFat;
  final String mealsProtein;
  final String mealsCarbs;
  final String mealsType;
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
    categoryList: List<CategoryList>.from(json["category_list"].map((x) => CategoryList.fromJson(x))),
    mealsTitle: json["meals_title"],
    mealsCoverImg: json["meals_cover_img"],
    mealsDescription: json["meals_description"],
    mealsKcal: json["meals_kcal"],
    mealsFat: json["meals_fat"],
    mealsProtein: json["meals_protein"],
    mealsCarbs: json["meals_carbs"],
    mealsType: json["meals_type"],
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
    "meals_title": mealsTitle,
    "meals_cover_img": mealsCoverImg,
    "meals_description": mealsDescription,
    "meals_kcal": mealsKcal,
    "meals_fat": mealsFat,
    "meals_protein": mealsProtein,
    "meals_carbs": mealsCarbs,
    "meals_type": mealsType,
    "food_id": foodId,
    "total_food": totalFood,
    "food_list": List<dynamic>.from(foodList.map((x) => x.toJson())),
    "total_rate": totalRate,
    "rate_avg": rateAvg,
    "meals_views": mealsViews,
  };
}

class CategoryList {
  CategoryList({
   required this.cid,
   required this.categoryName,
   required this.categoryImage,
   required this.categoryImageThumb,
  });

  final String cid;
  final String categoryName;
  final String categoryImage;
  final String categoryImageThumb;

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
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

import 'dart:convert';

import 'exercise.dart';

AllSearchModel allSearchModelFromJson(String str) => AllSearchModel.fromJson(json.decode(str));

String allSearchModelToJson(AllSearchModel data) => json.encode(data.toJson());

class AllSearchModel {
  const AllSearchModel({required this.fitnessApp});

  final FitnessApp fitnessApp;

  factory AllSearchModel.fromJson(Map<String, dynamic> json) => AllSearchModel(fitnessApp: FitnessApp.fromJson(json["FITNESS_APP"]));

  Map<String, dynamic> toJson() => {"FITNESS_APP": fitnessApp.toJson()};
}

class FitnessApp {
  FitnessApp({
    required this.workoutList,
    required this.mealsList,
    required this.exerciseList,
    required this.categoryList,
  });

  final List<WorkoutList> workoutList;
  final List<MealsList> mealsList;
  final List<ExerciseMainList> exerciseList;
  final List<CategoryMainList> categoryList;

  factory FitnessApp.fromJson(Map<String, dynamic> json) => FitnessApp(
        workoutList: List<WorkoutList>.from(json["WORKOUT_LIST"].map((x) => WorkoutList.fromJson(x))),
        mealsList: List<MealsList>.from(json["MEALS_LIST"].map((x) => MealsList.fromJson(x))),
        exerciseList: List<ExerciseMainList>.from(json["EXERCISE_LIST"].map((x) => ExerciseMainList.fromJson(x))),
        categoryList: List<CategoryMainList>.from(json["CATEGORY_LIST"].map((x) => CategoryMainList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "WORKOUT_LIST": List<dynamic>.from(workoutList.map((x) => x)),
        "MEALS_LIST": List<dynamic>.from(mealsList.map((x) => x)),
        "EXERCISE_LIST": List<dynamic>.from(exerciseList.map((x) => x)),
        "CATEGORY_LIST": List<dynamic>.from(categoryList.map((x) => x)),
      };
}

class CategoryMainList {
  CategoryMainList({
    required this.id,
    required this.catId,
    required this.totalCategory,
    required this.categoryList,
    required this.workoutTitle,
    required this.workoutDescription,
    required this.workoutCoverImg,
    required this.workoutTime,
    required this.workoutKcal,
    required this.exeId,
    required this.totalFood,
    required this.exerciseList,
    required this.workoutLevelType,
    required this.workoutType,
    required this.totalRate,
    required this.rateAvg,
    required this.workoutViews,
  });

  final String id;
  final String catId;
  final int totalCategory;
  final List<Category> categoryList;
  final String workoutTitle;
  final String workoutDescription;
  final String workoutCoverImg;
  final String workoutTime;
  final String workoutKcal;
  final String exeId;
  final int totalFood;
  final List exerciseList;
  final String workoutLevelType;
  final String workoutType;
  final String totalRate;
  final String rateAvg;
  final String workoutViews;

  factory CategoryMainList.fromJson(Map<String, dynamic> json) => CategoryMainList(
        id: json["id"] ?? "",
        catId: json["cat_id"] ?? "",
        totalCategory: json["total_category"] ?? "",
        categoryList: List<Category>.from(json["category_list"].map((x) => Category.fromJson(x))),
        workoutTitle: json["workout_title"] ?? "",
        workoutDescription: json["workout_description"] ?? "",
        workoutCoverImg: json["workout_cover_img"] ?? "",
        workoutTime: json["workout_time"] ?? "",
        workoutKcal: json["workout_kcal"] ?? "",
        exeId: json["exe_id"] ?? "",
        totalFood: json["total_food"] ?? "",
        exerciseList: [],
        workoutLevelType: json["workout_level_type"] ?? "",
        workoutType: json["workout_type"] ?? "",
        totalRate: json["total_rate"] ?? "",
        rateAvg: json["rate_avg"] ?? "",
        workoutViews: json["workout_views"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "total_category": totalCategory,
        "category_list": List<dynamic>.from(categoryList.map((x) => x.toJson())),
        "workout_title": workoutTitle,
        "workout_description": workoutDescription,
        "workout_cover_img": workoutCoverImg,
        "workout_time": workoutTime,
        "workout_kcal": workoutKcal,
        "exe_id": exeId,
        "total_food": totalFood,
        "exercise_list": [],
        "workout_level_type": workoutLevelType,
        "workout_type": workoutType,
        "total_rate": totalRate,
        "rate_avg": rateAvg,
        "workout_views": workoutViews,
      };
}

class WorkoutList {
  WorkoutList({
    required this.totalData,
    required this.id,
    required this.catId,
    required this.totalCategory,
    required this.categoryList,
    required this.workoutTitle,
    required this.workoutDescription,
    required this.workoutCoverImg,
    required this.workoutTime,
    required this.exeId,
    required this.totalExercise,
    required this.exerciseList,
    required this.workoutLevelType,
    required this.workoutType,
    required this.workoutKcal,
    required this.totalRate,
    required this.rateAvg,
    required this.workoutViews,
  });

  final String totalData;
  final String id;
  final String catId;
  final int totalCategory;
  final List<Category> categoryList;
  final String workoutTitle;
  final String workoutDescription;
  final String workoutCoverImg;
  final String workoutTime;
  final String exeId;
  final int totalExercise;
  final List exerciseList;
  final String workoutLevelType;
  final String workoutType;
  final String workoutKcal;
  final String totalRate;
  final String rateAvg;
  final String workoutViews;

  factory WorkoutList.fromJson(Map<String, dynamic> json) => WorkoutList(
        totalData: json["total_data"] ?? "",
        id: json["id"] ?? "",
        catId: json["cat_id"] ?? "",
        totalCategory: json["total_category"] ?? "",
        categoryList: List<Category>.from(json["category_list"].map((x) => Category.fromJson(x))),
        workoutTitle: json["workout_title"] ?? "",
        workoutDescription: json["workout_description"] ?? "",
        workoutCoverImg: json["workout_cover_img"] ?? "",
        workoutTime: json["workout_time"] ?? "",
        exeId: json["exe_id"] ?? "",
        totalExercise: json["total_exercise"] ?? "",
        workoutKcal: json["workout_kcal"] ?? "",
        exerciseList: [],
        workoutLevelType: json["workout_level_type"] ?? "",
        workoutType: json["workout_type"] ?? "",
        totalRate: json["total_rate"] ?? "",
        rateAvg: json["rate_avg"] ?? "",
        workoutViews: json["workout_views"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "total_data": totalData,
        "id": id,
        "cat_id": catId,
        "total_category": totalCategory,
        "category_list": List<dynamic>.from(categoryList.map((x) => x.toJson())),
        "workout_title": workoutTitle,
        "workout_description": workoutDescription,
        "workout_cover_img": workoutCoverImg,
        "workout_time": workoutTime,
        "exe_id": exeId,
        "total_exercise": totalExercise,
        "exercise_list": [],
        "workout_level_type": workoutLevelType,
        "workout_type": workoutType,
        "workout_kcal": workoutKcal,
        "total_rate": totalRate,
        "rate_avg": rateAvg,
        "workout_views": workoutViews,
      };
}

class MealsList {
  MealsList({
    required this.id,
    required this.catId,
    required this.mealsTitle,
    required this.mealsCoverImg,
    required this.mealsDescription,
    required this.mealsKcal,
    required this.mealsFat,
    required this.mealsProtein,
    required this.mealsCarbs,
    required this.mealsType,
    required this.foodId,
    required this.totalRate,
    required this.rateAvg,
    required this.mealsViews,
  });

  final String id;
  final String catId;
  final String mealsTitle;
  final String mealsCoverImg;
  final String mealsDescription;
  final String mealsKcal;
  final String mealsFat;
  final String mealsProtein;
  final String mealsCarbs;
  final String mealsType;
  final String foodId;
  final String totalRate;
  final String rateAvg;
  final String mealsViews;

  factory MealsList.fromJson(Map<String, dynamic> json) => MealsList(
        id: json["id"],
        catId: json["cat_id"],
        mealsTitle: json["meals_title"],
        mealsCoverImg: json["meals_cover_img"],
        mealsDescription: json["meals_description"],
        mealsKcal: json["meals_kcal"],
        mealsFat: json["meals_fat"],
        mealsProtein: json["meals_protein"],
        mealsCarbs: json["meals_carbs"],
        mealsType: json["meals_type"],
        foodId: json["food_id"],
        totalRate: json["total_rate"],
        rateAvg: json["rate_avg"],
        mealsViews: json["meals_views"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "meals_title": mealsTitle,
        "meals_cover_img": mealsCoverImg,
        "meals_description": mealsDescription,
        "meals_kcal": mealsKcal,
        "meals_fat": mealsFat,
        "meals_protein": mealsProtein,
        "meals_carbs": mealsCarbs,
        "meals_type": mealsType,
        "food_id": foodId,
        "total_rate": totalRate,
        "rate_avg": rateAvg,
        "meals_views": mealsViews,
      };
}

class ExerciseMainList {
  ExerciseMainList({
    required this.id,
    required this.catId,
    required this.totalCat,
    required this.catList,
    required this.title,
    required this.img,
    required this.time,
    required this.kcal,
    required this.fileType,
    required this.fileUrl,
    required this.levelType,
    required this.exerciseType,
    required this.totalRate,
    required this.rateAvg,
    required this.views,
  });

  final String id;
  final String catId;
  final int totalCat;
  final List<Category> catList;
  final String title;
  final String img;
  final String time;
  final String kcal;
  final String fileType;
  final String fileUrl;
  final String levelType;
  final String exerciseType;
  final String totalRate;
  final String rateAvg;
  final String views;

  factory ExerciseMainList.fromJson(Map<String, dynamic> json) => ExerciseMainList(
        id: json["id"] ?? "",
        catId: json["cat_id"] ?? "",
        totalCat: json["total_category"] ?? "",
        catList: List<Category>.from(json["category_list"].map((x) => Category.fromJson(x))),
        title: json["exercise_title"] ?? "",
        img: json["exercise_cover_img"] ?? "",
        time: json["exercise_time"] ?? "",
        kcal: json["exercise_kcal"] ?? "",
        fileType: json["exercise_file_type"] ?? "",
        fileUrl: json["exercise_file_url"] ?? "",
        levelType: json["exercise_level_type"] ?? "",
        exerciseType: json["exercise_type"] ?? "",
        totalRate: json["total_rate"] ?? "",
        rateAvg: json["rate_avg"] ?? "",
        views: json["exercise_views"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "total_category": totalCat,
        "category_list": List<dynamic>.from(catList.map((x) => x.toJson())),
        "exercise_title": title,
        "exercise_cover_img": img,
        "exercise_time": time,
        "exercise_kcal": kcal,
        "exercise_file_type": fileType,
        "exercise_file_url": fileUrl,
        "exercise_level_type": levelType,
        "exercise_type": exerciseType,
        "total_rate": totalRate,
        "rate_avg": rateAvg,
        "exercise_views": views,
      };
}

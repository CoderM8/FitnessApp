// To parse this JSON data, do
//
//     final singleworkoutModel = singleworkoutModelFromJson(jsonString);

import 'dart:convert';

import 'exercise.dart';

SingleWorkoutModel singleWorkoutModelFromJson(String str) => SingleWorkoutModel.fromJson(json.decode(str));

String singleWorkoutModelToJson(SingleWorkoutModel data) => json.encode(data.toJson());

class SingleWorkoutModel {
  const SingleWorkoutModel({required this.fitnessApp});

  final List<FitnessApp> fitnessApp;

  factory SingleWorkoutModel.fromJson(Map<String, dynamic> json) => SingleWorkoutModel(fitnessApp: List<FitnessApp>.from(json["FITNESS_APP"].map((x) => FitnessApp.fromJson(x))));

  Map<String, dynamic> toJson() => {"FITNESS_APP": List<dynamic>.from(fitnessApp.map((x) => x.toJson()))};
}

class FitnessApp {
  FitnessApp({
    required this.id,
    required this.catId,
    required this.totalCategory,
    required this.categoryList,
    required this.featured,
    required this.workoutTitle,
    required this.workoutDescription,
    required this.workoutCoverImg,
    required this.workoutTime,
    required this.workoutKcal,
    required this.exeId,
    required this.exerciseList,
    required this.workoutLevelType,
    required this.totalRate,
    required this.rateAvg,
    required this.workoutViews,
  });

  final String id;
  final String catId;
  final int totalCategory;
  final List<Category> categoryList;
  final String featured;
  final String workoutTitle;
  final String workoutDescription;
  final String workoutCoverImg;
  final String workoutTime;
  final String workoutKcal;
  final String exeId;
  final List<ExerciseList> exerciseList;
  final String workoutLevelType;
  final String totalRate;
  final String rateAvg;
  final String workoutViews;

  factory FitnessApp.fromJson(Map<String, dynamic> json) => FitnessApp(
        id: json["id"],
        catId: json["cat_id"],
        totalCategory: json["total_category"],
        categoryList: List<Category>.from(json["category_list"].map((x) => Category.fromJson(x))),
        featured: json["featured"],
        workoutTitle: json["workout_title"],
        workoutDescription: json["workout_description"],
        workoutCoverImg: json["workout_cover_img"],
        workoutTime: json["workout_time"],
        workoutKcal: json["workout_kcal"],
        exeId: json["exe_id"],
        exerciseList: List<ExerciseList>.from(json["exercise_list"].map((x) => ExerciseList.fromJson(x))),
        workoutLevelType: json["workout_level_type"],
        totalRate: json["total_rate"],
        rateAvg: json["rate_avg"],
        workoutViews: json["workout_views"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "total_category": totalCategory,
        "category_list": List<dynamic>.from(categoryList.map((x) => x.toJson())),
        "featured": featured,
        "workout_title": workoutTitle,
        "workout_description": workoutDescription,
        "workout_cover_img": workoutCoverImg,
        "workout_time": workoutTime,
        "workout_kcal": workoutKcal,
        "exe_id": exeId,
        "exercise_list": List<dynamic>.from(exerciseList.map((x) => x.toJson())),
        "workout_level_type": workoutLevelType,
        "total_rate": totalRate,
        "rate_avg": rateAvg,
        "workout_views": workoutViews,
      };
}

class ExerciseList {
  ExerciseList({
    required this.cid,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryImageThumb,
    required this.eid,
    required this.catId,
    required this.exerciseTitle,
    required this.exerciseCoverImg,
    required this.exerciseTime,
    required this.exerciseKcal,
    required this.exerciseFileType,
    required this.exerciseFileUrl,
    required this.exerciseLevelType,
    required this.exerciseType,
  });

  final String cid;
  final String categoryName;
  final String categoryImage;
  final String categoryImageThumb;
  final String eid;
  final String catId;
  final String exerciseTitle;
  final String exerciseCoverImg;
  final String exerciseTime;
  final String exerciseKcal;
  final String exerciseFileType;
  final String exerciseFileUrl;
  final String exerciseLevelType;
  final String exerciseType;

  factory ExerciseList.fromJson(Map<String, dynamic> json) => ExerciseList(
        cid: json["cid"] ?? '',
        categoryName: json["category_name"] ?? '',
        categoryImage: json["category_image"] ?? '',
        categoryImageThumb: json["category_image_thumb"] ?? '',
        eid: json["eid"] ?? "",
        catId: json["cat_id"] ?? "",
        exerciseTitle: json["exercise_title"] ?? "",
        exerciseCoverImg: json["exercise_cover_img"] ?? "",
        exerciseTime: json["exercise_time"] ?? "",
        exerciseKcal: json["exercise_kcal"] ?? "",
        exerciseFileType: json["exercise_file_type"] ?? "",
        exerciseFileUrl: json["exercise_file_url"] ?? "",
        exerciseLevelType: json["exercise_level_type"] ?? "",
        exerciseType: json["exercise_type"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "cid": cid,
        "category_name": categoryName,
        "category_image": categoryImage,
        "category_image_thumb": categoryImageThumb,
        "eid": eid,
        "cat_id": catId,
        "exercise_title": exerciseTitle,
        "exercise_cover_img": exerciseCoverImg,
        "exercise_time": exerciseTime,
        "exercise_kcal": exerciseKcal,
        "exercise_file_type": exerciseFileType,
        "exercise_file_url": exerciseFileUrl,
        "exercise_level_type": exerciseLevelType,
        "exercise_type": exerciseType,
      };
}

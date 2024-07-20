// To parse this JSON data, do
//
//     final allExerciseModel = allExerciseModelFromJson(jsonString);

import 'dart:convert';

import 'exercise.dart';

AllExerciseModel allExerciseModelFromJson(String str) => AllExerciseModel.fromJson(json.decode(str));

String allExerciseModelToJson(AllExerciseModel data) => json.encode(data.toJson());

class AllExerciseModel {
  final List<FitnessApp> fitnessApp;

  AllExerciseModel({required this.fitnessApp});

  factory AllExerciseModel.fromJson(Map<String, dynamic> json) => AllExerciseModel(
        fitnessApp: List<FitnessApp>.from(json["FITNESS_APP"].map((x) => FitnessApp.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {"FITNESS_APP": List<dynamic>.from(fitnessApp.map((x) => x.toJson()))};
}

class FitnessApp {
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

  FitnessApp({
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

  factory FitnessApp.fromJson(Map<String, dynamic> json) => FitnessApp(
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

// To parse this JSON data, do
//
//     final exerciseByCateModel = exerciseByCateModelFromJson(jsonString);

import 'dart:convert';

import 'exercise.dart';

ExerciseByCateModel exerciseByCateModelFromJson(String str) => ExerciseByCateModel.fromJson(json.decode(str));

String exerciseByCateModelToJson(ExerciseByCateModel data) => json.encode(data.toJson());

class ExerciseByCateModel {
  final List<FitnessApp> fitnessApp;

  const ExerciseByCateModel({required this.fitnessApp});

  factory ExerciseByCateModel.fromJson(Map<String, dynamic> json) => ExerciseByCateModel(fitnessApp: List<FitnessApp>.from(json["FITNESS_APP"].map((x) => FitnessApp.fromJson(x))));

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
  final String fileType;
  final String fileUrl;
  final String levelType;
  final String exerciseType;
  final String kcal;
  final String totalRate;
  final String rateAvg;

  FitnessApp({
    required this.id,
    required this.catId,
    required this.totalCat,
    required this.catList,
    required this.title,
    required this.img,
    required this.time,
    required this.fileType,
    required this.fileUrl,
    required this.levelType,
    required this.exerciseType,
    required this.kcal,
    required this.totalRate,
    required this.rateAvg,
  });

  factory FitnessApp.fromJson(Map<String, dynamic> json) => FitnessApp(
        id: json["id"] ?? "",
        catId: json["cat_id"] ?? "",
        totalCat: json["total_category"] ?? "",
        catList: List<Category>.from(json["category_list"].map((x) => Category.fromJson(x))),
        title: json["exercise_title"] ?? "",
        img: json["exercise_cover_img"] ?? "",
        time: json["exercise_time"] ?? "",
        fileType: json["exercise_file_type"] ?? "",
        fileUrl: json["exercise_file_url"] ?? "",
        levelType: json["exercise_level_type"] ?? "",
        exerciseType: json["exercise_type"] ?? "",
        kcal: json["exercise_kcal"] ?? "",
        totalRate: json["total_rate"] ?? "",
        rateAvg: json["rate_avg"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "total_category": totalCat,
        "category_list": List<dynamic>.from(catList.map((x) => x.toJson())),
        "exercise_title": title,
        "exercise_cover_img": img,
        "exercise_time": time,
        "exercise_file_type": fileType,
        "exercise_file_url": fileUrl,
        "exercise_level_type": levelType,
        "exercise_type": exerciseType,
        "exercise_kcal": kcal,
        "total_rate": totalRate,
        "rate_avg": rateAvg,
      };
}

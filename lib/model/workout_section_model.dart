// To parse this JSON data, do
//
//     final workoutSectionModel = workoutSectionModelFromJson(jsonString);

import 'dart:convert';

WorkoutSectionModel workoutSectionModelFromJson(String str) => WorkoutSectionModel.fromJson(json.decode(str));

String workoutSectionModelToJson(WorkoutSectionModel data) => json.encode(data.toJson());

class WorkoutSectionModel {
  WorkoutSectionModel({required this.fitnessApp});

  final List<FitnessApp> fitnessApp;

  factory WorkoutSectionModel.fromJson(Map<String, dynamic> json) => WorkoutSectionModel(fitnessApp: List<FitnessApp>.from(json["FITNESS_APP"].map((x) => FitnessApp.fromJson(x))));

  Map<String, dynamic> toJson() => {"FITNESS_APP": List<dynamic>.from(fitnessApp.map((x) => x.toJson()))};
}

class FitnessApp {
  FitnessApp({required this.id, required this.title, required this.image, required this.section, required this.list});

  final String id;
  final String title;
  final String image;
  final int section;
  final List<SectionWorkoutList> list;

  factory FitnessApp.fromJson(Map<String, dynamic> json) => FitnessApp(
      id: json["id"],
      title: json["section_title"],
      image: json["section_image"],
      section: json["section_workout"],
      list: List<SectionWorkoutList>.from(json["section_workout_list"].map((x) => SectionWorkoutList.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "id": id,
        "section_title": title,
        "section_workout": section,
        "section_image": image,
        "section_workout_list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class SectionWorkoutList {
  SectionWorkoutList(
      {required this.id,
      required this.catId,
      required this.workoutTitle,
      required this.workoutDescription,
      required this.workoutCoverImg,
      required this.workoutTime,
      required this.workoutKcal,
      required this.exeId,
      required this.workoutLevelType,
      required this.workoutViews});

  final String id;
  final String catId;
  final String workoutTitle;
  final String workoutDescription;
  final String workoutCoverImg;
  final String workoutTime;
  final String workoutKcal;
  final String exeId;
  final String workoutLevelType;
  final String workoutViews;

  factory SectionWorkoutList.fromJson(Map<String, dynamic> json) => SectionWorkoutList(
        id: json["id"],
        catId: json["cat_id"],
        workoutTitle: json["workout_title"],
        workoutDescription: json["workout_description"],
        workoutCoverImg: json["workout_cover_img"],
        workoutTime: json["workout_time"],
        workoutKcal: json["workout_kcal"],
        exeId: json["exe_id"],
        workoutLevelType: json["workout_level_type"],
        workoutViews: json["workout_views"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "workout_title": workoutTitle,
        "workout_description": workoutDescription,
        "workout_cover_img": workoutCoverImg,
        "workout_time": workoutTime,
        "workout_kcal": workoutKcal,
        "exe_id": exeId,
        "workout_level_type": workoutLevelType,
        "workout_views": workoutViews,
      };
}

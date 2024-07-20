import 'dart:convert';

List<ScheduleModel> scheduleModelFromJson(String str) => List<ScheduleModel>.from(json.decode(str).map((x) => ScheduleModel.fromJson(x)));

String scheduleModelToJson(List<ScheduleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScheduleModel {
  String msg;
  String success;
  String id;
  String userId;
  DateTime workoutDate;
  String workoutTime;
  String exercise;

  ScheduleModel({
    required this.msg,
    required this.success,
    required this.id,
    required this.userId,
    required this.workoutDate,
    required this.workoutTime,
    required this.exercise,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        msg: json["msg"],
        success: json["success"],
        id: json["id"],
        userId: json["user_id"],
        workoutDate: DateTime.parse(json["workout_date"]),
        workoutTime: json["workout_time"],
        exercise: json["exercise"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "success": success,
        "id": id,
        "user_id": userId,
        "workout_date":
            "${workoutDate.year.toString().padLeft(4, '0')}-${workoutDate.month.toString().padLeft(2, '0')}-${workoutDate.day.toString().padLeft(2, '0')}",
        "workout_time": workoutTime,
        "exercise": exercise,
      };
}

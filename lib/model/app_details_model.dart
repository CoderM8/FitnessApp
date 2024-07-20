// To parse this JSON data, do
//
//     final appAboutModel = appAboutModelFromJson(jsonString);

import 'dart:convert';

AppDetailsModel appAboutModelFromJson(String str) => AppDetailsModel.fromJson(json.decode(str));

String appAboutModelToJson(AppDetailsModel data) => json.encode(data.toJson());

class AppDetailsModel {
  final List<FitnessApp> fitnessApp;

  AppDetailsModel({required this.fitnessApp});

  factory AppDetailsModel.fromJson(Map<String, dynamic> json) => AppDetailsModel(fitnessApp: List<FitnessApp>.from(json["FITNESS_APP"].map((x) => FitnessApp.fromJson(x))));

  Map<String, dynamic> toJson() => {"FITNESS_APP": List<dynamic>.from(fitnessApp.map((x) => x.toJson()))};
}

class FitnessApp {
  final String appName;
  final String appLogo;
  final String appVersion;
  final String appAuthor;
  final String appContact;
  final String appEmail;
  final String appWebsite;
  final String appDescription;
  final String appPrivacyPolicy;
  final String terms;

  FitnessApp({
    required this.appName,
    required this.appLogo,
    required this.appVersion,
    required this.appAuthor,
    required this.appContact,
    required this.appEmail,
    required this.appWebsite,
    required this.appDescription,
    required this.appPrivacyPolicy,
    required this.terms,
  });

  factory FitnessApp.fromJson(Map<String, dynamic> json) => FitnessApp(
        appName: json["app_name"] ?? "",
        appLogo: json["app_logo"] ?? "",
        appVersion: json["app_version"] ?? "",
        appAuthor: json["app_author"] ?? "",
        appContact: json["app_contact"] ?? "",
        appEmail: json["app_email"] ?? "",
        appWebsite: json["app_website"] ?? "",
        appDescription: json["app_description"] ?? "",
        appPrivacyPolicy: json["app_privacy_policy"] ?? "",
        terms: json["app_terms_and_conditions"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "app_name": appName,
        "app_logo": appLogo,
        "app_version": appVersion,
        "app_author": appAuthor,
        "app_contact": appContact,
        "app_email": appEmail,
        "app_website": appWebsite,
        "app_description": appDescription,
        "app_privacy_policy": appPrivacyPolicy,
        "app_terms_and_conditions": terms,
      };
}

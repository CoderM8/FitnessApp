import 'dart:convert';
import 'dart:io';

import 'package:fitness_ui/model/app_details_model.dart';
import 'package:fitness_ui/model/change_password_model.dart';
import 'package:fitness_ui/model/delete_account_model.dart';
import 'package:fitness_ui/model/exercise_by_cate_model.dart';
import 'package:fitness_ui/model/forgotpassword_model.dart';
import 'package:fitness_ui/model/schedule_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constant.dart';
import '../custom_widget/imageloader.dart';
import '../model/plan_model.dart';
import '../model/all_exercise_model.dart';
import '../model/all_meals_model.dart';

import '../model/all_search_model.dart';
import '../model/buy_subscription_model.dart';
import '../model/exercise_categoryList_model.dart';

import '../model/login_model.dart';

import 'package:http/http.dart' as http;

import '../model/meals_LIst_by_Cat_Id_model.dart';
import '../model/meals_categorylist_model.dart';
import '../model/register_model.dart';
import '../model/single_meals_model.dart';
import '../model/singleworkout_model.dart';
import '../model/userprofile_model.dart';
import '../model/workout_section_model.dart';
import '../model/workoutcategorylist_model.dart';

class HttpService {
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  static Future<LoginModel?> login({required String email, required String password, required String type}) async {
    final Map body = {'email': email, 'password': password, 'type': type};

    try {
      /// login with API
      final response = await http.post(Uri.parse("${Api.mainApi}user_login_api.php"), body: body);

      if (response.statusCode == 200) {
        final item = loginModelFromJson(response.body);
        if (item.fitnessApp[0].success == '1') {
          showToast(item.fitnessApp[0].msg);
          return item;
        } else {
          showToast(item.fitnessApp[0].msg);
          return null;
        }
      } else {
        return null;
      }
    } catch (e, t) {
      showToast('Something went Wrong!!');
      print('HttpService login ERROR $e ---- $t');
    }
    return null;
  }

  static Future<RegisterModel?> register({required String email, String? password, String? image, required String type, String? authId, required String name, String? phone}) async {
    try {
      final Map body = {'email': email, 'password': password ?? "", 'user_image': image ?? "", 'type': type, 'auth_id': authId ?? "", 'name': name, 'phone': phone ?? ""};

      /// register with API
      final response = await http.post(Uri.parse("${Api.mainApi}user_register_api.php"), body: body);
      if (response.statusCode == 200) {
        final item = registerModelFromJson(response.body);
        if (item.fitnessApp[0].success == '1') {
          return item;
        } else {
          showToast(item.fitnessApp[0].msg);
          return null;
        }
      } else {
        return null;
      }
    } catch (e, t) {
      showToast('Something went Wrong!!');
      if (kDebugMode) {
        print('HttpService login ERROR $e ---- $t');
      }
      return null;
    }
  }

  static Future<Map> addProfileDetails(
      {required String userId,
      required String age,
      required String goal,
      required String goalWeight,
      required String weight,
      required String height,
      required String catId,
      required String weightType,
      required String heightType}) async {
    // user_details_add
    final response = await http.post(Uri.parse("${Api.mainApi}api.php"), body: {
      "method_name": "user_details_add",
      "id": userId,
      "age": age,
      "goal": goal,
      "weight": weight,
      "height": height,
      "cat_id": catId,
      "weight_type": weightType,
      "height_type": heightType,
      "goalWeight": goalWeight
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['FITNESS APP'][0];
    }
    return {};
  }

  static Future<void> forgotPassword({required String email}) async {
    final Map body = {'email': email};

    final response = await http.post(Uri.parse("${Api.mainApi}user_forgot_pass_api.php"), body: body);
    if (response.statusCode == 200) {
      final item = forgotPassWordModelFromJson(response.body);

      if (item.fitnessApp[0].success == '1') {
        showToast(item.fitnessApp[0].msg);
        Get.back();
      } else {
        showToast(item.fitnessApp[0].msg);
      }
    }
  }

  static Future<void> changePassword({required String currentPassword, required String newPassword, required String confirmPassword}) async {
    final response = await http.post(
      Uri.parse("${Api.mainApi}api.php"),
      body: {'method_name': 'change_password', 'user_id': userid!, 'current_password': currentPassword, 'new_password': newPassword, 'confirm_password': confirmPassword},
    );
    if (response.statusCode == 200) {
      final item = changePasswordModelFromJson(response.body);

      if (item.fitnessApp[0].success == '1') {
        showToast(item.fitnessApp[0].msg);
      } else {
        showToast(item.fitnessApp[0].msg);
      }
    }
  }

  static Future<AllExerciseModel?> allExercise() async {
    final response = await http.post(Uri.parse("${Api.mainApi}api.php"), body: {'method_name': 'allexercise'});
    if (response.statusCode == 200) {
      return allExerciseModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<ExerciseByCateModel?> exerciseByCategory({required String id}) async {
    try {
      final response = await http.post(Uri.parse("${Api.mainApi}api.php"), body: {'method_name': 'cat_exercise_id', 'cat_exercise_id': id});
      if (response.statusCode == 200) {
        return exerciseByCateModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List> singleExercise({required String id}) async {
    final response = await http.post(Uri.parse("${Api.mainApi}api.php"), body: {'method_name': 'exercise_id', 'exercise_id': id});
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['FITNESS_APP'];
    } else {
      return [];
    }
  }

  static Future<SingleWorkoutModel?> singleWorkout({required String id}) async {
    final response = await http.post(Uri.parse("${Api.mainApi}api.php"), body: {'method_name': 'workout_id', 'workout_id': id});
    if (response.statusCode == 200) {
      return singleWorkoutModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<SingleMealsModel?> singleMeals({required String mealId}) async {
    final response = await http.post(Uri.parse("${Api.mainApi}api.php"), body: {'method_name': 'meals_id', 'meals_id': mealId});
    if (response.statusCode == 200) {
      return singleMealsModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<MealsLIstbyCatIdModel?> mealsLIstByCatId({id}) async {
    final response = await http.post(Uri.parse("${Api.mainApi}api.php"), body: {'method_name': 'cat_meals_id', 'cat_meals_id': '$id'});
    if (response.statusCode == 200) {
      return mealsLIstbyCatIdModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<MealsCategoryListModel?> mealCategoryList() async {
    final response = await http.post(Uri.parse("${Api.mainApi}api.php"), body: {'method_name': 'cat_list_meals'});
    if (response.statusCode == 200) {
      return mealsCategoryListModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<WorkoutCategorylistModel?> allCategoryList() async {
    final response = await http.post(Uri.parse("${Api.mainApi}api.php"), body: {'method_name': 'category_lists'});
    if (response.statusCode == 200) {
      return workoutCategorylistModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<AllMealsModel?> allMeals() async {
    final response = await http.post(Uri.parse("${Api.mainApi}api.php"), body: {'method_name': 'allmeals'});
    if (response.statusCode == 200) {
      return allMealsModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<ExerciseCategoryListModel?> exerciseCategoryList() async {
    final response = await http.post(Uri.parse("${Api.mainApi}api.php"), body: {'method_name': 'cat_list_exercise'});
    if (response.statusCode == 200) {
      return exerciseCategoryListModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<WorkoutSectionModel?> workoutSection() async {
    final response = await http.post(Uri.parse("${Api.mainApi}api.php"), body: {'method_name': 'allworkoutsection'});
    if (response.statusCode == 200) {
      return workoutSectionModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<AllSearchModel?> allSearch({required searchText}) async {
    try {
      final response = await http.post(Uri.parse("${Api.mainApi}api.php"), body: {'method_name': 'all_search', 'search_type': '', 'search_text': '$searchText'});
      if (response.statusCode == 200) {
        return allSearchModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<ScheduleModel>?> scheduleExercise({required String exerciseId, required String date, required String time}) async {
    final response = await http.post(
      Uri.parse("${Api.mainApi}api.php"),
      body: {'method_name': 'workout_schedule', 'user_id': '$userid', 'workout_date': date, 'workout_time': time, 'exercise': exerciseId},
    );
    if (response.statusCode == 200) {
      final data = scheduleModelFromJson(response.body);
      if (data[0].success == '1') {
        showToast(data[0].msg);
        return data;
      } else {
        showToast(data[0].msg);
      }
    }
    return null;
  }

  static Future<BuySubscriptionModel?> buySubscription({String? planId}) async {
    final response = await http.post(Uri.parse("${Api.mainApi}api.php"), body: {'method_name': 'buy_subscription', 'user_id': '$userid', 'plan_id': '$planId'});
    if (response.statusCode == 200) {
      return buySubscriptionModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<List<PlanModel>> activeSubscriptionPlan() async {
    final response = await http.post(Uri.parse("${Api.mainApi}api.php"), body: {'method_name': 'get_active_subscription_plan'});
    if (response.statusCode == 200) {
      return planModelFromJson(response.body);
    } else {
      return [];
    }
  }

  static Future<UserProfileModel?> userprofile(userid) async {
    final response = await http.post(Uri.parse("${Api.mainApi}user_profile_api.php"), body: {'id': userid});
    if (response.statusCode == 200) {
      return userProfileModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<Map> getSubscriptionStatus() async {
    final response = await http.post(Uri.parse("${Api.mainApi}api.php"), body: {'method_name': 'user_subscription_status', 'user_id': '$userid'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['FITNESS_APP'][0];
    } else {
      return {};
    }
  }

  static Future<dynamic> profileUpdateService(
      {required String email,
      required String name,
      required String phone,
      File? image,
      required String age,
      required String weight,
      required String height,
      required String weightType,
      required String heightType,
      required String catId,
      required String goalWeight,
      required String goal}) async {
    final req = http.MultipartRequest('POST', Uri.parse('${Api.mainApi}user_profile_update_api.php'));
    req.fields['user_id'] = userid!;
    req.fields['name'] = name;
    req.fields['phone'] = phone;
    req.fields['age'] = age;
    req.fields['email'] = email;
    req.fields['weight'] = weight;
    req.fields['height'] = height;
    req.fields['cat_id'] = catId;
    req.fields['weight_type'] = weightType;
    req.fields['height_type'] = heightType;
    req.fields['goal'] = goal;
    req.fields['goalWeight'] = goalWeight;
    if (image != null) {
      req.files.add(await http.MultipartFile.fromPath('user_image', image.path));
    }

    http.Response response = await http.Response.fromStream(await req.send());

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  static Future<AppDetailsModel?> appDetails() async {
    final response = await http.post(Uri.parse("${Api.mainApi}api.php"), body: {'method_name': 'app_details'});
    if (response.statusCode == 200) {
      return appAboutModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<DeleteAccount?> deleteAccount({required String userId}) async {
    final response = await http.post(Uri.parse("${Api.mainApi}api.php"), body: {'method_name': 'removeuser', 'user_id': userId});
    if (response.statusCode == 200) {
      return deleteAccountFromJson(response.body);
    } else {
      return null;
    }
  }
}

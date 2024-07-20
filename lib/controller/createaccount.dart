import 'package:fitness_ui/bottomNavigationbar.dart';
import 'package:fitness_ui/constant.dart';
import 'package:fitness_ui/custom_widget/imageloader.dart';
import 'package:fitness_ui/services/service.dart';
import 'package:fitness_ui/ui/select_favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/workoutcategorylist_model.dart';

final RxList<FitnessApp> allCat = <FitnessApp>[].obs;

class CreateController extends GetxController {
  final GlobalKey<FormState> registerKey = GlobalKey();

  final RxBool showPassword = true.obs;
  final RxBool isLoadItem = true.obs;
  final RxBool isKg = true.obs;
  final RxBool isCm = true.obs;
  final RxInt selectedIndex = 0.obs;
  final RxInt selectedLevel = 0.obs;
  final RxInt selectedGoal = 0.obs;
  final RxInt selectedAge = 22.obs;
  final RxBool isLoad = false.obs;

  void toggleVisibility() {
    showPassword.value = !showPassword.value;
  }

  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController height = TextEditingController();
  final TextEditingController goalWeight = TextEditingController();

  @override
  void onInit() async {
    await getCat();
    super.onInit();
  }

  Future<void> getCat() async {
    allCat.clear();
    await HttpService.allCategoryList().then((value) {
      if (value != null) {
        allCat.addAll(value.fitnessApp);
      }
      isLoadItem.value = false;
    });
    isLoadItem.value = false;
  }

  Future<void> setProfileDetails() async {
    isLoad.value = false;
    isLoad.value = true;
    final share = await SharedPreferences.getInstance();
    final id = share.getString('Id');
    if (id != null) {
      await HttpService.addProfileDetails(
              userId: id,
              age: selectedAge.value.toString(),
              goal: selectedGoal.value.toString(),
              goalWeight: selectedGoal.value.toString(),
              weight: weight.text.isNotEmpty ? weight.text : "22",
              height: height.text.isNotEmpty ? height.text : '5',
              catId: allCat[selectedIndex.value].cid,
              weightType: isKg.value ? "KG" : "LBS",
              heightType: isCm.value ? "CM" : "FEET")
          .then((value) async {
        if (value.isNotEmpty) {
          if (value['success'] == "1") {
            showToast(value['msg']);
            final sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setString('userid', value['id']);
            await getUserId();
            Get.offAll(() => const MyBottomNavigationBar());
          } else {
            showToast(value['msg']);
          }
        }
        isLoad.value = false;
      });
    }
    isLoad.value = false;
  }

  Future<void> createProfile() async {
    if (registerKey.currentState!.validate()) {
      isLoad.value = false;
      isLoad.value = true;
      final share = await SharedPreferences.getInstance();
      share.remove('Id');
      await HttpService.register(email: email.text, password: password.text, type: 'normal', name: name.text, phone: phone.text).then((value) async {
        isLoad.value = false;
        if (value != null && value.fitnessApp.isNotEmpty) {
          share.setString('Id', value.fitnessApp[0].userId);
          Get.offAll(() => SelectFavouriteScreen());
        }
      });
      isLoad.value = false;
    }
  }
}

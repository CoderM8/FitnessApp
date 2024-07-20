import 'package:fitness_ui/custom_widget/custombutton.dart';
import 'package:fitness_ui/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../exercise/exercise_details_page.dart';
import '../custom_widget/customcontainer.dart';
import '../custom_widget/customcontainertwo.dart';
import '../generated/l10n.dart';
import '../light_dark_constant.dart';
import '../mealplans/mealplan_details.dart';

class MyFavoriteScreen extends StatefulWidget {
  const MyFavoriteScreen({super.key});

  @override
  State<MyFavoriteScreen> createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {
  final RxBool isMeal = true.obs;
  final RxList<MealsFavorite> mealList = <MealsFavorite>[].obs;
  final RxList<ExerciseFavorite> exerciseList = <ExerciseFavorite>[].obs;
  final RxBool isLoad = true.obs;

  @override
  void initState() {
    getFavoriteItems();
    super.initState();
  }

  void getFavoriteItems() async {
    mealList.clear();
    exerciseList.clear();
    await DatabaseHelper.instance.getAllMeals().then((value) {
      mealList.addAll(value);
    });
    await DatabaseHelper.instance.getAllExercise().then((value) {
      exerciseList.addAll(value);
    });
    isLoad.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Back(),
        title: Text(S.of(context).my_favorites, style: TextStyle(fontFamily: 'SB', fontSize: 18.sp)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 20.w),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        fixedSize: Size(MediaQuery.sizeOf(context).width, 38.h),
                        backgroundColor: isMeal.value ? greenColor : greyColor.withOpacity(0.12),
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                      ),
                      onPressed: () {
                        isMeal.value = true;
                      },
                      child: Text(
                        S.of(context).meals,
                        style: TextStyle(fontSize: 14.sp, fontFamily: 'SB', color: isMeal.value ? Colors.white : Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        fixedSize: Size(MediaQuery.sizeOf(context).width, 38.h),
                        backgroundColor: !isMeal.value ? greenColor : greyColor.withOpacity(0.12),
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                      ),
                      onPressed: () {
                        isMeal.value = false;
                      },
                      child: Text(
                        S.of(context).workout,
                        style: TextStyle(fontSize: 14.sp, fontFamily: 'SB', color: !isMeal.value ? Colors.white : Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                ],
              );
            }),
            SizedBox(height: 15.h),
            Obx(() {
              if (isLoad.isTrue) {
                return SizedBox(height: MediaQuery.sizeOf(context).height / 1.5, child: const Center(child: CircularProgressIndicator(color: greenColor)));
              }
              if (isMeal.value) {
                if (mealList.isNotEmpty) {
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: mealList.length,
                    itemBuilder: (context, index) {
                      return ContainerTwo(
                        onTap: () {
                          Get.to(() => MealplanDetailsScreen(id: mealList[index].id.toString()));
                        },
                        image: mealList[index].image,
                        title: mealList[index].title,
                        kcal: mealList[index].kcal,
                        child: InkWell(
                          onTap: () async {
                            await DatabaseHelper.instance.deleteMeals(id: mealList[index].id);
                            mealList.removeAt(index);
                          },
                          child: SvgPicture.asset(
                            'assets/icons/like.svg',
                            height: 20.w,
                            width: 20.w,
                            fit: BoxFit.scaleDown,
                            colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(thickness: 1, endIndent: 15.w, indent: 15.w, color: Theme.of(context).primaryColor, height: 28.h);
                    },
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height / 1.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/Diet.svg', height: 100.w, width: 100.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                        SizedBox(height: 20.h),
                        Text(S.of(context).no_meal, style: TextStyle(fontSize: 16.sp, fontFamily: 'B')),
                      ],
                    ),
                  );
                }
              } else {
                if (exerciseList.isNotEmpty) {
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: exerciseList.length,
                    itemBuilder: (context, index) {
                      return CustomContainer(
                        onTap: () {
                          Get.to(() => ExerciseDetailsScreen(id: exerciseList[index].id.toString()));
                        },
                        image: exerciseList[index].image,
                        title: exerciseList[index].title,
                        levelType: exerciseList[index].type,
                        time: exerciseList[index].time,
                        child: InkWell(
                          onTap: () async {
                            await DatabaseHelper.instance.deleteExercise(id: exerciseList[index].id);
                            exerciseList.removeAt(index);
                          },
                          child: SvgPicture.asset(
                            'assets/icons/like.svg',
                            height: 20.w,
                            width: 20.w,
                            fit: BoxFit.scaleDown,
                            colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(thickness: 1, endIndent: 15.w, indent: 15.w, color: Theme.of(context).primaryColor, height: 28.h);
                    },
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height / 1.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/exercise.svg', height: 100.w, width: 100.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                        SizedBox(height: 20.h),
                        Text(S.of(context).no_exercise, style: TextStyle(fontSize: 16.sp, fontFamily: 'B')),
                      ],
                    ),
                  );
                }
              }
            })
          ],
        ),
      ),
    );
  }
}

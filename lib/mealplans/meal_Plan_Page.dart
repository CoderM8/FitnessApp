import 'package:fitness_ui/custom_widget/custom_shimmer.dart';
import 'package:fitness_ui/custom_widget/customcontainertwo.dart';
import 'package:fitness_ui/services/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../custom_widget/custom_favorite_button.dart';
import '../generated/l10n.dart';
import '../light_dark_constant.dart';
import '../model/meals_LIst_by_Cat_Id_model.dart';
import '../model/meals_categorylist_model.dart';
import 'mealplan_details.dart';

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({super.key});

  @override
  State<MealPlanScreen> createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  final RxInt currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).meals,
          style: TextStyle(fontFamily: 'SB', fontSize: 18.sp),
        ),
      ),
      body: FutureBuilder<MealsCategoryListModel?>(
          future: HttpService.mealCategoryList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null || snapshot.data!.fitnessApp.isEmpty) {
                return Center(child: Text(S.of(context).no_meal, style: TextStyle(fontSize: 16.sp, fontFamily: 'B')));
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 38.h,
                    child: ListView.separated(
                        itemCount: snapshot.data!.fitnessApp.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 13.w),
                        separatorBuilder: (context, index) => SizedBox(width: 10.w),
                        itemBuilder: (context, index) {
                          return Obx(() {
                            currentIndex.value;
                            return InkWell(
                              onTap: () {
                                currentIndex.value = index;
                              },
                              child: Container(
                                height: 38.h,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                decoration: BoxDecoration(
                                  color: currentIndex.value == index ? greenColor : greyColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.all(Radius.circular(6.r)),
                                ),
                                child: Text(
                                  snapshot.data!.fitnessApp[index].categoryName,
                                  style: TextStyle(fontSize: 12.sp, fontFamily: 'SB', color: currentIndex.value == index ? Colors.white : Theme.of(context).primaryColor),
                                ),
                              ),
                            );
                          });
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Text(S.of(context).meals, style: TextStyle(fontSize: 16.sp, fontFamily: 'B')),
                  ),
                  Expanded(
                    child: Obx(() {
                      currentIndex.value;
                      return AnimationLimiter(
                        child: FutureBuilder<MealsLIstbyCatIdModel?>(
                          future: HttpService.mealsLIstByCatId(id: snapshot.data!.fitnessApp[currentIndex.value].cid),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.data == null || snapshot.data!.fitnessApp.isEmpty) {
                                return Center(
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

                              return ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.fitnessApp.length,
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    child: SlideAnimation(
                                      duration: const Duration(milliseconds: 375),
                                      horizontalOffset: 50,
                                      child: FadeInAnimation(
                                        child: ContainerTwo(
                                            onTap: () {
                                              Get.to(() => MealplanDetailsScreen(id: snapshot.data!.fitnessApp[index].id));
                                            },
                                            image: snapshot.data!.fitnessApp[index].mealsCoverImg,
                                            title: snapshot.data!.fitnessApp[index].mealsTitle,
                                            kcal: snapshot.data!.fitnessApp[index].mealsKcal,
                                            child: MealFavButton(
                                              image: snapshot.data!.fitnessApp[index].mealsCoverImg,
                                              id: int.parse(snapshot.data!.fitnessApp[index].id),
                                              kcal: snapshot.data!.fitnessApp[index].mealsKcal,
                                              title: snapshot.data!.fitnessApp[index].mealsTitle,
                                            )),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return Divider(thickness: 1, endIndent: 15.w, indent: 15.w, color: Theme.of(context).primaryColor, height: 28.h);
                                },
                              );
                            } else {
                              return shimmerRectengle(itemCount: 3);
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 20.h)
                ],
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 38.h,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      padding: EdgeInsets.symmetric(horizontal: 13.w),
                      separatorBuilder: (context, index) => SizedBox(width: 13.w),
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: greyColor.withOpacity(0.7),
                          highlightColor: greyColor.withOpacity(0.6),
                          child: Container(
                            height: 38.h,
                            width: 105.w,
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(6.r)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 40.h),
                  shimmerRectengle(itemCount: 2)
                ],
              );
            }
          }),
    );
  }
}

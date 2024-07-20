import 'package:fitness_ui/custom_widget/custombutton.dart';
import 'package:fitness_ui/exercise/workout_detail_screen.dart';
import 'package:fitness_ui/generated/l10n.dart';
import 'package:fitness_ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../exercise/exercise_details_page.dart';
import '../custom_widget/custom_favorite_button.dart';
import '../custom_widget/customcontainer.dart';
import '../custom_widget/customcontainertwo.dart';
import '../light_dark_constant.dart';
import '../mealplans/mealplan_details.dart';
import '../model/all_search_model.dart';
import '../services/service.dart';

class SearchScreen extends StatelessWidget {
  final String text;

  const SearchScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Back(),
        title: Text(text, style: TextStyle(fontFamily: 'SB', fontSize: 18.sp)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<AllSearchModel?>(
            future: HttpService.allSearch(searchText: text),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data!.fitnessApp.categoryList.isEmpty &&
                    snapshot.data!.fitnessApp.exerciseList.isEmpty &&
                    snapshot.data!.fitnessApp.workoutList.isEmpty &&
                    snapshot.data!.fitnessApp.mealsList.isEmpty) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height / 1.5,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/search.svg', height: 100.w, width: 100.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                          SizedBox(height: 20.h),
                          Text("${S.of(context).no_search} $text", style: TextStyle(fontSize: 16.sp, fontFamily: 'B')),
                        ],
                      ),
                    ),
                  );
                }
                return Column(
                  children: [
                    /// workoutList
                    if (snapshot.data!.fitnessApp.workoutList.isNotEmpty)
                      SizedBox(
                        height: (snapshot.data!.fitnessApp.workoutList.length * 121.h) + 20.h,
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 20.h),
                          itemCount: snapshot.data!.fitnessApp.workoutList.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data!.fitnessApp.workoutList[index];
                            return InkWell(
                              onTap: () {
                                Get.to(() => WorkoutDetailsScreen(id: data.id));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Imageview(image: data.workoutCoverImg, height: 91.h, width: 91.h, radius: 10.r),
                                  SizedBox(width: 15.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(data.workoutTitle, maxLines: 2, style: TextStyle(fontSize: 14.sp, fontFamily: 'SB')),
                                      SizedBox(height: 13.h),
                                      IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SvgPicture.asset('assets/icons/calories.svg', height: 12.w, width: 12.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                                            SizedBox(width: 5.h),
                                            Text('${data.workoutKcal} ${S.of(context).kcal}', style: TextStyle(fontSize: 12.sp, fontFamily: 'M')),
                                            SizedBox(height: 10.h, child: const VerticalDivider(color: Colors.grey, thickness: 2)),
                                            SvgPicture.asset('assets/icons/clock.svg', height: 12.h, width: 12.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                                            SizedBox(width: 5.h),
                                            Text('${data.workoutTime} ${S.of(context).min}', style: TextStyle(fontSize: 12.sp, fontFamily: 'M')),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 9.h),
                                      Text(data.workoutLevelType, style: TextStyle(fontSize: 13.sp, fontFamily: 'M')),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1.h, height: 28.h, endIndent: 10.w, indent: 10.w, color: Theme.of(context).primaryColor),
                        ),
                      ),

                    /// exerciseList
                    if (snapshot.data!.fitnessApp.exerciseList.isNotEmpty)
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.fitnessApp.exerciseList.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data!.fitnessApp.exerciseList[index];
                          return CustomContainer(
                            onTap: () {
                              Get.to(() => ExerciseDetailsScreen(id: data.id));
                            },
                            image: data.img,
                            title: data.title,
                            levelType: data.exerciseType,
                            time: data.time,
                            child: CustomButtonFav(
                              image: data.img,
                              id: int.parse(data.id),
                              type: data.exerciseType,
                              time: data.time,
                              title: data.title,
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(thickness: 1, endIndent: 15.w, indent: 15.w, color: Theme.of(context).primaryColor, height: 28.h);
                        },
                      ),

                    ///   mealsList
                    if (snapshot.data!.fitnessApp.mealsList.isNotEmpty)
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.fitnessApp.mealsList.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data!.fitnessApp.mealsList[index];
                          return ContainerTwo(
                              onTap: () {
                                Get.to(() => MealplanDetailsScreen(id: data.id));
                              },
                              image: data.mealsCoverImg,
                              title: data.mealsTitle,
                              kcal: data.mealsKcal,
                              child: MealFavButton(image: data.mealsCoverImg, id: int.parse(data.id), kcal: data.mealsKcal, title: data.mealsTitle));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(thickness: 1, endIndent: 15.w, indent: 15.w, color: Theme.of(context).primaryColor, height: 28.h);
                        },
                      ),
                  ],
                );
              } else {
                return SizedBox(height: MediaQuery.sizeOf(context).height / 1, child: const Center(child: CircularProgressIndicator(color: greenColor)));
              }
            },
          ),
        ),
      ),
    );
  }
}

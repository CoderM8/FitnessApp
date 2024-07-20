import 'package:fitness_ui/custom_widget/custom_shimmer.dart';
import 'package:fitness_ui/custom_widget/custombutton.dart';
import 'package:fitness_ui/mealplans/mealplan_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../custom_widget/custom_favorite_button.dart';
import '../custom_widget/customcontainertwo.dart';
import '../generated/l10n.dart';
import '../model/all_meals_model.dart';
import '../services/service.dart';

class AllMealsScreen extends StatefulWidget {
  const AllMealsScreen({super.key});

  @override
  State<AllMealsScreen> createState() => _AllMealsScreenState();
}

class _AllMealsScreenState extends State<AllMealsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Back(),
        title: Text(S.of(context).meals, style: TextStyle(fontFamily: 'SB', fontSize: 18.sp)),
      ),
      body: AnimationLimiter(
        child: FutureBuilder<AllMealsModel?>(
          future: HttpService.allMeals(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.separated(
                padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
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
      ),
    );
  }
}

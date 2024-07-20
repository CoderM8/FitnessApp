import 'package:fitness_ui/custom_widget/custom_shimmer.dart';
import 'package:fitness_ui/custom_widget/custombutton.dart';
import 'package:fitness_ui/exercise/exercise_details_page.dart';
import 'package:fitness_ui/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../custom_widget/custom_favorite_button.dart';
import '../custom_widget/customcontainer.dart';
import '../model/all_exercise_model.dart';
import '../services/service.dart';

class AllExerciseScreen extends StatelessWidget {
  const AllExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Back(),
        title: Text(S.of(context).exercise, style: TextStyle(fontFamily: 'SB', fontSize: 18.sp)),
      ),
      body: AnimationLimiter(
        child: FutureBuilder<AllExerciseModel?>(
          future: HttpService.allExercise(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                itemCount: snapshot.data!.fitnessApp.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data!.fitnessApp[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      duration: const Duration(milliseconds: 375),
                      horizontalOffset: 50,
                      child: FadeInAnimation(
                        child: CustomContainer(
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
                        ),
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

import 'package:fitness_ui/custom_widget/custom_shimmer.dart';
import 'package:fitness_ui/custom_widget/custombutton.dart';
import 'package:fitness_ui/exercise/exercise_details_page.dart';
import 'package:fitness_ui/generated/l10n.dart';
import 'package:fitness_ui/home/home_page.dart';
import 'package:fitness_ui/model/exercise_by_cate_model.dart';
import 'package:fitness_ui/services/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoryDetailScreen extends StatelessWidget {
  const CategoryDetailScreen({super.key, required this.id, required this.categoryName});

  final String id;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Back(),
        title: Text(categoryName, style: TextStyle(fontFamily: 'SB', fontSize: 18.sp)),
      ),
      body: AnimationLimiter(
        child: FutureBuilder<ExerciseByCateModel?>(
          future: HttpService.exerciseByCategory(id: id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null || snapshot.data!.fitnessApp.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/exercise.svg', height: 100.w, width: 100.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                      SizedBox(height: 20.h),
                      Text(S.of(context).no_exercise, style: TextStyle(fontFamily: 'SB', fontSize: 18.sp)),
                    ],
                  ),
                );
              }
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.w, bottom: 15.w),
                itemCount: snapshot.data!.fitnessApp.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      duration: const Duration(milliseconds: 375),
                      horizontalOffset: 50,
                      child: FadeInAnimation(
                        child: InkWell(
                          onTap: () {
                            Get.to(() => ExerciseDetailsScreen(id: snapshot.data!.fitnessApp[index].id));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Imageview(image: snapshot.data!.fitnessApp[index].img, height: 91.h, width: 91.h, radius: 10.r),
                              SizedBox(width: 15.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data!.fitnessApp[index].title, maxLines: 2, style: TextStyle(fontSize: 14.sp, fontFamily: 'SB')),
                                  SizedBox(height: 13.h),
                                  IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset('assets/icons/calories.svg', height: 12.w, width: 12.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                                        SizedBox(width: 5.h),
                                        Text('${snapshot.data!.fitnessApp[index].kcal} ${S.of(context).kcal}', style: TextStyle(fontSize: 12.sp, fontFamily: 'M')),
                                        SizedBox(height: 10.h, child: const VerticalDivider(color: Colors.grey, thickness: 2)),
                                        SvgPicture.asset('assets/icons/clock.svg', height: 12.w, width: 12.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                                        SizedBox(width: 5.h),
                                        Text('${snapshot.data!.fitnessApp[index].time} ${S.of(context).min}', style: TextStyle(fontSize: 12.sp, fontFamily: 'M'))
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 9.h),
                                  Text(snapshot.data!.fitnessApp[index].exerciseType, style: TextStyle(fontSize: 13.sp, fontFamily: 'M')),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1, height: 28.h, color: Theme.of(context).primaryColor),
              );
            } else {
              return shimmerItems(itemCount: 2);
            }
          },
        ),
      ),
    );
  }
}

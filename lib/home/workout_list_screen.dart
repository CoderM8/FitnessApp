import 'package:fitness_ui/custom_widget/custombutton.dart';
import 'package:fitness_ui/exercise/workout_detail_screen.dart';
import 'package:fitness_ui/generated/l10n.dart';
import 'package:fitness_ui/home/home_page.dart';
import 'package:fitness_ui/model/workout_section_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WorkoutListScreen extends StatelessWidget {
  const WorkoutListScreen({required this.list, required this.title, super.key});

  final List<SectionWorkoutList> list;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Back(),
        title: Text(title, style: TextStyle(fontFamily: 'SB', fontSize: 18.sp)),
      ),
      body: AnimationLimiter(
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 20.h),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                duration: const Duration(milliseconds: 375),
                horizontalOffset: 50,
                child: FadeInAnimation(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => WorkoutDetailsScreen(id: list[index].id));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Imageview(image: list[index].workoutCoverImg, height: 91.h, width: 91.h, radius: 10.r),
                        SizedBox(width: 15.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(list[index].workoutTitle, maxLines: 2, style: TextStyle(fontSize: 14.sp, fontFamily: 'SB')),
                            SizedBox(height: 13.h),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset('assets/icons/calories.svg', height: 12.w, width: 12.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                                  SizedBox(width: 5.h),
                                  Text('${list[index].workoutKcal} ${S.of(context).kcal}', style: TextStyle(fontSize: 12.sp, fontFamily: 'M')),
                                  SizedBox(height: 10.h, child: const VerticalDivider(color: Colors.grey, thickness: 2)),
                                  SvgPicture.asset('assets/icons/clock.svg', height: 12.h, width: 12.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                                  SizedBox(width: 5.h),
                                  Text('${list[index].workoutTime} ${S.of(context).min}', style: TextStyle(fontSize: 12.sp, fontFamily: 'M'))
                                ],
                              ),
                            ),
                            SizedBox(height: 9.h),
                            Text(list[index].workoutLevelType, style: TextStyle(fontSize: 13.sp, fontFamily: 'M')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1.h, height: 28.h, endIndent: 10.w, indent: 10.w, color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}

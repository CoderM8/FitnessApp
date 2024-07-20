import 'package:fitness_ui/controller/createaccount.dart';
import 'package:fitness_ui/custom_widget/custom_shimmer.dart';
import 'package:fitness_ui/exercise/exercise_details_page.dart';
import 'package:fitness_ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../generated/l10n.dart';
import '../light_dark_constant.dart';
import '../model/exercise_by_cate_model.dart';
import '../services/service.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final RxInt currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).Full_Exercise, style: TextStyle(fontFamily: 'SB', fontSize: 18.sp)),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          SizedBox(
            height: 38.h,
            child: Obx(() {
              allCat;
              return ListView.separated(
                  itemCount: allCat.length,
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
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          decoration: BoxDecoration(
                            color: currentIndex.value == index ? greenColor : greyColor.withOpacity(0.12),
                            borderRadius: BorderRadius.all(Radius.circular(6.r)),
                          ),
                          child: Text(
                            allCat[index].categoryName,
                            style: TextStyle(fontSize: 12.sp, fontFamily: 'SB', color: currentIndex.value == index ? Colors.white : Theme.of(context).primaryColor),
                          ),
                        ),
                      );
                    });
                  });
            }),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: Obx(() {
              currentIndex.value;
              return FutureBuilder<ExerciseByCateModel?>(
                future: HttpService.exerciseByCategory(id: allCat[currentIndex.value].cid),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.done) {
                    if (snap.data == null || snap.data!.fitnessApp.isEmpty) {
                      return Center(
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
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.w, bottom: 15.w),
                      itemCount: snap.data!.fitnessApp.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(() => ExerciseDetailsScreen(id: snap.data!.fitnessApp[index].id));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Imageview(image: snap.data!.fitnessApp[index].img, height: 91.h, width: 91.h, radius: 10.r),
                              SizedBox(width: 15.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snap.data!.fitnessApp[index].title, maxLines: 2, style: TextStyle(fontSize: 14.sp, fontFamily: 'SB')),
                                  SizedBox(height: 13.h),
                                  IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset('assets/icons/calories.svg', height: 15.w, width: 15.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                                        SizedBox(width: 3.h),
                                        Text('${snap.data!.fitnessApp[index].kcal} ${S.of(context).kcal}', style: TextStyle(fontSize: 12.sp, fontFamily: 'M')),
                                        SizedBox(height: 10.h, child: const VerticalDivider(color: Colors.grey, thickness: 2)),
                                        SvgPicture.asset('assets/icons/clock.svg', height: 12.w, width: 12.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                                        SizedBox(width: 3.h),
                                        Text('${snap.data!.fitnessApp[index].time} ${S.of(context).min}', style: TextStyle(fontSize: 12.sp, fontFamily: 'M'))
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 9.h),
                                  Text(snap.data!.fitnessApp[index].exerciseType, style: TextStyle(fontSize: 13.sp, fontFamily: 'M')),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1, color: Theme.of(context).primaryColor, height: 28.h),
                    );
                  } else {
                    return shimmerItems(itemCount: 3);
                  }
                },
              );
            }),
          )
        ],
      ),
    );
  }
}

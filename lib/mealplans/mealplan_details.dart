import 'package:fitness_ui/constant.dart';
import 'package:fitness_ui/custom_widget/custom_favorite_button.dart';
import 'package:fitness_ui/custom_widget/custombutton.dart';
import 'package:fitness_ui/home/home_page.dart';
import 'package:fitness_ui/services/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../generated/l10n.dart';
import '../light_dark_constant.dart';
import '../model/single_meals_model.dart';

class MealplanDetailsScreen extends StatefulWidget {
  const MealplanDetailsScreen({required this.id, super.key});

  final String id;

  @override
  State<MealplanDetailsScreen> createState() => _MealplanDetailsScreenState();
}

class _MealplanDetailsScreenState extends State<MealplanDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<SingleMealsModel?>(
          future: HttpService.singleMeals(mealId: widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null || snapshot.data!.fitnessApp.isEmpty) {
                return Column(
                  children: [
                    AppBar(leading: const Back()),
                    const Spacer(),
                    SvgPicture.asset('assets/icons/Diet.svg', height: 100.w, width: 100.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                    SizedBox(height: 20.h),
                    Text(S.of(context).no_meal, style: TextStyle(fontFamily: 'SB', fontSize: 18.sp)),
                    const Spacer(),
                  ],
                );
              }
              final data = snapshot.data!.fitnessApp[0];
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: MediaQuery.sizeOf(context).height / 2.2,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      automaticallyImplyLeading: false,
                      floating: true,
                      pinned: true,
                      leading: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 30.w,
                          width: 30.w,
                          margin: EdgeInsets.only(top: 5.h, left: 10.w),
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black.withOpacity(0.6)),
                          child: SvgPicture.asset(
                            'assets/icons/arrow_back.svg',
                            fit: BoxFit.scaleDown,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      actions: [
                        Container(
                            height: 40.w,
                            width: 40.w,
                            margin: EdgeInsets.only(top: 5.h, right: 10.w),
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                            child: MealFavButton(
                              image: data.mealsCoverImg,
                              id: int.parse(data.id),
                              kcal: data.mealsKcal,
                              title: data.mealsTitle,
                            )),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(
                          children: [
                            Expanded(child: Imageview(image: data.mealsCoverImg)),
                            Baseline(
                              baseline: 5.h,
                              baselineType: TextBaseline.alphabetic,
                              child: Container(
                                height: 60.h,
                                margin: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton.icon(
                                        onPressed: null,
                                        icon: SvgPicture.asset('assets/icons/calories.svg', height: 18.w, width: 18.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                                        label: Text(
                                          "${data.mealsKcal} ${S.of(context).kcal}",
                                          style: TextStyle(fontSize: 12.sp, fontFamily: 'SB', color: Theme.of(context).primaryColor),
                                        ),
                                      ),
                                      SizedBox(width: 15.w),
                                      SizedBox(height: 20.h, child: const VerticalDivider(color: Colors.grey, thickness: 2)),
                                      SizedBox(width: 15.w),
                                      TextButton.icon(
                                        onPressed: null,
                                        icon: SvgPicture.asset('assets/icons/star.svg', height: 18.w, width: 18.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                                        label: Text(
                                          '${data.totalRate} ${S.of(context).rate}',
                                          style: TextStyle(fontSize: 12.sp, fontFamily: 'SB', color: Theme.of(context).primaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(S.of(context).fat, style: TextStyle(fontSize: 12.sp, fontFamily: 'SB')),
                                SizedBox(height: 10.h),
                                Text('${data.mealsFat} g', style: TextStyle(fontSize: 14.sp, fontFamily: 'SB')),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(S.of(context).protein, style: TextStyle(fontSize: 12.sp, fontFamily: 'SB')),
                                SizedBox(height: 10.h),
                                Text('${data.mealsProtein} g', style: TextStyle(fontSize: 14.sp, fontFamily: 'SB')),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(S.of(context).carbs, style: TextStyle(fontSize: 12.sp, fontFamily: 'SB')),
                                SizedBox(height: 10.h),
                                Text('${data.mealsCarbs} g', style: TextStyle(fontSize: 14.sp, fontFamily: 'SB')),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Text(data.mealsTitle, style: TextStyle(fontFamily: 'B', fontSize: 22.sp)),
                        SizedBox(height: 15.h),
                        ReadMoreText(text: data.mealsDescription),
                        if (data.foodList.isNotEmpty) ...[
                          Divider(thickness: 1, color: Theme.of(context).primaryColor, height: 28.h),
                          Text(S.of(context).meals, style: TextStyle(fontSize: 16.sp, fontFamily: "B")),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: data.foodList.length,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            itemBuilder: (context, index) {
                              final FoodList food = data.foodList[index];
                              return Row(
                                children: [
                                  Imageview(image: food.foodCoverImg, height: 90.h, width: 90.h, radius: 10.r),
                                  SizedBox(width: 10.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(food.foodTitle, style: TextStyle(fontSize: 12.sp, fontFamily: 'SB')),
                                      SizedBox(height: 25.h),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(S.of(context).fat, style: TextStyle(fontSize: 10.sp, fontFamily: 'M')),
                                              SizedBox(height: 10.h),
                                              Text('${food.foodFat} g', style: TextStyle(fontSize: 12.sp, fontFamily: 'SB')),
                                            ],
                                          ),
                                          SizedBox(width: 25.h),
                                          Column(
                                            children: [
                                              Text(S.of(context).protein, style: TextStyle(fontSize: 10.sp, fontFamily: 'M')),
                                              SizedBox(height: 10.h),
                                              Text('${food.foodProtein} g', style: TextStyle(fontSize: 12.sp, fontFamily: 'SB')),
                                            ],
                                          ),
                                          SizedBox(width: 25.h),
                                          Column(
                                            children: [
                                              Text(S.of(context).carbs, style: TextStyle(fontSize: 10.sp, fontFamily: 'M')),
                                              SizedBox(height: 10.h),
                                              Text('${food.foodCarbs} g', style: TextStyle(fontSize: 12.sp, fontFamily: 'SB')),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1.h, height: 28.h),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator(color: greenColor));
            }
          }),
    );
  }
}

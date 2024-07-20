import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_ui/constant.dart';
import 'package:fitness_ui/controller/createaccount.dart';
import 'package:fitness_ui/custom_widget/customcontainertwo.dart';
import 'package:fitness_ui/home/category_detail_screen.dart';
import 'package:fitness_ui/home/search_page.dart';
import 'package:fitness_ui/home/workout_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../exercise/exercise_details_page.dart';
import '../custom_widget/custom_favorite_button.dart';
import '../custom_widget/custom_shimmer.dart';
import '../custom_widget/customcontainer.dart';
import '../generated/l10n.dart';
import '../light_dark_constant.dart';
import '../mealplans/mealplan_details.dart';
import '../model/all_exercise_model.dart';
import '../model/all_meals_model.dart';
import '../model/workout_section_model.dart';
import '../services/service.dart';
import 'all_exercise.dart';
import 'all_meals.dart';
import 'category_page.dart';

final TextEditingController search = TextEditingController();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: MediaQuery.sizeOf(context).width / 2.5,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.r), bottomRight: Radius.circular(12.r)),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 40.h),
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/home_bg.png'), fit: BoxFit.fill),
                  ),
                  child: Obx(() {
                    userInfo;
                    if (userInfo.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.h),
                          Text(
                            'Hello, $greetings',
                            style: TextStyle(fontSize: 12.sp, color: Colors.white, fontFamily: 'M'),
                          ),
                          Text(
                            'Guest',
                            style: TextStyle(fontSize: 16.sp, fontFamily: 'SB', color: Colors.white),
                          ),
                          SizedBox(height: 22.h),
                          TextField(
                            onSubmitted: (value) {
                              if (search.text.isNotEmpty || value.isNotEmpty) {
                                Get.to(() => SearchScreen(text: value));
                              }
                              search.clear();
                            },
                            autofocus: false,
                            controller: search,
                            cursorColor: Colors.black,
                            textAlign: TextAlign.start,
                            textInputAction: TextInputAction.search,
                            style: TextStyle(fontSize: 13.sp, color: Colors.black, fontFamily: "SB"),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 5.h),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: SvgPicture.asset('assets/icons/search.svg', height: 8.h, width: 8.h, fit: BoxFit.scaleDown),
                              hintText: S.of(context).search,
                              hintStyle: TextStyle(color: Colors.black, fontSize: 13.sp, fontFamily: "M"),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
                            ),
                          ),
                        ],
                      );
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15.h),
                        Row(
                          children: [
                            Imageview(image: userInfo['Image'], circle: true, height: 40.w, width: 40.w),
                            SizedBox(width: 15.w),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello, $greetings',
                                  style: TextStyle(fontSize: 12.sp, color: Colors.white, fontFamily: 'M'),
                                ),
                                Text(
                                  userInfo['Name'],
                                  style: TextStyle(fontSize: 14.sp, fontFamily: 'SB', color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 22.h),
                        TextField(
                          onSubmitted: (value) {
                            if (search.text.isNotEmpty || value.isNotEmpty) {
                              Get.to(() => SearchScreen(text: value));
                            }
                            search.clear();
                          },
                          autofocus: false,
                          controller: search,
                          cursorColor: Colors.black,
                          textAlign: TextAlign.start,
                          textInputAction: TextInputAction.search,
                          style: TextStyle(fontSize: 13.sp, color: Colors.black, fontFamily: "SB"),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 5.h),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: SvgPicture.asset('assets/icons/search.svg', height: 8.h, width: 8.h, fit: BoxFit.scaleDown),
                            hintText: S.of(context).search,
                            hintStyle: TextStyle(color: Colors.black, fontSize: 13.sp, fontFamily: "M"),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              floating: true,
              // Your appBar appears immediately
              pinned: true, // Your appBar pinned to top
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Workout section start
                  Padding(
                    padding: EdgeInsets.only(left: 19.w, right: 21.w),
                    child: Text(S.of(context).workout_section, style: TextStyle(fontFamily: 'B', fontSize: 16.sp)),
                  ),

                  SizedBox(height: 18.h),
                  SizedBox(
                    height: 38.h,
                    width: double.infinity,
                    child: FutureBuilder<WorkoutSectionModel?>(
                        future: HttpService.workoutSection(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return ListView.separated(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.fitnessApp.length,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 13.w),
                              separatorBuilder: (context, index) => SizedBox(width: 13.w),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => WorkoutListScreen(list: snapshot.data!.fitnessApp[index].list, title: snapshot.data!.fitnessApp[index].title),
                                    );
                                  },
                                  child: Container(
                                    height: MediaQuery.sizeOf(context).height,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                                    decoration: BoxDecoration(
                                      color: greyColor.withOpacity(0.12),
                                      borderRadius: BorderRadius.all(Radius.circular(6.r)),
                                    ),
                                    child: Text(snapshot.data!.fitnessApp[index].title,
                                        maxLines: 2, textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp, fontFamily: 'SB', color: Theme.of(context).primaryColor)),
                                  ),
                                );
                              },
                            );
                          } else {
                            return SizedBox(
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
                                        color: greyColor.withOpacity(0.12),
                                        borderRadius: BorderRadius.all(Radius.circular(6.r)),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        }),
                  ),
                  SizedBox(height: 22.h),
                  // Workout section end
                  // Exercise category start
                  customTitle(
                    context,
                    title: S.of(context).category,
                    onPressed: () {
                      Get.to(() => const CategoryScreen());
                    },
                  ),
                  SizedBox(height: 18.h),
                  SizedBox(
                    height: 92.h,
                    child: Obx(() {
                      allCat;
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: allCat.length,
                        padding: EdgeInsets.symmetric(horizontal: 13.w),
                        separatorBuilder: (context, index) => SizedBox(width: 13.w),
                        itemBuilder: (context, index) {
                          final data = allCat[index];
                          return Column(
                            children: [
                              Imageview(
                                onTap: () {
                                  Get.to(() => CategoryDetailScreen(id: data.cid, categoryName: data.categoryName));
                                },
                                image: data.categoryImage,
                                height: 61.h,
                                width: 61.h,
                                circle: true,
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(
                                width: 61.h,
                                child: Text(
                                  data.categoryName,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12.sp, fontFamily: 'SB'),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 15.h),
                  // Exercise category end
                  Divider(thickness: 1, endIndent: 10, indent: 10, color: Theme.of(context).primaryColor),
                  SizedBox(height: 20.h),
                  customTitle(context, title: S.of(context).popular_exercise, onPressed: () {
                    Get.to(() => const AllExerciseScreen());
                  }),
                  SizedBox(height: 15.h),
                  FutureBuilder<AllExerciseModel?>(
                    future: HttpService.allExercise(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.fitnessApp.take(5).length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data!.fitnessApp[index];
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
                        );
                      } else {
                        return shimmerRectengle(itemCount: 2);
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                  Divider(thickness: 1, endIndent: 10, indent: 10, color: Theme.of(context).primaryColor),
                  SizedBox(height: 20.h),
                  customTitle(context, title: S.of(context).meals, onPressed: () {
                    Get.to(() => const AllMealsScreen());
                  }),
                  SizedBox(height: 20.h),
                  FutureBuilder<AllMealsModel?>(
                    future: HttpService.allMeals(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.fitnessApp.length,
                          itemBuilder: (context, index) {
                            return ContainerTwo(
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
                                ));
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(thickness: 1, endIndent: 15.w, indent: 15.w, color: Theme.of(context).primaryColor, height: 28.h);
                          },
                        );
                      } else {
                        return shimmerRectengle(itemCount: 2);
                      }
                    },
                  ),
                  SizedBox(height: 30.h),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget customTitle(context, {required String title, required VoidCallback onPressed}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 13.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontFamily: 'B', fontSize: 16.sp)),
        InkWell(
          onTap: onPressed,
          child: Text(S.of(context).see_all, style: TextStyle(fontSize: 12.sp, fontFamily: 'B')),
        )
      ],
    ),
  );
}

class Imageview extends StatelessWidget {
  const Imageview({super.key, required this.image, this.radius, this.height, this.width, this.circle = false, this.onTap});

  final String image;
  final double? radius;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        height: height ?? MediaQuery.sizeOf(context).height,
        width: width ?? MediaQuery.sizeOf(context).width,
        memCacheHeight: ((height ?? 400) * 2).toInt(),
        imageBuilder: (context, imageProvider) => Container(
          height: height ?? MediaQuery.sizeOf(context).height,
          width: width ?? MediaQuery.sizeOf(context).width,
          decoration: circle
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(radius ?? 0),
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
        ),
        placeholder: (context, imageProvider) => Container(
          height: height ?? MediaQuery.sizeOf(context).height,
          width: width ?? MediaQuery.sizeOf(context).width,
          decoration:
              circle ? BoxDecoration(shape: BoxShape.circle, color: greyColor.withOpacity(0.2)) : BoxDecoration(color: greyColor.withOpacity(0.2), borderRadius: BorderRadius.circular(radius ?? 0)),
          child: Shimmer.fromColors(
            baseColor: greyColor.withOpacity(0.7),
            highlightColor: greyColor.withOpacity(0.6),
            child: const Icon(Icons.image, color: Colors.white, size: 40),
          ),
        ),
        imageUrl: image,
        errorWidget: (context, url, error) => Container(
          height: height ?? MediaQuery.sizeOf(context).height,
          width: width ?? MediaQuery.sizeOf(context).width,
          alignment: Alignment.center,
          decoration:
              circle ? BoxDecoration(shape: BoxShape.circle, color: greyColor.withOpacity(0.2)) : BoxDecoration(color: greyColor.withOpacity(0.2), borderRadius: BorderRadius.circular(radius ?? 0)),
          child: Icon(Icons.error, size: 30.sp, color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}

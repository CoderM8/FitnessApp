import 'package:fitness_ui/generated/l10n.dart';
import 'package:fitness_ui/light_dark_constant.dart';
import 'package:fitness_ui/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'exercise/fullExercise_page.dart';
import 'home/home_page.dart';
import 'mealplans/meal_Plan_Page.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  final List<Widget> tabPage = [
    const HomeScreen(),
    const MealPlanScreen(),
    const ExerciseScreen(),
    const ProfileScreen(),
  ];

  final RxInt currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return IndexedStack(index: currentIndex.value, children: tabPage);
      }),
      bottomNavigationBar: Obx(() {
        isDark.value;
        return BottomNavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: greyColor,
          currentIndex: currentIndex.value,
          selectedLabelStyle: TextStyle(fontSize: 12.sp, fontFamily: 'M', color: Theme.of(context).primaryColor),
          unselectedLabelStyle: TextStyle(fontSize: 12.sp, fontFamily: 'M', color: greyColor),
          onTap: (index) {
            currentIndex.value = index;
          },
          items: [
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset('assets/icons/home.svg', height: 18.w, width: 18.w, fit: BoxFit.cover, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                icon: SvgPicture.asset('assets/icons/home.svg', height: 18.w, width: 18.w, fit: BoxFit.cover, colorFilter: const ColorFilter.mode(greyColor, BlendMode.srcIn)),
                label: S.of(context).home),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset('assets/icons/Diet.svg', height: 18.w, width: 18.w, fit: BoxFit.cover, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                icon: SvgPicture.asset('assets/icons/Diet.svg', height: 18.w, width: 18.w, fit: BoxFit.cover, colorFilter: const ColorFilter.mode(greyColor, BlendMode.srcIn)),
                label: S.of(context).meals),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset('assets/icons/exercise.svg', height: 18.w, width: 18.w, fit: BoxFit.cover, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                icon: SvgPicture.asset('assets/icons/exercise.svg', height: 18.w, width: 18.w, fit: BoxFit.cover, colorFilter: const ColorFilter.mode(greyColor, BlendMode.srcIn)),
                label: S.of(context).exercise),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset('assets/icons/profile.svg', height: 18.w, width: 18.w, fit: BoxFit.cover, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                icon: SvgPicture.asset('assets/icons/profile.svg', height: 18.w, width: 18.w, fit: BoxFit.cover, colorFilter: const ColorFilter.mode(greyColor, BlendMode.srcIn)),
                label: S.of(context).Profile),
          ],
        );
      }),
    );
  }
}

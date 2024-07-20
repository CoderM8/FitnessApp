import 'package:fitness_ui/bottomNavigationbar.dart';
import 'package:fitness_ui/custom_widget/imageloader.dart';
import 'package:fitness_ui/light_dark_constant.dart';
import 'package:fitness_ui/ui/pageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (userid == null) {
        Get.off(() => const MyPageView());
      } else {
        Get.off(() => const MyBottomNavigationBar());
      }
    });
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              greenColor,
              Theme.of(context).scaffoldBackgroundColor,
              greenColor,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/splash.png', height: 400.w, width: 350.w),
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("PRO", style: TextStyle(fontSize: 35.sp, fontFamily: 'B')),
                SizedBox(width: 8.w),
                Text("FITNESS", style: TextStyle(fontSize: 35.sp, fontFamily: 'B', color: greenColor)),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              "We train your body to be great and fit.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, fontFamily: "R"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:fitness_ui/light_dark_constant.dart';
import 'package:fitness_ui/model/OnBoardingModel.dart';
import 'package:fitness_ui/ui/tracking_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../generated/l10n.dart';
import 'login_page.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({super.key});

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final pageController = PageController();
  int index = 0;

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        index = pageController.page!.toInt();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<OnBoardingModel> onBoardingList = [
      OnBoardingModel(
          imgUrl: 'assets/images/1.png', title: S.of(context).pageView_first_text1, title2: S.of(context).pageView_first_text2, title3: S.of(context).pageView_first_text3),
      OnBoardingModel(
          imgUrl: 'assets/images/2.png', title: S.of(context).pageView_second_text1, title2: S.of(context).pageView_second_text2, title3: S.of(context).pageView_second_text3),
      OnBoardingModel(
          imgUrl: 'assets/images/3.png', title: S.of(context).pageView_third_text1, title2: S.of(context).pageView_third_text2, title3: S.of(context).pageView_third_text3),
    ];

    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xffF1CA58),
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).scaffoldBackgroundColor,
              const Color(0xffF1CA58),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                itemCount: onBoardingList.length,
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) {
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Spacer(),
                      Image.asset(onBoardingList[index].imgUrl, height: 400.h, width: 350.w),
                      SizedBox(height: 40.h),
                      Text(onBoardingList[index].title, textAlign: TextAlign.center, style: TextStyle(fontSize: 30.sp, fontFamily: 'B')),
                      Text(onBoardingList[index].title2, textAlign: TextAlign.center, style: TextStyle(fontSize: 30.sp, color: greenColor, fontFamily: 'B')),
                      Text(onBoardingList[index].title3, textAlign: TextAlign.center, style: TextStyle(fontSize: 30.sp, fontFamily: 'B')),
                      const Spacer(),
                    ],
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h, left: 15.w, right: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        if (Platform.isIOS) {
                          await AppTrackingTransparency.trackingAuthorizationStatus.then((status) {
                            if (status == TrackingStatus.authorized) {
                              Get.offAll(() => const LoginScreen());
                            } else {
                              Get.offAll(() => const TrackingScreen());
                            }
                          });
                        } else {
                          Get.offAll(() => const LoginScreen());
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.r),
                        child: Text(S.of(context).skip, style: TextStyle(fontSize: 16.sp, fontFamily: 'M')),
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: pageController,
                      effect: ExpandingDotsEffect(activeDotColor: greenColor, dotColor: Theme.of(context).primaryColor, dotHeight: 12.h, dotWidth: 12.h),
                      count: onBoardingList.length,
                    ),
                    InkWell(
                      onTap: () async {
                        if (index != 2) {
                          pageController.nextPage(duration: const Duration(microseconds: 500), curve: Curves.easeIn);
                          setState(() {});
                        } else {
                          if (Platform.isIOS) {
                            await AppTrackingTransparency.trackingAuthorizationStatus.then((status) {
                              if (status == TrackingStatus.authorized) {
                                Get.offAll(() => const LoginScreen());
                              } else {
                                Get.offAll(() => const TrackingScreen());
                              }
                            });
                          } else {
                            Get.offAll(() => const LoginScreen());
                          }
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.r),
                        child: Text(
                          index != 2 ? S.of(context).next : S.of(context).done,
                          style: TextStyle(fontSize: 16.sp, fontFamily: 'M'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

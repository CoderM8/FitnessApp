import 'package:fitness_ui/constant.dart';
import 'package:fitness_ui/light_dark_constant.dart';
import 'package:fitness_ui/services/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shimmer/shimmer.dart';
import '../custom_widget/custombutton.dart';
import '../generated/l10n.dart';
import '../model/plan_model.dart';

class SubscriptionPlans extends StatefulWidget {
  const SubscriptionPlans({super.key});

  @override
  State<SubscriptionPlans> createState() => _SubscriptionPlansState();
}

class _SubscriptionPlansState extends State<SubscriptionPlans> {
  final RxList<PlanModel> plans = <PlanModel>[].obs;
  final RxBool isLoad = false.obs;
  final RxBool isBuy = false.obs;
  final RxInt selectedIndex = 0.obs;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    isLoad.value = true;
    plans.clear();
    await HttpService.activeSubscriptionPlan().then((value) {
      plans.addAll(value);
    });
    isLoad.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const Back()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Text(S.of(context).subscription_subtitle, style: TextStyle(fontFamily: 'M', fontSize: 16.sp), textAlign: TextAlign.center),
              SizedBox(height: 20.h),
              SvgPicture.asset('assets/icons/star.svg', height: 50.w, width: 50.w, fit: BoxFit.cover, colorFilter: const ColorFilter.mode(greenColor, BlendMode.srcIn)),
              SizedBox(height: 20.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/check.svg', height: 25.w, width: 25.w, fit: BoxFit.cover, colorFilter: const ColorFilter.mode(greenColor, BlendMode.srcIn)),
                  SizedBox(width: 15.w),
                  Expanded(child: Text('Enjoy an ad-free experience for uninterrupted workouts and browsing.', textAlign: TextAlign.start, style: TextStyle(fontFamily: 'R', fontSize: 13.sp)))
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/check.svg', height: 25.w, width: 25.w, fit: BoxFit.cover, colorFilter: const ColorFilter.mode(greenColor, BlendMode.srcIn)),
                  SizedBox(width: 15.w),
                  Expanded(
                      child: Text('A wide range of exercises, including strength training, cardio, yoga, pilates, and more.',
                          textAlign: TextAlign.start, style: TextStyle(fontFamily: 'R', fontSize: 13.sp)))
                ],
              ),
              SizedBox(height: 15.h),
              Obx(() {
                if (isLoad.isFalse) {
                  return AnimationLimiter(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: plans.length,
                      itemBuilder: (context, index) {
                        final bool isPopular = plans[index].planName.toLowerCase().contains('month');
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          child: SlideAnimation(
                            duration: const Duration(milliseconds: 375),
                            verticalOffset: 50,
                            child: FadeInAnimation(
                              child: Obx(() {
                                selectedIndex.value;
                                return Stack(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        selectedIndex.value = index;
                                      },
                                      child: Container(
                                        width: MediaQuery.sizeOf(context).width,
                                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                                        margin: EdgeInsets.only(top: isPopular ? 13.h : 0),
                                        decoration: BoxDecoration(border: Border.all(color: greyColor.withOpacity(0.5)), borderRadius: BorderRadius.circular(10.r)),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(height: 8.h),
                                                  Text("${plans[index].planPrice} / ${plans[index].planName}",
                                                      textAlign: TextAlign.start, maxLines: 1, style: TextStyle(fontFamily: "SB", fontSize: 16.sp)),
                                                  SizedBox(height: 8.h),
                                                  Text(plans[index].planDescription, style: TextStyle(fontSize: 12.sp), textAlign: TextAlign.start, maxLines: 2),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10.w),
                                            if (selectedIndex.value == index)
                                              SvgPicture.asset(
                                                'assets/icons/check.svg',
                                                height: 25.w,
                                                width: 25.w,
                                                fit: BoxFit.cover,
                                                colorFilter: const ColorFilter.mode(greenColor, BlendMode.srcIn),
                                              )
                                            else
                                              Icon(Icons.radio_button_unchecked, color: greyColor.withOpacity(0.12), size: 25.h),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (isPopular)
                                      Positioned(
                                        left: 30.w,
                                        top: 0.h,
                                        child: Container(
                                          height: 25.h,
                                          width: 88.w,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(color: greenColor, borderRadius: BorderRadius.circular(20.r)),
                                          child: Text('Most Popular', style: TextStyle(fontFamily: 'M', color: whiteColor, fontSize: 11.sp)),
                                        ),
                                      ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 10.h);
                      },
                    ),
                  );
                } else {
                  return AnimationLimiter(
                    child: ListView.separated(
                      itemCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(height: 10.h),
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          child: SlideAnimation(
                            verticalOffset: 50,
                            duration: const Duration(milliseconds: 375),
                            child: FadeInAnimation(
                              duration: const Duration(milliseconds: 375),
                              curve: Curves.easeIn,
                              child: Shimmer.fromColors(
                                baseColor: greyColor.withOpacity(0.7),
                                highlightColor: greyColor.withOpacity(0.6),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                                  decoration: BoxDecoration(border: Border.all(color: greyColor.withOpacity(0.5)), borderRadius: BorderRadius.circular(10.r)),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(color: greyColor.withOpacity(0.5), height: 20.h),
                                            Container(color: greyColor.withOpacity(0.5), height: 10.h, margin: EdgeInsets.symmetric(vertical: 8.h)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      SvgPicture.asset('assets/icons/check.svg', height: 25.w, width: 25.w, fit: BoxFit.cover, colorFilter: const ColorFilter.mode(greenColor, BlendMode.srcIn)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
              SizedBox(height: 35.h),
              Obx(() {
                isBuy.value;
                return CustomButton(
                    isLoad: isBuy.value,
                    text: S.of(context).Go_Premium,
                    onTap: () async {
                      isBuy.value = false;
                      isBuy.value = true;
                      Future.delayed(const Duration(seconds: 3), () {
                        isBuy.value = false;
                        showToast('Plan is Activated');
                      });
                      // await HttpService.buySubscription(planId: plans[selectedIndex.value].id).then((value) {
                      //   showToast(value!.fitnessApp[0].msg);
                      // });
                    },
                    color: greenColor);
              }),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Terms & condition', style: TextStyle(fontFamily: 'M', fontSize: 11.sp)),
                  Text('Restore', style: TextStyle(fontFamily: 'M', color: whiteColor, fontSize: 11.sp)),
                  Text('Privacy policy', style: TextStyle(fontFamily: 'M', fontSize: 11.sp)),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

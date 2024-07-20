import 'package:fitness_ui/constant.dart';
import 'package:fitness_ui/controller/createaccount.dart';
import 'package:fitness_ui/home/home_page.dart';
import 'package:fitness_ui/ui/agepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../custom_widget/custombutton.dart';
import '../generated/l10n.dart';
import '../light_dark_constant.dart';

class SelectFavouriteScreen extends StatelessWidget {
  SelectFavouriteScreen({super.key});

  final CreateController cc = Get.put(CreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).step_one_of_seven, style: TextStyle(fontSize: 14.sp, fontFamily: 'SB')),
              SizedBox(height: 10.h),
              Text(S.of(context).select_your_favorite, style: TextStyle(fontFamily: 'SB', fontSize: 22.sp)),
              SizedBox(height: 20.h),
              Obx(() {
                if (cc.isLoadItem.isFalse) {
                  return AnimationLimiter(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: allCat.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: isTab(context) ? 1.6 : 1, crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        final cat = allCat[index];
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: 2,
                          child: SlideAnimation(
                            duration: const Duration(milliseconds: 375),
                            verticalOffset: 50,
                            child: FadeInAnimation(
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Imageview(
                                        image: cat.categoryImage,
                                        height: 112.w,
                                        width: 112.w,
                                        circle: true,
                                        onTap: () {
                                          cc.selectedIndex.value = index;
                                        },
                                      ),
                                      Obx(() {
                                        if (cc.selectedIndex.value == index) {
                                          return Container(
                                            height: 112.w,
                                            width: 112.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black.withOpacity(0.2)),
                                            child: SvgPicture.asset(
                                              'assets/icons/check.svg',
                                              height: 40.w,
                                              width: 40.w,
                                              fit: BoxFit.cover,
                                              colorFilter: const ColorFilter.mode(greenColor, BlendMode.srcIn),
                                            ),
                                          );
                                        }
                                        return const SizedBox.shrink();
                                      }),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Flexible(
                                    child: Text(
                                      cat.categoryName,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 14.sp, fontFamily: 'SB'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Shimmer.fromColors(
                    baseColor: greyColor.withOpacity(0.7),
                    highlightColor: greyColor.withOpacity(0.6),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 6,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 1, crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(height: 112.w, width: 112.w, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white)),
                            Container(
                              height: 15.h,
                              width: 112.w,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
                              margin: EdgeInsets.only(top: 5.h),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.h),
        child: CustomButton(
          text: S.of(context).next_step,
          onTap: () {
            Get.to(() => AgeScreen());
          },
          color: greenColor,
        ),
      ),
    );
  }
}

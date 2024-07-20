import 'package:fitness_ui/light_dark_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

shimmer({double? height, required double radius, required int itemCount, required Axis direction}) {
  return SizedBox(
    height: height!.h,
    child: ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: direction,
      itemCount: itemCount,
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      separatorBuilder: (context, index) => SizedBox(width: 13.w),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: greyColor.withOpacity(0.7),
          highlightColor: greyColor.withOpacity(0.6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(radius: radius, backgroundColor: Colors.white),
              SizedBox(height: 10.h),
              Container(height: 15.h, color: Colors.white, width: 60.w),
            ],
          ),
        );
      },
    ),
  );
}

shimmerRectengle({required int itemCount}) {
  return ListView.separated(
    physics: const NeverScrollableScrollPhysics(),
    padding: EdgeInsets.only(left: 15.w, right: 15.w),
    shrinkWrap: true,
    itemCount: itemCount,
    separatorBuilder: (BuildContext context, int index) {
      return Divider(thickness: 1, endIndent: 15.w, indent: 15.w, color: Theme.of(context).primaryColor, height: 28.h);
    },
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
          baseColor: greyColor.withOpacity(0.7),
          highlightColor: greyColor.withOpacity(0.6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 155.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                height: 15.h,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
              ),
              SizedBox(height: 5.h),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      height: 15.h,
                      width: 100.w,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
                    ),
                    SizedBox(width: 5.w),
                    SizedBox(height: 20.h, child: const VerticalDivider(color: Colors.grey, thickness: 2)),
                    Container(
                      height: 15.h,
                      width: 100.w,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
                    ),
                  ],
                ),
              ),
            ],
          ));
    },
  );
}

shimmerItems({required int itemCount}) {
  return ListView.separated(
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true,
    padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.w, bottom: 15.w),
    itemCount: itemCount,
    separatorBuilder: (BuildContext context, int index) {
      return Divider(thickness: 1, color: Theme.of(context).primaryColor, height: 28.h);
    },
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: greyColor.withOpacity(0.7),
        highlightColor: greyColor.withOpacity(0.6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 91.h,
              width: 91.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(width: 15.h),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 15.h,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
                  ),
                  SizedBox(height: 5.w),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(
                          height: 15.h,
                          width: 100.w,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
                        ),
                        SizedBox(width: 5.w),
                        SizedBox(height: 20.h, child: const VerticalDivider(color: Colors.grey, thickness: 2)),
                        Container(
                          height: 15.h,
                          width: 100.w,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.w),
                  Container(
                    height: 15.h,
                    width: 100.w,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

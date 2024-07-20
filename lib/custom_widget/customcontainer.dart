import 'package:fitness_ui/generated/l10n.dart';
import 'package:fitness_ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomContainer extends StatelessWidget {
  final String image;
  final String title;
  final String levelType;
  final String time;
  final Widget child;
  final VoidCallback? onTap;

  const CustomContainer({super.key, required this.image, required this.title, required this.levelType, required this.child, this.onTap, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Imageview(onTap: onTap, image: image, radius: 10.r, height: 155.h, width: MediaQuery.sizeOf(context).width),
              Positioned(
                right: 10.h,
                top: 10.h,
                child: Container(
                    height: 30.w,
                    width: 30.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: Colors.white,
                    ),
                    child: Center(child: child)),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Text(title, style: TextStyle(fontSize: 12.sp, fontFamily: 'SB')),
          SizedBox(height: 5.h),
          IntrinsicHeight(
            child: Row(
              children: [
                Text(levelType, style: TextStyle(fontSize: 10.sp, fontFamily: 'M')),
                SizedBox(width: 5.w),
                const VerticalDivider(color: Colors.grey, thickness: 2),
                SvgPicture.asset('assets/icons/clock.svg', height: 12.h, width: 12.h, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                Text(' $time ${S.of(context).min}', style: TextStyle(fontSize: 10.sp, fontFamily: 'M')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

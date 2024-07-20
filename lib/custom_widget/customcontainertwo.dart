import 'package:fitness_ui/generated/l10n.dart';
import 'package:fitness_ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContainerTwo extends StatelessWidget {
  final String image;
  final String title;
  final String kcal;
  final VoidCallback? onTap;
  final Widget child;

  const ContainerTwo({super.key, required this.image, required this.title, required this.kcal, this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Imageview(onTap: onTap, image: image, height: 155.h, width: double.infinity, radius: 15.r),
              Positioned(
                right: 10.h,
                top: 10.h,
                child: Container(height: 30.w, width: 30.w, decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), color: Colors.white), child: child),
              ),
            ],
          ),
          SizedBox(height: 11.h),
          Text(title, style: TextStyle(fontSize: 12.sp, fontFamily: 'SB')),
          SizedBox(height: 5.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/calories.svg', height: 15.w, width: 15.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
              SizedBox(width: 3.w),
              Text('$kcal ${S.of(context).kcal}', style: TextStyle(fontSize: 10.sp, fontFamily: 'M')),
            ],
          ),
        ],
      ),
    );
  }
}

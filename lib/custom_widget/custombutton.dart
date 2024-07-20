import 'package:fitness_ui/light_dark_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color? color;
  final Color? textColor;
  final bool isLoad;
  final bool enable;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
    this.textColor,
    this.isLoad = false,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enable ? onTap : null,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 55.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: enable ? color : greyColor.withOpacity(0.12)),
        child: isLoad
            ? AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
                alignment: Alignment.center,
                child: SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: CircularProgressIndicator(color: textColor ?? Colors.white, strokeWidth: 3.w),
                ),
              )
            : Text(
                text,
                style: TextStyle(fontSize: 16.sp, fontFamily: 'SB', color: textColor ?? Colors.white),
              ),
      ),
    );
  }
}

class Back extends StatelessWidget {
  const Back({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Get.back();
      },
      child: SvgPicture.asset(
        'assets/icons/arrow_back.svg',
        fit: BoxFit.none,
        colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
      ),
    );
  }
}

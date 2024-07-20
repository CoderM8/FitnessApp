import 'package:fitness_ui/light_dark_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextFiled extends StatelessWidget {
  final bool? showPassword;
  final String title;
  final Widget? icon;
  final String? Function(String?)? validation;
  final String? Function(String?)? onchange;
  final TextInputType? textInputType;
  final TextEditingController textEditingController;
  final int? maxLength;
  final TextAlign textAlign;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFiled(
      {super.key,
      required this.title,
      this.icon,
      this.showPassword,
      required this.textEditingController,
      this.validation,
      this.onchange,
      this.textInputType,
      this.textAlign = TextAlign.start,
      this.readOnly = false,
      this.inputFormatters,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validation,
      keyboardType: textInputType,
      obscureText: showPassword ?? false,
      inputFormatters: inputFormatters ?? [LengthLimitingTextInputFormatter(maxLength)],
      onChanged: onchange,
      controller: textEditingController,
      style: TextStyle(fontSize: 13.sp, color: Theme.of(context).primaryColor, fontFamily: "SB"),
      cursorColor: Theme.of(context).primaryColor,
      readOnly: readOnly,
      textAlign: textAlign,
      decoration: InputDecoration(
        suffixIcon: icon,
        fillColor: greyColor.withOpacity(0.12),
        filled: true,
        hintText: title,
        hintStyle: TextStyle(color: Theme.of(context).primaryColor.withOpacity(0.6), fontSize: 13.sp, fontFamily: "M"),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key, required this.title, required this.svg, required this.color, this.onTap});

  final String title;
  final String svg;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: ListTile(
          onTap: onTap,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          tileColor: greyColor.withOpacity(0.12),
          leading: Container(
            height: 35.w,
            width: 35.w,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), color: color),
            child: SvgPicture.asset(svg, fit: BoxFit.scaleDown, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
          ),
          title: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 12.sp, fontFamily: 'SB', color: Theme.of(context).primaryColor),
          ),
          trailing: Icon(Icons.arrow_forward_ios, size: 13.sp, color: Theme.of(context).primaryColor)),
    );
  }
}

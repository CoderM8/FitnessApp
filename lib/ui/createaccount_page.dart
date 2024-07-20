import 'dart:io';

import 'package:fitness_ui/controller/createaccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../custom_widget/custombutton.dart';
import '../custom_widget/textfeild.dart';
import '../generated/l10n.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});

  final CreateController cc = Get.put(CreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const Back()),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Form(
            key: cc.registerKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).create_account, style: TextStyle(fontFamily: 'B', fontSize: 22.sp)),
                SizedBox(height: 8.h),
                Text(S.of(context).please_enter, style: TextStyle(fontSize: 16.sp, fontFamily: "M")),
                SizedBox(height: 20.h),
                Text(
                  S.of(context).full_name,
                  style: TextStyle(fontSize: 13.sp, fontFamily: "M"),
                ),
                SizedBox(height: 8.h),
                CustomTextFiled(
                  textEditingController: cc.name,
                  title: S.of(context).name_hint_title_text,
                ),
                SizedBox(height: 14.h),
                Text(
                  S.of(context).email,
                  style: TextStyle(fontSize: 13.sp, fontFamily: "M"),
                ),
                SizedBox(height: 8.h),
                CustomTextFiled(
                  textEditingController: cc.email,
                  textInputType: TextInputType.emailAddress,
                  validation: (value) {
                    if (value!.isEmpty) {
                      return S.of(context).email_Required;
                    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                      return S.of(context).email_Invalid;
                    } else {
                      return null;
                    }
                  },
                  title: S.of(context).email_hint_title,
                ),
                SizedBox(height: 14.h),
                Text(
                  S.of(context).email_password,
                  style: TextStyle(fontSize: 13.sp, fontFamily: "M"),
                ),
                SizedBox(height: 8.h),
                Obx(() {
                  cc.showPassword.value;
                  return CustomTextFiled(
                    maxLength: 8,
                    textEditingController: cc.password,
                    showPassword: cc.showPassword.value,
                    title: '*******',
                    icon: GestureDetector(
                      onTap: cc.toggleVisibility,
                      child: Icon(
                        cc.showPassword.value ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                    ),
                    validation: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).password_Required;
                      } else if (value.length < 6) {
                        return S.of(context).password_six_Digits;
                      } else {
                        return null;
                      }
                    },
                  );
                }),
                SizedBox(height: 14.h),
                Text(
                  S.of(context).phone,
                  style: TextStyle(fontSize: 13.sp, fontFamily: "M"),
                ),
                SizedBox(height: 8.h),
                CustomTextFiled(
                  textEditingController: cc.phone,
                  textInputType: Platform.isIOS ? const TextInputType.numberWithOptions(signed: true, decimal: false) : TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  title: S.of(context).phone_hint_title_text,
                  validation: (value) {
                    if (value!.isEmpty) {
                      return S.of(context).phone_number_Required;
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 30.h),
                Obx(() {
                  cc.isLoad.value;
                  return CustomButton(
                    text: S.of(context).createAccount,
                    isLoad: cc.isLoad.value,
                    onTap: cc.createProfile,
                    color: const Color(0xffB0C929),
                  );
                }),
                SizedBox(height: 15.h),
                Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.of(context).already_have_an_account, style: TextStyle(fontSize: 13.sp, fontFamily: 'M')),
                      SizedBox(width: 5.w),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Text(S.of(context).login, style: TextStyle(fontSize: 14.sp, fontFamily: 'B')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

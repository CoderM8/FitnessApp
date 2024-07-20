import 'package:fitness_ui/services/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custom_widget/custombutton.dart';
import '../custom_widget/textfeild.dart';
import '../generated/l10n.dart';
import '../light_dark_constant.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController currentPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey();

  bool showCurrentPassword = true;
  bool showNewPassword = true;
  bool showConfirmPassword = true;

  void oldPasswordVisibility() {
    setState(() {
      showCurrentPassword = !showCurrentPassword;
    });
  }

  void newPasswordVisibility() {
    setState(() {
      showNewPassword = !showNewPassword;
    });
  }

  void confirmPasswordVisibility() {
    setState(() {
      showConfirmPassword = !showConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Back(),
        title: Text(S.of(context).Change_Password, style: TextStyle(fontFamily: 'SB', fontSize: 18.sp)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(S.of(context).change_password_text, style: TextStyle(fontSize: 14.sp, fontFamily: "M")),
                SizedBox(height: 30.h),
                Text(S.of(context).Current_Password, style: TextStyle(fontSize: 13.sp, fontFamily: "M")),
                SizedBox(height: 10.h),
                CustomTextFiled(
                  maxLength: 8,
                  textEditingController: currentPassword,
                  showPassword: showCurrentPassword,
                  title: S.of(context).Current_Password,
                  icon: GestureDetector(
                    onTap: oldPasswordVisibility,
                    child: Icon(
                      showCurrentPassword ? Icons.visibility_off : Icons.visibility,
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
                ),
                SizedBox(height: 14.h),
                Text(S.of(context).New_Password, style: TextStyle(fontSize: 13.sp, fontFamily: "M")),
                SizedBox(height: 10.h),
                CustomTextFiled(
                  maxLength: 8,
                  textEditingController: newPassword,
                  showPassword: showNewPassword,
                  title: S.of(context).New_Password,
                  icon: GestureDetector(
                    onTap: newPasswordVisibility,
                    child: Icon(
                      showNewPassword ? Icons.visibility_off : Icons.visibility,
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
                ),
                SizedBox(height: 14.h),
                Text(S.of(context).confirm_password, style: TextStyle(fontSize: 13.sp, fontFamily: "M")),
                SizedBox(height: 7.h),
                CustomTextFiled(
                  maxLength: 8,
                  textEditingController: confirmPassword,
                  showPassword: showConfirmPassword,
                  title: S.of(context).confirm_password,
                  icon: GestureDetector(
                    onTap: confirmPasswordVisibility,
                    child: Icon(
                      showConfirmPassword ? Icons.visibility_off : Icons.visibility,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  ),
                  validation: (value) {
                    if (value!.isEmpty) {
                      return S.of(context).password_Required;
                    } else if (value.length < 6) {
                      return S.of(context).password_six_Digits;
                    } else if (value != newPassword.text) {
                      return S.of(context).confirm_pass_not_match;
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 50.h),
                CustomButton(
                  text: S.of(context).Save,
                  onTap: () async {
                    if (key.currentState!.validate()) {
                      await HttpService.changePassword(currentPassword: currentPassword.text, newPassword: newPassword.text, confirmPassword: confirmPassword.text);
                    }
                  },
                  color: greenColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

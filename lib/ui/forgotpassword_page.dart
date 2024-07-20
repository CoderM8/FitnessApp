import 'package:fitness_ui/light_dark_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../custom_widget/custombutton.dart';
import '../custom_widget/textfeild.dart';
import '../generated/l10n.dart';
import '../services/service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController email = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const Back()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).forgot_password_screen, style: TextStyle(fontFamily: 'B', fontSize: 22.sp)),
              SizedBox(height: 8.h),
              Text(S.of(context).forgot_password_text_line1, style: TextStyle(fontSize: 16.sp, fontFamily: "M")),
              SizedBox(height: 25.h),
              Text(S.of(context).email, style: TextStyle(fontSize: 13.sp, fontFamily: 'M')),
              SizedBox(height: 8.h),
              CustomTextFiled(
                textEditingController: email,
                validation: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).email_Required;
                  } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                    return S.of(context).email_Invalid;
                  } else {
                    return null;
                  }
                },
                title: S.of(context).forgot_password_hint_text,
              ),
              SizedBox(height: 50.h),
              CustomButton(
                text: S.of(context).reset_password,
                onTap: () async {
                  if (key.currentState!.validate()) {
                    await HttpService.forgotPassword(email: email.text);
                  }
                },
                color: greenColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

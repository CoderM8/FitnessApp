import 'dart:io';

import 'package:fitness_ui/controller/createaccount.dart';
import 'package:fitness_ui/custom_widget/textfeild.dart';
import 'package:fitness_ui/ui/weightgoal_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../custom_widget/custombutton.dart';
import '../generated/l10n.dart';
import '../light_dark_constant.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  final CreateController cc = Get.find<CreateController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const Back()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context).step_three_of_seven, style: TextStyle(fontSize: 14.sp, fontFamily: 'SB')),
            SizedBox(height: 10.h),
            Text(S.of(context).how_much_do_you_weight, style: TextStyle(fontFamily: 'SB', fontSize: 22.sp)),
            SizedBox(height: 5.h),
            Text(S.of(context).optional, style: TextStyle(fontFamily: 'R', fontSize: 12.sp)),
            const Spacer(),
            Center(
              child: Container(
                height: 45.h,
                width: 120.w,
                margin: EdgeInsets.only(top: 5.h, right: 5.w, bottom: 5.h),
                padding: EdgeInsets.all(5.r),
                decoration: BoxDecoration(color: greyColor.withOpacity(0.12), borderRadius: BorderRadius.circular(10.r)),
                child: Obx(() {
                  cc.isKg.value;
                  return Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            if (cc.isKg.value) {
                              cc.isKg.value = false;
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5.r),
                            decoration: BoxDecoration(color: cc.isKg.value ? Colors.transparent : Colors.white, borderRadius: BorderRadius.circular(10.r)),
                            child: Text(S.of(context).lbs, style: TextStyle(color: cc.isKg.value ? Theme.of(context).primaryColor : Colors.black, fontFamily: 'M', fontSize: 16.sp)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            if (!cc.isKg.value) {
                              cc.isKg.value = true;
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5.r),
                            decoration: BoxDecoration(color: !cc.isKg.value ? Colors.transparent : Colors.white, borderRadius: BorderRadius.circular(10.r)),
                            child: Text(S.of(context).kg, style: TextStyle(color: !cc.isKg.value ? Theme.of(context).primaryColor : Colors.black, fontFamily: 'M', fontSize: 16.sp)),
                          ),
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
            SizedBox(height: 23.h),
            CustomTextFiled(
              textEditingController: cc.weight,
              maxLength: 4,
              textAlign: TextAlign.center,
              textInputType: Platform.isIOS ? const TextInputType.numberWithOptions(signed: true, decimal: false) : TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
              title: '00',
            ),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.h),
        child: CustomButton(
          text: S.of(context).next_step,
          onTap: () {
            Get.to(() => WeightGoalScreen());
          },
          color: greenColor,
        ),
      ),
    );
  }
}

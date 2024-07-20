import 'package:fitness_ui/controller/createaccount.dart';
import 'package:fitness_ui/ui/weight_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

import '../custom_widget/custombutton.dart';
import '../generated/l10n.dart';
import '../light_dark_constant.dart';

class AgeScreen extends StatelessWidget {
  AgeScreen({super.key});

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
            Text(S.of(context).step_two_of_seven, style: TextStyle(fontSize: 14.sp, fontFamily: 'SB')),
            SizedBox(height: 10.h),
            Text(S.of(context).how_old_are_you, style: TextStyle(fontFamily: 'SB', fontSize: 22.sp)),
            SizedBox(height: 20.h),
            const Spacer(),
            Obx(() {
              cc.selectedAge.value;
              return Center(
                child: NumberPicker(
                  textStyle: TextStyle(fontSize: 25.sp, color: Theme.of(context).primaryColor, fontFamily: "SB"),
                  itemHeight: 60.h,
                  selectedTextStyle: TextStyle(color: greenColor, fontSize: 40.sp, fontFamily: "B"),
                  value: cc.selectedAge.value,
                  itemCount: 5,
                  minValue: 18,
                  maxValue: 100,
                  onChanged: (value) => cc.selectedAge.value = value,
                ),
              );
            }),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.h),
        child: CustomButton(
          text: S.of(context).next_step,
          onTap: () {
            Get.to(() => const WeightScreen());
          },
          color: greenColor,
        ),
      ),
    );
  }
}

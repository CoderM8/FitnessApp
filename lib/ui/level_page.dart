import 'package:fitness_ui/controller/createaccount.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../custom_widget/custombutton.dart';
import '../generated/l10n.dart';
import '../light_dark_constant.dart';
import 'goal_page.dart';

class LevelScreen extends StatelessWidget {
  LevelScreen({super.key});

  final CreateController cc = Get.find<CreateController>();

  @override
  Widget build(BuildContext context) {
    final List item = [S.of(context).beginner, S.of(context).intermediate, S.of(context).advanced];
    return Scaffold(
      appBar: AppBar(leading: const Back()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context).step_six_of_seven, style: TextStyle(fontSize: 14.sp, fontFamily: 'SB')),
            SizedBox(height: 10.h),
            Text(S.of(context).what_is_fitness_level, style: TextStyle(fontFamily: 'SB', fontSize: 22.sp)),
            const Spacer(),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: item.length,
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => SizedBox(height: 25.h),
              itemBuilder: (context, index) {
                return Obx(() {
                  cc.selectedLevel.value;
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(MediaQuery.sizeOf(context).width, 55.h),
                      backgroundColor: cc.selectedLevel.value == index ? greenColor : Colors.transparent,
                      side: const BorderSide(width: 1, color: greyColor),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                    ),
                    onPressed: () {
                      cc.selectedLevel.value = index;
                    },
                    child: Text(
                      item[index],
                      style: TextStyle(fontSize: 18.sp, color: cc.selectedLevel.value == index ? Colors.white : Theme.of(context).primaryColor, fontFamily: "SB"),
                    ),
                  );
                });
              },
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
            Get.to(() => GoalScreen());
          },
          color: greenColor,
        ),
      ),
    );
  }
}

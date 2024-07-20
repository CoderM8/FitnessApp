import 'package:fitness_ui/controller/createaccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../custom_widget/custombutton.dart';
import '../generated/l10n.dart';
import '../light_dark_constant.dart';

class GoalScreen extends StatelessWidget {
  GoalScreen({super.key});

  final CreateController cc = Get.find<CreateController>();

  @override
  Widget build(BuildContext context) {
    final List items = [
      {"Title": S.of(context).weight_loss, "Svg": 'assets/icons/weightLoss.svg'},
      {"Title": S.of(context).gain_muscle, "Svg": 'assets/icons/muscle.svg'},
      {"Title": S.of(context).improve_fitness, "Svg": 'assets/icons/fitness.svg'}
    ];
    return Scaffold(
      appBar: AppBar(leading: const Back()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context).step_seven_of_seven, style: TextStyle(fontSize: 14.sp, fontFamily: 'SB')),
            SizedBox(height: 10.h),
            Text(S.of(context).what_is_your_goal, style: TextStyle(fontFamily: 'SB', fontSize: 22.sp)),
            const Spacer(),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => SizedBox(height: 25.h),
              itemBuilder: (context, index) {
                return Obx(() {
                  final bool isTrue = cc.selectedGoal.value == index;
                  return InkWell(
                    onTap: () {
                      cc.selectedGoal.value = index;
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 55.h,
                      decoration: BoxDecoration(
                        color: isTrue ? greenColor : Colors.transparent,
                        border: Border.all(width: 1, color: greyColor),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            items[index]['Svg'],
                            height: 30.w,
                            width: 30.w,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(isTrue ? Colors.white : Theme.of(context).primaryColor, BlendMode.srcIn),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            items[index]['Title'],
                            style: TextStyle(fontSize: 16.sp, color: isTrue ? Colors.white : Theme.of(context).primaryColor, fontFamily: "SB"),
                          ),
                        ],
                      ),
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
        child: Obx(() {
          cc.isLoad.value;
          return CustomButton(
            isLoad: cc.isLoad.value,
            text: S.of(context).finish_step,
            onTap: cc.setProfileDetails,
            color: greenColor,
          );
        }),
      ),
    );
  }
}

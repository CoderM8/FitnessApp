import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fitness_ui/constant.dart';
import 'package:fitness_ui/custom_widget/custom_favorite_button.dart';
import 'package:fitness_ui/custom_widget/imageloader.dart';
import 'package:fitness_ui/exercise/start_training.dart';
import 'package:fitness_ui/home/home_page.dart';
import 'package:fitness_ui/model/exercise.dart';
import 'package:fitness_ui/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../custom_widget/custombutton.dart';
import '../generated/l10n.dart';
import '../light_dark_constant.dart';
import '../services/service.dart';

class ExerciseDetailsScreen extends StatefulWidget {
  const ExerciseDetailsScreen({required this.id, super.key});

  final String id;

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends State<ExerciseDetailsScreen> {
  final RxBool notification = true.obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
        future: HttpService.singleExercise(id: widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Column(
                children: [
                  AppBar(leading: const Back()),
                  const Spacer(),
                  SvgPicture.asset('assets/icons/exercise.svg', height: 100.w, width: 100.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                  SizedBox(height: 20.h),
                  Text(S.of(context).no_exercise, style: TextStyle(fontFamily: 'SB', fontSize: 18.sp)),
                  const Spacer(),
                ],
              );
            }
            final FitnessModel data = FitnessModel.fromJson(snapshot.data![0]);
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: MediaQuery.sizeOf(context).height / 2.2,
                    automaticallyImplyLeading: false,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    floating: true,
                    pinned: true,
                    leading: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 5.h, left: 10.w),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black.withOpacity(0.6)),
                        child: SvgPicture.asset(
                          'assets/icons/arrow_back.svg',
                          fit: BoxFit.none,
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    actions: [
                      Container(
                        height: 40.w,
                        width: 40.w,
                        margin: EdgeInsets.only(top: 5.h, right: 10.w),
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                        child: CustomButtonFav(
                          image: data.img,
                          id: int.parse(data.id),
                          type: data.exerciseType,
                          time: data.time,
                          title: data.title,
                        ),
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                        children: [
                          Expanded(child: Imageview(image: data.img)),
                          Baseline(
                            baseline: 5.h,
                            baselineType: TextBaseline.alphabetic,
                            child: Container(
                              height: 60.h,
                              margin: EdgeInsets.symmetric(horizontal: 20.w),
                              decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton.icon(
                                      onPressed: null,
                                      icon: SvgPicture.asset('assets/icons/calories.svg',
                                          height: 18.w, width: 18.w, fit: BoxFit.cover, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                                      label: Text(
                                        "${data.kcal} ${S.of(context).kcal}",
                                        style: TextStyle(fontSize: 12.sp, fontFamily: 'SB', color: Theme.of(context).primaryColor),
                                      ),
                                    ),
                                    SizedBox(width: 15.w),
                                    SizedBox(height: 20.h, child: const VerticalDivider(color: Colors.grey, thickness: 2)),
                                    SizedBox(width: 15.w),
                                    TextButton.icon(
                                      onPressed: null,
                                      icon: SvgPicture.asset('assets/icons/clock.svg',
                                          height: 16.w, width: 16.w, fit: BoxFit.cover, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                                      label: Text(
                                        '${data.time} ${S.of(context).min}',
                                        style: TextStyle(fontSize: 12.sp, fontFamily: 'SB', color: Theme.of(context).primaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(S.of(context).level, style: TextStyle(fontSize: 12.sp, fontFamily: 'M')),
                              SizedBox(height: 6.h),
                              Container(
                                height: 38.h,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: BoxDecoration(color: greyColor.withOpacity(0.12), borderRadius: BorderRadius.circular(8.r)),
                                child: Text(data.exerciseType, style: TextStyle(fontSize: 12.sp, fontFamily: 'SB')),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(S.of(context).Category, style: TextStyle(fontSize: 12.sp, fontFamily: 'M')),
                              SizedBox(height: 6.h),
                              Container(
                                height: 38.h,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: BoxDecoration(color: greyColor.withOpacity(0.12), borderRadius: BorderRadius.circular(8.r)),
                                child: Text(data.catList[0].title, style: TextStyle(fontSize: 12.sp, fontFamily: 'SB')),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(S.of(context).Weight, style: TextStyle(fontSize: 12.sp, fontFamily: 'M')),
                              SizedBox(height: 6.h),
                              Container(
                                height: 38.h,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: BoxDecoration(color: greyColor.withOpacity(0.12), borderRadius: BorderRadius.circular(8.r)),
                                child: Text('Lose', style: TextStyle(fontSize: 12.sp, fontFamily: 'SB')),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Text(data.title, style: TextStyle(fontFamily: 'B', fontSize: 20.sp), textAlign: TextAlign.start),
                      SizedBox(height: 15.h),
                      ReadMoreText(text: data.desc),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                    isScrollControlled: true,
                                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15.r), topRight: Radius.circular(15.r)),
                                    ),
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 23.h),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(S.of(context).Schedule_Exercise, style: TextStyle(fontFamily: 'B', fontSize: 20.sp)),
                                                IconButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  icon: Icon(Icons.close, color: Theme.of(context).primaryColor),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 10.h),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/calendar.svg',
                                                  colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
                                                ),
                                                SizedBox(width: 8.w),
                                                Obx(() {
                                                  selectedDate.value;
                                                  return Text(
                                                    '${S.of(context).Date}:- ${DateFormat('dd/MMMM/y').format(selectedDate.value)}',
                                                    style: TextStyle(fontSize: 14.sp, fontFamily: "SB"),
                                                  );
                                                }),
                                              ],
                                            ),
                                            SizedBox(height: 20.h),
                                            CalendarDatePicker2(
                                              config: CalendarDatePicker2WithActionButtonsConfig(
                                                  firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                                                  lastDate: DateTime(DateTime.now().year + 2),
                                                  calendarType: CalendarDatePicker2Type.single,
                                                  controlsTextStyle: TextStyle(fontFamily: 'M', fontSize: 18.sp),
                                                  yearTextStyle: TextStyle(fontFamily: 'M', fontSize: 16.sp),
                                                  monthTextStyle: TextStyle(fontFamily: 'M', fontSize: 16.sp),
                                                  selectedDayHighlightColor: greenColor,
                                                  monthBuilder: ({decoration, isCurrentMonth, isDisabled, isSelected, required month, textStyle}) {
                                                    return Container(
                                                      alignment: Alignment.center,
                                                      padding: EdgeInsets.zero,
                                                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                                                      decoration:
                                                          BoxDecoration(borderRadius: BorderRadius.circular(8.r), border: isCurrentMonth == true ? Border.all(color: greenColor, width: 2.w) : null),
                                                      child: Text(DateFormat().dateSymbols.SHORTMONTHS[month - 1],
                                                          style: TextStyle(fontFamily: "M", fontSize: 16.sp, color: isDisabled == true ? greyColor : Theme.of(context).primaryColor)),
                                                    );
                                                  },
                                                  dayBuilder: ({required date, decoration, isDisabled, isSelected, isToday, textStyle}) {
                                                    if (isSelected == true) {
                                                      return Container(
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.zero,
                                                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), color: greenColor),
                                                        child: Text(date.day.toString(),
                                                            style: TextStyle(fontFamily: "M", fontSize: 16.sp, color: isDisabled == true ? greyColor : Theme.of(context).primaryColor)),
                                                      );
                                                    }
                                                    return Container(
                                                      alignment: Alignment.center,
                                                      padding: EdgeInsets.zero,
                                                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), border: isToday == true ? Border.all(color: greenColor, width: 2.w) : null),
                                                      child: Text(date.day.toString(),
                                                          style: TextStyle(fontFamily: "M", fontSize: 16.sp, color: isDisabled == true ? greyColor : Theme.of(context).primaryColor)),
                                                    );
                                                  },
                                                  yearBuilder: ({decoration, isCurrentYear, isDisabled, isSelected, textStyle, required year}) {
                                                    return Container(
                                                      alignment: Alignment.center,
                                                      padding: EdgeInsets.zero,
                                                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                                                      decoration:
                                                          BoxDecoration(borderRadius: BorderRadius.circular(8.r), border: isCurrentYear == true ? Border.all(color: greenColor, width: 2.w) : null),
                                                      child: Text(year.toString(),
                                                          style: TextStyle(fontFamily: "M", fontSize: 16.sp, color: isDisabled == true ? greyColor : Theme.of(context).primaryColor)),
                                                    );
                                                  },
                                                  selectedDayTextStyle: TextStyle(fontFamily: 'M', fontSize: 16.sp),
                                                  todayTextStyle: TextStyle(fontFamily: 'M', fontSize: 16.sp),
                                                  dayBorderRadius: BorderRadius.circular(8.r),
                                                  yearBorderRadius: BorderRadius.circular(8.r),
                                                  weekdayLabelTextStyle: TextStyle(fontFamily: 'M', fontSize: 16.sp, color: greyColor),
                                                  dayTextStyle: TextStyle(fontFamily: 'M', fontSize: 16.sp)),
                                              value: const [],
                                              onValueChanged: (dates) {
                                                if (dates.isNotEmpty) {
                                                  selectedDate.value = dates[0];
                                                }
                                              },
                                            ),
                                            SizedBox(height: 10.h),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.asset('assets/icons/clock.svg',
                                                        height: 18.w, width: 18.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                                                    SizedBox(width: 8.w),
                                                    Text(S.of(context).time, style: TextStyle(fontSize: 14.sp, fontFamily: "SB")),
                                                  ],
                                                ),
                                                ElevatedButton.icon(
                                                  onPressed: () async {
                                                    await showTimePicker(context: context, initialTime: selectedTime.value).then((value) {
                                                      if (value != null) {
                                                        selectedTime.value = value;
                                                      }
                                                    });
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: greyColor.withOpacity(0.12),
                                                    fixedSize: Size(120.w, 38.h),
                                                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                                                  ),
                                                  label: Obx(() {
                                                    selectedTime.value;
                                                    return Text(selectedTime.value.format(context), style: TextStyle(fontSize: 14.sp, fontFamily: "SB", color: Colors.white));
                                                  }),
                                                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 20.h),
                                            ListTile(
                                              tileColor: greyColor.withOpacity(0.12),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                                              leading:
                                                  SvgPicture.asset('assets/icons/bell.svg', height: 18.w, width: 18.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                                              title: Text(
                                                S.of(context).Set_Reminder,
                                                style: TextStyle(fontSize: 14.sp, fontFamily: "SB", color: Theme.of(context).primaryColor),
                                              ),
                                              trailing: Obx(() {
                                                notification.value;
                                                return CupertinoSwitch(
                                                  value: notification.value,
                                                  activeColor: greenColor,
                                                  onChanged: (val) {
                                                    notification.value = val;
                                                  },
                                                );
                                              }),
                                            ),
                                            SizedBox(height: 15.h),
                                            Obx(() {
                                              notification.value;
                                              return CustomButton(
                                                enable: notification.value,
                                                text: S.of(context).done,
                                                onTap: () async {
                                                  if (userid != null) {
                                                    final date =
                                                        DateTime(selectedDate.value.year, selectedDate.value.month, selectedDate.value.day, selectedTime.value.hour, selectedTime.value.minute, 00);
                                                    await LocalNotificationService.zonedScheduleNotification(date, {
                                                      'route': "ExerciseDetails",
                                                      'method_name': 'workout_schedule',
                                                      'userId': userid,
                                                      'workout_date': selectedDate.value.toString(),
                                                      'workout_time': selectedTime.value.toString(),
                                                      'id': data.id,
                                                      'title': data.title,
                                                    });
                                                  } else {
                                                    showToast(S.of(context).login_Required);
                                                  }
                                                  Get.back();
                                                },
                                                color: greenColor,
                                              );
                                            }),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  fixedSize: Size(double.infinity, 45.h),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                                ),
                                icon: SvgPicture.asset(
                                  'assets/icons/calendar.svg',
                                  colorFilter: ColorFilter.mode(Theme.of(context).scaffoldBackgroundColor, BlendMode.srcIn),
                                ),
                                label: Text(S.of(context).Schedule, style: TextStyle(fontSize: 13.sp, fontFamily: 'SB', color: Theme.of(context).scaffoldBackgroundColor))),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: ElevatedButton.icon(
                                onPressed: () {
                                  if (userid != null) {
                                    if (data.fileUrl.isNotEmpty) {
                                      Get.to(() => StartTrainingScreen(url: data.fileUrl, time: data.time, name: data.title, relatedList: data.relatedList));
                                    }
                                  } else {
                                    showToast(S.of(context).login_Required);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: greenColor,
                                  fixedSize: Size(double.infinity, 45.h),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                                ),
                                icon: Icon(Icons.play_circle_outline, size: 22.sp, color: Colors.white),
                                label: Text(S.of(context).Start_now, style: TextStyle(fontSize: 13.sp, fontFamily: 'SB', color: Colors.white))),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Text(S.of(context).Exercise_Program, style: TextStyle(fontSize: 16.sp, fontFamily: 'B')),
                      SizedBox(height: 10.h),
                      if (data.relatedList.isNotEmpty)
                        AnimationLimiter(
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: data.relatedList.length,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                child: SlideAnimation(
                                  duration: const Duration(milliseconds: 375),
                                  horizontalOffset: 50,
                                  child: FadeInAnimation(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Imageview(image: data.relatedList[index].img, height: 91.h, width: 91.h, radius: 10.r),
                                        SizedBox(width: 15.w),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(data.relatedList[index].title, maxLines: 2, style: TextStyle(fontSize: 14.sp, fontFamily: 'SB')),
                                            SizedBox(height: 13.h),
                                            IntrinsicHeight(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SvgPicture.asset('assets/icons/calories.svg',
                                                      height: 15.w, width: 15.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                                                  SizedBox(width: 3.h),
                                                  Text('${data.relatedList[index].kcal} ${S.of(context).kcal}', style: TextStyle(fontSize: 12.sp, fontFamily: 'M')),
                                                  SizedBox(height: 10.h, child: const VerticalDivider(color: Colors.grey, thickness: 2)),
                                                  SvgPicture.asset('assets/icons/clock.svg', height: 12.w, width: 12.w, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
                                                  SizedBox(width: 3.h),
                                                  Text('${data.relatedList[index].time} ${S.of(context).min}', style: TextStyle(fontSize: 12.sp, fontFamily: 'M'))
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 9.h),
                                            Text(data.relatedList[index].exerciseType, style: TextStyle(fontSize: 13.sp, fontFamily: 'M')),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1, height: 28.h, color: Theme.of(context).primaryColor),
                          ),
                        ),
                      SizedBox(height: 15.h),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:fitness_ui/ui/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../custom_widget/custombutton.dart';
import '../generated/l10n.dart';
import '../light_dark_constant.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/tracking_permission.png", color: Theme.of(context).primaryColor, height: 180.w, width: 180.w),
            SizedBox(height: 30.h),
            Text(S.of(context).track_needed, style: TextStyle(fontFamily: 'B', fontSize: 18.sp), textAlign: TextAlign.center),
            SizedBox(height: 30.h),
            Text(S.of(context).track_text, style: TextStyle(fontFamily: 'M', fontSize: 14.sp), textAlign: TextAlign.center),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.h),
        child: CustomButton(
          text: S.of(context).Continue,
          onTap: () async {
            await AppTrackingTransparency.trackingAuthorizationStatus.then((status) async {
              // If the system can show an authorization request dialog
              if (status == TrackingStatus.notDetermined) {
                await AppTrackingTransparency.requestTrackingAuthorization();
              } else if (status == TrackingStatus.denied) {
                Get.dialog(Dialog(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                  child: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20.h),
                        Text(S.of(context).permission, style: TextStyle(fontSize: 20.sp, fontFamily: 'B', color: Theme.of(context).primaryColor), textAlign: TextAlign.center),
                        SizedBox(height: 20.h),
                        Text(
                          S.of(context).permission_text,
                          style: TextStyle(fontSize: 13.sp, fontFamily: 'M', color: Theme.of(context).primaryColor),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                text: S.of(context).cancel,
                                color: greyColor.withOpacity(0.12),
                                textColor: Theme.of(context).primaryColor,
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: CustomButton(
                                text: S.of(context).settings,
                                color: greenColor,
                                onTap: () async {
                                  await openAppSettings();
                                  Get.back();
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ));
              }
              if (kDebugMode) {
                print('HELLO PERMISSION STATUS $status');
              }
              Get.offAll(() => const LoginScreen());
            });
          },
          color: greenColor,
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_ui/ads_constant.dart';
import 'package:fitness_ui/apptheme/theme.dart';
import 'package:fitness_ui/constant.dart';
import 'package:fitness_ui/custom_widget/custombutton.dart';
import 'package:fitness_ui/custom_widget/imageloader.dart';
import 'package:fitness_ui/custom_widget/textfeild.dart';
import 'package:fitness_ui/home/change_password.dart';
import 'package:fitness_ui/home/home_page.dart';
import 'package:fitness_ui/home/my_favorite_page.dart';
import 'package:fitness_ui/localization/changeLanguage.dart';
import 'package:fitness_ui/ui/login_page.dart';
import 'package:fitness_ui/ui/privacy_policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../generated/l10n.dart';
import '../light_dark_constant.dart';
import '../services/service.dart';
import 'edit_profile_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          if (userid != null)
            IconButton(
              onPressed: () {
                Get.to(() => const EditProfileScreen());
              },
              icon: SvgPicture.asset('assets/icons/edit.svg', height: 20.h, width: 20.h, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)),
            )
        ],
        title: Text(S.of(context).Profile, style: TextStyle(fontFamily: 'SB', fontSize: 18.sp)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              userInfo;
              if (userInfo.isNotEmpty) {
                return Column(
                  children: [
                    Imageview(image: userInfo['Image'], height: 80.w, width: 80.w, circle: true),
                    SizedBox(height: 7.h),
                    Center(
                      child: Text(userInfo['Name'], style: TextStyle(fontSize: 20.sp, fontFamily: "B")),
                    ),
                    SizedBox(height: 30.h),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(userInfo['Weight'] + " " + userInfo['weightType'], style: TextStyle(fontSize: 16.sp, fontFamily: 'B')),
                              SizedBox(height: 5.h),
                              Text(S.of(context).Weight, style: TextStyle(fontSize: 12.sp, fontFamily: 'M'))
                            ],
                          ),
                          const VerticalDivider(color: Colors.grey),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(userInfo['Height'] + " " + userInfo['heightType'], style: TextStyle(fontSize: 16.sp, fontFamily: 'B')),
                              SizedBox(height: 5.h),
                              Text(S.of(context).Height, style: TextStyle(fontSize: 12.sp, fontFamily: 'M'))
                            ],
                          ),
                          const VerticalDivider(color: Colors.grey),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('${userInfo['Age']} Y', style: TextStyle(fontSize: 16.sp, fontFamily: 'B')),
                              SizedBox(height: 5.h),
                              Text(S.of(context).Age, style: TextStyle(fontSize: 12.sp, fontFamily: 'M'))
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(child: Divider(indent: 20.w, endIndent: 20.w)),
                        Text(S.of(context).your_goal, style: TextStyle(fontSize: 18.sp, fontFamily: 'B')),
                        Expanded(child: Divider(indent: 20.w, endIndent: 20.w)),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (userInfo['Goal'].toString().isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  userGoal(context, int.parse(userInfo['Goal']))['Svg'],
                                  height: 22.w,
                                  width: 22.w,
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
                                ),
                                SizedBox(height: 5.h),
                                Text(userGoal(context, int.parse(userInfo['Goal']))['Title'], style: TextStyle(fontSize: 12.sp, fontFamily: 'M')),
                              ],
                            ),
                          const VerticalDivider(color: Colors.grey),
                          if (userInfo['catId'].toString().isNotEmpty) ...[
                            FutureBuilder(
                                future: HttpService.exerciseByCategory(id: userInfo['catId']),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    if (snapshot.data == null || snapshot.data!.fitnessApp.isEmpty) {
                                      return const SizedBox.shrink();
                                    }
                                    return Column(
                                      children: [
                                        Imageview(image: snapshot.data!.fitnessApp[0].img, height: 25.h, width: 25.h, circle: true),
                                        SizedBox(height: 5.h),
                                        Text(snapshot.data!.fitnessApp[0].title, maxLines: 1, textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp, fontFamily: 'M'))
                                      ],
                                    );
                                  } else {
                                    return Column(
                                      children: [CircleAvatar(backgroundColor: greyColor, radius: 14.r), SizedBox(height: 5.h), Text("is load", style: TextStyle(fontSize: 12.sp, fontFamily: 'M'))],
                                    );
                                  }
                                }),
                          ],
                          const VerticalDivider(color: Colors.grey),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(userInfo['goalWeight'] + " " + userInfo['weightType'], style: TextStyle(fontSize: 16.sp, fontFamily: 'B')),
                              SizedBox(height: 5.h),
                              Text("${S.of(context).Goal} ${S.of(context).Weight}", style: TextStyle(fontSize: 12.sp, fontFamily: 'M'))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Shimmer.fromColors(
                    baseColor: greyColor.withOpacity(0.2),
                    highlightColor: greyColor,
                    child: Column(
                      children: [
                        CircleAvatar(radius: 40.r, backgroundColor: Colors.white),
                        SizedBox(height: 7.h),
                        Container(
                          height: 15.h,
                          width: 150.w,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  ProfileTile(
                    title: S.of(context).language,
                    svg: "assets/icons/language.svg",
                    color: const Color(0xff3498DB),
                    onTap: () {
                      Get.to(() => const ChangeLanguage());
                    },
                  ),
                  // ProfileTile(
                  //   title: S.of(context).my_subscription,
                  //   svg: "assets/icons/star.svg",
                  //   color: const Color(0xffA93226),
                  //   onTap: () {
                  //     Get.to(() => const SubscriptionPlans());
                  //   },
                  // ),
                  if (userid != null)
                    ProfileTile(
                      title: S.of(context).Change_Password,
                      svg: "assets/icons/lock.svg",
                      color: const Color(0xff8E44AD),
                      onTap: () {
                        Get.to(() => const ChangePasswordScreen());
                      },
                    ),
                  ProfileTile(
                    title: S.of(context).theme,
                    svg: "assets/icons/theme.svg",
                    color: const Color(0xffE67E22),
                    onTap: () {
                      Get.to(() => const ThemeChoice());
                    },
                  ),
                  ProfileTile(
                    title: S.of(context).my_favorites,
                    svg: "assets/icons/like.svg",
                    color: const Color(0xff2980B9),
                    onTap: () {
                      Get.to(() => const MyFavoriteScreen());
                    },
                  ),
                  ProfileTile(
                    title: S.of(context).privacy_policy,
                    svg: "assets/icons/privacy.svg",
                    color: const Color(0xffD4AC0D),
                    onTap: () {
                      Get.to(() => PrivacyPolicyScreen(data: appPrivacy!, title: S.of(context).privacy_policy));
                    },
                  ),
                  ProfileTile(
                    title: S.of(context).terms,
                    svg: "assets/icons/terms.svg",
                    color: const Color(0xff709000),
                    onTap: () {
                      Get.to(() => PrivacyPolicyScreen(data: appTerms!, title: S.of(context).terms));
                    },
                  ),
                  ProfileTile(
                    title: S.of(context).rate_us,
                    svg: "assets/icons/star.svg",
                    color: const Color(0xff7F8CCC),
                    onTap: () async {
                      final url = Uri.parse(rateApp);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                  ),
                  ProfileTile(
                    title: S.of(context).share_app,
                    svg: "assets/icons/share.svg",
                    color: const Color(0xff138D75),
                    onTap: () async {
                      if (isTab(context)) {
                        await Share.share("Pro Fitness: Exercises \n$shareApp", sharePositionOrigin: Rect.fromLTWH(0, 0, MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).height / 2));
                      } else {
                        await Share.share("Pro Fitness: Exercises \n$shareApp");
                      }
                    },
                  ),
                  if (userid != null)
                    ProfileTile(
                      title: S.of(context).delete_Account,
                      svg: "assets/icons/delete.svg",
                      color: const Color(0xffCB4335),
                      onTap: () {
                        Get.dialog(BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Dialog(
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                            child: Padding(
                              padding: EdgeInsets.all(10.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h),
                                  Text(
                                    S.of(context).delete_Account,
                                    style: TextStyle(color: Theme.of(context).primaryColor, fontFamily: 'SB', fontSize: 20.sp),
                                  ),
                                  SizedBox(height: 20.h),
                                  SvgPicture.asset(
                                    "assets/icons/delete.svg",
                                    fit: BoxFit.cover,
                                    width: 50.w,
                                    height: 50.w,
                                    colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                                  ),
                                  SizedBox(height: 20.h),
                                  Text(
                                    S.of(context).delete_text,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.sp, fontFamily: "M"),
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
                                          text: S.of(context).delete,
                                          color: greenColor,
                                          onTap: () async {
                                            await HttpService.deleteAccount(userId: userid!).then((value) async {
                                              Get.back();
                                              if (value!.fitnessApp[0].success == '1') {
                                                await FirebaseAuth.instance.signOut();
                                                await GoogleSignIn().signOut();
                                                final sharedPreferences = await SharedPreferences.getInstance();
                                                sharedPreferences.remove('userid');
                                                sharedPreferences.clear();
                                                userInfo.clear();
                                                Get.offAll(() => const LoginScreen());
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                ],
                              ),
                            ),
                          ),
                        ));
                      },
                    ),
                  if (userid != null)
                    ProfileTile(
                      title: S.of(context).logout,
                      svg: "assets/icons/logout.svg",
                      color: const Color(0xff28B463),
                      onTap: () async {
                        Get.dialog(BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Dialog(
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                            child: Padding(
                              padding: EdgeInsets.all(10.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h),
                                  Text(
                                    S.of(context).logout,
                                    style: TextStyle(color: Theme.of(context).primaryColor, fontFamily: 'SB', fontSize: 20.sp),
                                  ),
                                  SizedBox(height: 20.h),
                                  SvgPicture.asset(
                                    "assets/icons/logout.svg",
                                    fit: BoxFit.cover,
                                    width: 50.w,
                                    height: 50.w,
                                    colorFilter: const ColorFilter.mode(greenColor, BlendMode.srcIn),
                                  ),
                                  SizedBox(height: 20.h),
                                  Text(
                                    S.of(context).logout_text,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.sp, fontFamily: "M"),
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
                                          text: S.of(context).logout,
                                          color: greenColor,
                                          onTap: () async {
                                            await FirebaseAuth.instance.signOut();
                                            await GoogleSignIn().signOut();
                                            final sharedPreferences = await SharedPreferences.getInstance();
                                            sharedPreferences.remove('userid');
                                            sharedPreferences.clear();
                                            userInfo.clear();
                                            Get.back();
                                            Get.offAll(() => const LoginScreen());
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                ],
                              ),
                            ),
                          ),
                        ));
                      },
                    )
                  else
                    ProfileTile(
                      title: S.of(context).login,
                      svg: "assets/icons/logout.svg",
                      color: const Color(0xff28B463),
                      onTap: () async {
                        final sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.remove('userid');
                        sharedPreferences.clear();
                        userInfo.clear();
                        Get.offAll(() => const LoginScreen());
                      },
                    ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Center(child: Text("Version $version", style: TextStyle(fontSize: 12.sp, fontFamily: 'M'))),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}

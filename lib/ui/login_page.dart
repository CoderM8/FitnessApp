import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_ui/ads_constant.dart';
import 'package:fitness_ui/custom_widget/imageloader.dart';
import 'package:fitness_ui/light_dark_constant.dart';
import 'package:fitness_ui/ui/select_favorite_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../bottomNavigationbar.dart';
import '../constant.dart';
import '../custom_widget/custombutton.dart';
import '../custom_widget/textfeild.dart';
import '../firebase_options.dart';
import '../generated/l10n.dart';
import '../services/service.dart';
import 'createaccount_page.dart';
import 'forgotpassword_page.dart';
import 'privacy_policy_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey();
  final RxBool _showPassword = true.obs;
  final RxBool isLoad = false.obs;

  void toggleVisibility() {
    _showPassword.value = !_showPassword.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Form(
            key: globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 78.h),
                Text(S.of(context).loginPage_welcome, style: TextStyle(fontFamily: 'B', fontSize: 22.sp)),
                SizedBox(height: 8.h),
                Text(S.of(context).hello_sign, style: TextStyle(fontSize: 16.sp, fontFamily: 'M')),
                SizedBox(height: 30.h),
                Text(S.of(context).email_address, style: TextStyle(fontSize: 13.sp, fontFamily: 'M')),
                SizedBox(height: 8.h),
                CustomTextFiled(
                  textEditingController: emailAddress,
                  textInputType: TextInputType.emailAddress,
                  validation: (value) {
                    if (value!.isEmpty) {
                      return S.of(context).email_Required;
                    } else {
                      return null;
                    }
                  },
                  title: S.of(context).hint_title,
                ),
                SizedBox(height: 14.h),
                Text(
                  S.of(context).email_password,
                  style: TextStyle(fontSize: 13.sp, fontFamily: 'M'),
                ),
                SizedBox(height: 8.h),
                Obx(() {
                  _showPassword.value;
                  return CustomTextFiled(
                    maxLength: 8,
                    textEditingController: password,
                    showPassword: _showPassword.value,
                    title: '******',
                    icon: GestureDetector(
                      onTap: toggleVisibility,
                      child: Icon(
                        _showPassword.value ? Icons.visibility_off : Icons.visibility,
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
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const ForgotPasswordScreen());
                    },
                    child: Text(
                      S.of(context).forgot_password,
                      style: TextStyle(fontSize: 13.sp, fontFamily: 'SB'),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Obx(() {
                  isLoad.value;
                  return CustomButton(
                    isLoad: isLoad.value,
                    text: S.of(context).login,
                    onTap: () async {
                      if (globalKey.currentState!.validate()) {
                        isLoad.value = true;
                        await HttpService.login(email: emailAddress.text.trim(), password: password.text.trim(), type: 'normal').then((value) async {
                          isLoad.value = false;
                          if (value != null && value.fitnessApp.isNotEmpty) {
                            final user = value.fitnessApp[0];
                            final share = await SharedPreferences.getInstance();
                            share.setString('userid', user.userId);
                            await getUserId();
                            Get.offAll(() => const MyBottomNavigationBar());
                          }
                        });
                        isLoad.value = false;
                      }
                    },
                    color: const Color(0xffB0C929),
                  );
                }),
                SizedBox(height: 10.h),
                Align(
                  child: Text(S.of(context).login_with, style: TextStyle(fontFamily: "SB", fontSize: 13.sp)),
                ),
                SizedBox(height: 10.h),
                Obx(() {
                  isLoad.value;
                  return GestureDetector(
                    onTap: isLoad.value ? null : signInWithGoogle,
                    child: Container(
                      height: 55.h,
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Theme.of(context).primaryColor),
                      child: isLoad.value
                          ? AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear,
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: CircularProgressIndicator(color: Theme.of(context).scaffoldBackgroundColor, strokeWidth: 3.w),
                              ),
                            )
                          : Row(
                              children: [
                                SizedBox(width: 24.w),
                                SvgPicture.asset('assets/icons/google.svg', height: 24.h, width: 24.w),
                                const Spacer(),
                                Text(S.of(context).connect_with_google, style: TextStyle(fontSize: 14.sp, fontFamily: 'SB', color: Theme.of(context).scaffoldBackgroundColor)),
                                const Spacer(),
                                SizedBox(width: 24.w)
                              ],
                            ),
                    ),
                  );
                }),
                SizedBox(height: 10.h),
                if (defaultTargetPlatform == TargetPlatform.iOS)
                  Obx(() {
                    isLoad.value;
                    return GestureDetector(
                      onTap: isLoad.value ? null : signInWithApple,
                      child: Container(
                        height: 55.h,
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Theme.of(context).primaryColor),
                        child: isLoad.value
                            ? AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear,
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: 20.w,
                                  height: 20.w,
                                  child: CircularProgressIndicator(color: Theme.of(context).scaffoldBackgroundColor, strokeWidth: 3.w),
                                ),
                              )
                            : Row(
                                children: [
                                  SizedBox(width: 24.w),
                                  SvgPicture.asset(
                                    'assets/icons/apple_login.svg',
                                    height: 24.h,
                                    width: 24.w,
                                    colorFilter: ColorFilter.mode(Theme.of(context).scaffoldBackgroundColor, BlendMode.srcIn),
                                  ),
                                  const Spacer(),
                                  Text(S.of(context).connect_with_apple, style: TextStyle(fontSize: 14.sp, fontFamily: 'SB', color: Theme.of(context).scaffoldBackgroundColor)),
                                  const Spacer(),
                                  SizedBox(width: 24.w),
                                ],
                              ),
                      ),
                    );
                  }),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => PrivacyPolicyScreen(data: appTerms!, title: S.of(context).terms));
                      },
                      child: Text(S.of(context).terms, style: TextStyle(fontSize: 13.sp, fontFamily: 'SB')),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => PrivacyPolicyScreen(data: appPrivacy!, title: S.of(context).privacy_policy));
                      },
                      child: Text(S.of(context).privacy_policy, style: TextStyle(fontSize: 13.sp, fontFamily: 'SB')),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.of(context).do_not_have_an_account, style: TextStyle(fontSize: 13.sp, fontFamily: 'M')),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => CreateAccountScreen());
                        },
                        child: Text(" ${S.of(context).register}", style: TextStyle(fontSize: 14.sp, fontFamily: 'B')),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: S.of(context).guest,
                  onTap: () async {
                    final share = await SharedPreferences.getInstance();
                    share.remove('userid');
                    userid = null;
                    await getUserId();
                    Get.offAll(() => const MyBottomNavigationBar());
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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: DefaultFirebaseOptions.currentPlatform.iosClientId);

  Future<void> signInWithGoogle() async {
    try {
      isLoad.value = false;
      isLoad.value = true;
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        isLoad.value = false;
        return;
      }
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken);
      final UserCredential result = await _auth.signInWithCredential(credential);

      final email = result.user?.email;
      final name = result.user?.displayName;
      final image = result.user?.photoURL;

      final share = await SharedPreferences.getInstance();
      share.remove('Id');
      await HttpService.register(email: email!, type: 'google', name: name!, image: image, authId: googleSignInAuthentication.accessToken).then((value) async {
        isLoad.value = false;
        if (value != null && value.fitnessApp.isNotEmpty) {
          final user = value.fitnessApp[0];
          if (user.weight.isEmpty || user.age.isEmpty || user.height.isEmpty || user.goals.isEmpty || user.goalWeight.isEmpty) {
            share.setString('Id', user.userId);
            Get.offAll(() => SelectFavouriteScreen());
          } else {
            share.setString('userid', user.userId);
            await getUserId();
            Get.offAll(() => const MyBottomNavigationBar());
          }
        }
      });
      isLoad.value = false;
    } on FirebaseAuthException catch (e, t) {
      showToast('Something went Wrong!!');
      if (kDebugMode) {
        print('HttpService signInWithGoogle ERROR ${e.message} ---- $t');
      }
    }
  }

  Future<void> signInWithApple() async {
    try {
      isLoad.value = false;
      isLoad.value = true;
      final credential = await SignInWithApple.getAppleIDCredential(scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName]);
      final String? appleId = credential.userIdentifier;

      final oAuthProvider = OAuthProvider('apple.com');
      final OAuthCredential credentialAuth = oAuthProvider.credential(idToken: credential.identityToken, accessToken: credential.authorizationCode);
      final UserCredential result = await _auth.signInWithCredential(credentialAuth);

      final email = result.user?.email;
      final name = result.user!.displayName ?? "";
      final image = result.user!.photoURL ?? "";
      final share = await SharedPreferences.getInstance();
      share.remove('Id');
      await HttpService.register(email: email!, type: 'apple', name: name, authId: appleId, image: image).then((value) async {
        isLoad.value = false;
        if (value != null && value.fitnessApp.isNotEmpty) {
          final user = value.fitnessApp[0];
          if (user.weight.isEmpty || user.age.isEmpty || user.height.isEmpty || user.goals.isEmpty || user.goalWeight.isEmpty) {
            share.setString('Id', user.userId);
            Get.offAll(() => SelectFavouriteScreen());
          } else {
            share.setString('userid', user.userId);
            await getUserId();
            Get.offAll(() => const MyBottomNavigationBar());
          }
        }
      });
      isLoad.value = false;
    } on FirebaseAuthException catch (e, t) {
      isLoad.value = false;
      if (kDebugMode) {
        print('HttpService signInWithApple ERROR ${e.message} ---- $t');
      }
    }
  }
}

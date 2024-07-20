import 'package:fitness_ui/light_dark_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    unselectedWidgetColor: const Color(0xffe2e2e2),
    dialogBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
      ),
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 18.sp / SchedulerBinding.instance.platformDispatcher.textScaleFactor),
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      dialBackgroundColor: greenColor,
      // color for AM/PM
      dayPeriodColor: Colors.black,
      dialHandColor: Colors.white,
      dayPeriodBorderSide: const BorderSide(color: Colors.black),
      hourMinuteTextStyle: TextStyle(fontFamily: 'M', fontSize: 16.sp),
      hourMinuteColor: greenColor,
      dialTextColor: Colors.black,
      dialTextStyle: TextStyle(fontFamily: 'M', fontSize: 16.sp),
      dayPeriodTextStyle: TextStyle(fontFamily: 'M', fontSize: 16.sp),
      dayPeriodTextColor: Colors.white,
      helpTextStyle: TextStyle(fontFamily: 'M', fontSize: 18.sp),
    ),
    colorScheme: const ColorScheme.light(
        secondary: Colors.black,
        background: Colors.white,
        primary: Colors.black,
        onPrimary: Color(0xff999999),
        onSecondary: Colors.white,
        primaryContainer: Color(0xfff4f4f4),
        secondaryContainer: Color(0xffe4e4e4),
        brightness: Brightness.light,
        onSecondaryContainer: Color(0xffc6c6c6),
        onPrimaryContainer: Color(0xff939393),
        surface: Color(0xfff4f4f4)),
    listTileTheme: const ListTileThemeData(tileColor: Color(0xff6f6f6f), textColor: Colors.white),
    dialogTheme:
        DialogTheme(titleTextStyle: TextStyle(color: Colors.black, fontSize: 15.sp / SchedulerBinding.instance.platformDispatcher.textScaleFactor), backgroundColor: Colors.white),
    iconTheme: const IconThemeData(color: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
    ),
    textTheme: TextTheme(displayLarge: h1StyleLight, displayMedium: h2StyleLight, displaySmall: h3StyleLight, headlineMedium: h4StyleLight, headlineSmall: h5StyleLight),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Colors.black),
        unselectedIconTheme: IconThemeData(color: greyColor),
        selectedItemColor: Colors.black,
        unselectedItemColor: greyColor),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    unselectedWidgetColor: const Color(0xff292929),
    dialogBackgroundColor: const Color(0xff292929),
    dividerColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(fontSize: 18.sp / SchedulerBinding.instance.platformDispatcher.textScaleFactor),
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark),
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      dialBackgroundColor: greenColor,
      dayPeriodColor: greenColor,
      // color for AM/PM
      dialHandColor: Colors.black,
      dayPeriodBorderSide: const BorderSide(color: Colors.white),
      hourMinuteTextStyle: TextStyle(fontFamily: 'M', fontSize: 16.sp, color: Colors.white),
      hourMinuteColor: greenColor,
      dialTextColor: Colors.white,
      dialTextStyle: TextStyle(fontFamily: 'M', fontSize: 16.sp),
      dayPeriodTextStyle: TextStyle(fontFamily: 'M', fontSize: 16.sp),
      dayPeriodTextColor: Colors.white,
      helpTextStyle: TextStyle(fontFamily: 'M', fontSize: 18.sp),
    ),
    colorScheme: const ColorScheme.dark(
        background: Color(0xff292929),
        primary: Colors.white,
        onPrimary: Color(0xff98999b),
        secondary: greenColor,
        onSecondary: greenColor,
        primaryContainer: Color(0xff292929),
        secondaryContainer: Color(0xff292929),
        onSecondaryContainer: Color(0xff292929),
        onPrimaryContainer: Color(0xff292929),
        surface: Color(0xff6f6f6f),
        brightness: Brightness.dark),
    listTileTheme: const ListTileThemeData(tileColor: Color(0xff292929), textColor: Colors.white),
    dialogTheme: DialogTheme(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 15.sp / SchedulerBinding.instance.platformDispatcher.textScaleFactor), backgroundColor: const Color(0xff6f6f6f)),
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: TextTheme(displayLarge: h1StyleDark, displayMedium: h2StyleDark, displaySmall: h3StyleDark, headlineMedium: h4StyleDark, headlineSmall: h5StyleDark),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: greenColor, foregroundColor: Colors.white)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedIconTheme: IconThemeData(color: Colors.white),
        unselectedIconTheme: IconThemeData(color: greyColor),
        selectedItemColor: Colors.white,
        unselectedItemColor: greyColor),
  );

  static void setSystemUIOverlayStyle(ThemeMode mode) async {
    switch (mode) {
      case ThemeMode.system:
        if (SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.dark.copyWith(
                systemNavigationBarColor: Colors.black,
                systemNavigationBarIconBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.light,
                statusBarColor: Colors.transparent,
                statusBarBrightness: Brightness.dark),
          );
          isDark.value = true;
        } else {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.light.copyWith(
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light,
            ),
          );
          isDark.value = false;
        }
        break;
      case ThemeMode.light:
        {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.light.copyWith(
                systemNavigationBarColor: Colors.white,
                systemNavigationBarIconBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.transparent,
                statusBarBrightness: Brightness.light),
          );
          isDark.value = false;
        }
        break;
      case ThemeMode.dark:
        {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.dark.copyWith(
              systemNavigationBarColor: Colors.black,
              systemNavigationBarIconBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark,
            ),
          );
          isDark.value = true;
        }
        break;
    }
  }
}

/// Light Mode
final TextStyle h1StyleLight = TextStyle(fontSize: 17.5.sp / SchedulerBinding.instance.platformDispatcher.textScaleFactor, color: const Color(0xff101010), fontFamily: 'R');
final TextStyle h2StyleLight = TextStyle(fontSize: 15.sp / SchedulerBinding.instance.platformDispatcher.textScaleFactor, fontFamily: "R", color: const Color(0xff525252));

final TextStyle h3StyleLight = TextStyle(color: const Color(0xffcacaca), fontFamily: "R", fontSize: 20.sp / SchedulerBinding.instance.platformDispatcher.textScaleFactor);
final TextStyle h4StyleLight = TextStyle(fontSize: 15.sp / SchedulerBinding.instance.platformDispatcher.textScaleFactor, color: const Color(0xff2d2d2d), fontFamily: "R");

final TextStyle h5StyleLight = TextStyle(fontSize: 18.sp / SchedulerBinding.instance.platformDispatcher.textScaleFactor, color: Colors.black, fontFamily: "B");

/// Dark Mode
final TextStyle h1StyleDark = TextStyle(fontSize: 17.5.sp / SchedulerBinding.instance.platformDispatcher.textScaleFactor, color: const Color(0xfff0f0f0), fontFamily: 'R');
final TextStyle h2StyleDark = TextStyle(fontSize: 15.sp / SchedulerBinding.instance.platformDispatcher.textScaleFactor, color: const Color(0xffc5c5c5), fontFamily: "R");

final TextStyle h3StyleDark = TextStyle(color: const Color(0xffabacac), fontFamily: "R", fontSize: 20.sp / SchedulerBinding.instance.platformDispatcher.textScaleFactor);
final TextStyle h4StyleDark = TextStyle(fontSize: 15.sp / SchedulerBinding.instance.platformDispatcher.textScaleFactor, color: const Color(0xff949494), fontFamily: "R");

final TextStyle h5StyleDark = TextStyle(fontSize: 18.sp / SchedulerBinding.instance.platformDispatcher.textScaleFactor, color: const Color(0xff00ff89), fontFamily: "B");

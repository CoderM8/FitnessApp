import 'package:fitness_ui/apptheme/themeNotifier.dart';
import 'package:fitness_ui/custom_widget/custombutton.dart';
import 'package:fitness_ui/generated/l10n.dart';
import 'package:fitness_ui/light_dark_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChoice extends StatefulWidget {
  const ThemeChoice({super.key});

  @override
  ThemeChoiceState createState() => ThemeChoiceState();
}

class ThemeChoiceState extends State<ThemeChoice> {
  void changeTheme(ThemeMode mode, ThemeModeNotifier themeModeNotifier) async {
    final prefs = await SharedPreferences.getInstance();
    themeMode = mode.index;
    Get.changeThemeMode(mode);
    themeModeNotifier.setThemeMode(mode);
    prefs.setInt('themeMode', mode.index);
  }

  @override
  Widget build(BuildContext context) {
    final themeModeNotifier = Provider.of<ThemeModeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Back(),
        title: Text(S.of(context).theme, style: TextStyle(fontFamily: 'SB', fontSize: 18.sp)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            ListTile(
              tileColor: greyColor.withOpacity(0.12),
              title: Text(S.of(context).device, style: TextStyle(fontFamily: 'SB', fontSize: 12.sp, color: Theme.of(context).primaryColor)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              trailing: CupertinoSwitch(
                  value: themeMode == 0,
                  activeColor: greenColor,
                  onChanged: (val) async {
                    if (val == true) {
                      changeTheme(ThemeMode.system, themeModeNotifier);
                    } else {
                      changeTheme(ThemeMode.light, themeModeNotifier);
                    }
                  }),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10.h)),
            Text(S.of(context).device_text, style: TextStyle(color: Theme.of(context).primaryColor, fontFamily: 'M', fontSize: 13.sp)),
            Padding(padding: EdgeInsets.symmetric(vertical: 10.h)),
            ListTile(
              tileColor: greyColor.withOpacity(0.12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              onTap: themeMode != 0
                  ? () {
                      changeTheme(ThemeMode.light, themeModeNotifier);
                    }
                  : null,
              title: Text(S.of(context).light, style: TextStyle(color: Theme.of(context).primaryColor, fontFamily: 'SB', fontSize: 12.sp)),
              trailing: themeMode == 1
                  ? SvgPicture.asset('assets/icons/check.svg', height: 25.w, width: 25.w, colorFilter: const ColorFilter.mode(greenColor, BlendMode.srcIn))
                  : Icon(Icons.radio_button_unchecked, color: greyColor, size: 25.h),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10.h)),
            ListTile(
              tileColor: greyColor.withOpacity(0.12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              onTap: themeMode != 0
                  ? () {
                      changeTheme(ThemeMode.dark, themeModeNotifier);
                    }
                  : null,
              title: Text(S.of(context).dark, style: TextStyle(color: Theme.of(context).primaryColor, fontFamily: 'SB', fontSize: 12.sp)),
              trailing: themeMode == 2
                  ? SvgPicture.asset('assets/icons/check.svg', height: 25.w, width: 25.w, colorFilter: const ColorFilter.mode(greenColor, BlendMode.srcIn))
                  : Icon(Icons.radio_button_unchecked, color: greyColor, size: 25.h),
            ),
          ],
        ),
      ),
    );
  }
}

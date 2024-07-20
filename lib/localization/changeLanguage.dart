import 'package:fitness_ui/custom_widget/custombutton.dart';
import 'package:fitness_ui/custom_widget/imageloader.dart';
import 'package:fitness_ui/generated/l10n.dart';
import 'package:fitness_ui/light_dark_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  AppLanguage(this.id, this.flag, this.name, this.languageCode);

  static List<AppLanguage> get list {
    return <AppLanguage>[
      AppLanguage(1, "🇺🇸", "English", "en"),
      AppLanguage(2, "🇪🇸", "España", "es"),
      AppLanguage(3, "🇫🇷", "Französisch", "fr"),
      AppLanguage(4, "🇵🇹", "Portuguese", "pt"),
      AppLanguage(5, "🇩🇪", "German", "de"),
      AppLanguage(6, "🇮🇹", "italian", "it"),
    ];
  }
}

final RxInt selectedIndex = 0.obs;

class ChangeLanguage extends GetView {
  const ChangeLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    final indexx = AppLanguage.list.indexWhere((element) => element.languageCode == languageCode);
    if (!indexx.isNegative) {
      selectedIndex.value = indexx;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).language, style: TextStyle(fontFamily: 'SB', fontSize: 18.sp)),
        leading: const Back(),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        itemCount: AppLanguage.list.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final AppLanguage language = AppLanguage.list[index];
          return Obx(() {
            final bool active = (selectedIndex.value == index);
            return ListTile(
              tileColor: greyColor.withOpacity(0.12),
              title: Text(language.name, style: TextStyle(fontFamily: 'SB', fontSize: 14.sp, color: Theme.of(context).primaryColor)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              leading: Text(language.flag, textAlign: TextAlign.start, style: TextStyle(fontSize: 25.sp)),
              trailing: active
                  ? SvgPicture.asset(
                      "assets/icons/check.svg",
                      height: 25.w,
                      width: 25.w,
                      colorFilter: const ColorFilter.mode(greenColor, BlendMode.srcIn),
                    )
                  : Icon(Icons.radio_button_unchecked, color: greyColor, size: 25.h),
              onTap: () async {
                selectedIndex.value = index;
                final sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('languageCode', language.languageCode);
                languageCode = language.languageCode;
                Get.updateLocale(Locale(language.languageCode));
              },
            );
          });
        },
        separatorBuilder: (context, index) => SizedBox(height: 8.h),
      ),
    );
  }
}

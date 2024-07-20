import 'package:fitness_ui/custom_widget/imageloader.dart';
import 'package:fitness_ui/generated/l10n.dart';
import 'package:fitness_ui/light_dark_constant.dart';
import 'package:fitness_ui/services/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart';

final RxMap userInfo = {}.obs;

class UserProfile {
  static Future<void> getProfile() async {
    userInfo.clear();
    if (userid != null) {
      await HttpService.userprofile(userid).then((value) {
        if (value != null && value.fitnessApp.isNotEmpty) {
          final data = value.fitnessApp[0];
          userInfo.addAll({
            'Id': data.id,
            'Name': data.name.isNotEmpty ? data.name : "User",
            'Image': data.userImage.isNotEmpty ? data.userImage : "https://vocsyinfotech.in/vocsy/flutter/Flutter_New_Fitness/images/add-image.png",
            'Email': data.email.isNotEmpty ? data.email : 'dummy@gmail.com',
            'Phone': data.phone.isNotEmpty ? data.phone : '00000 00000',
            'Goal': data.goals.isNotEmpty ? data.goals : "0",
            'Age': data.age.isNotEmpty ? data.age : "+18",
            'Height': data.userHeight.isNotEmpty ? data.userHeight : "5",
            'Weight': data.weight.isNotEmpty ? data.weight : "22",
            "weightType": data.weightType.isNotEmpty ? data.weightType : "KG",
            "heightType": data.heightType.isNotEmpty ? data.heightType : "CM",
            "catId": data.catId.isNotEmpty ? data.catId : "64",
            "goalWeight": data.goalWeight.isNotEmpty ? data.goalWeight : "22",
          });
        }
      });
    } else {
      userInfo.addAll({
        'Id': 'Guest',
        'Name': "Guest",
        'Image': "https://vocsyinfotech.in/vocsy/flutter/Flutter_New_Fitness/images/add-image.png",
        'Email': 'dummy@gmail.com',
        'Phone': '00000 00000',
        'Goal': '0',
        'Age': "+18",
        'Height': '5',
        'Weight': "22",
        "weightType": 'KG',
        "heightType": 'CM',
        "catId": '64',
        "goalWeight": '22',
      });
    }
  }
}

Map userGoal(context, index) {
  final List items = [
    {"Title": S.of(context).weight_loss, "Svg": 'assets/icons/weightLoss.svg'},
    {"Title": S.of(context).gain_muscle, "Svg": 'assets/icons/muscle.svg'},
    {"Title": S.of(context).improve_fitness, "Svg": 'assets/icons/fitness.svg'}
  ];
  return items[index];
}

String get greetings {
  final DateTime now = DateTime.now();
  final int hours = now.hour;

  if (hours >= 1 && hours <= 12) {
    return Intl.message("good_morning");
  } else if (hours >= 12 && hours <= 16) {
    return Intl.message("good_afternoon");
  } else {
    return Intl.message("good_evening");
  }
}

void showToast(msg) {
  Fluttertoast.showToast(msg: msg, backgroundColor: greenColor, fontSize: 15.sp, gravity: ToastGravity.BOTTOM, textColor: Colors.white, toastLength: Toast.LENGTH_LONG);
}

class Api {
  static const mainApi = 'https://vocsyinfotech.in/envato/cc/flutter_fitness_new/';
}

bool isTab(BuildContext context) {
  return MediaQuery.sizeOf(context).width >= 600 && MediaQuery.sizeOf(context).width < 2048;
}

class ReadMoreText extends StatefulWidget {
  final String text;

  const ReadMoreText({super.key, required this.text});

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  final RxBool _isExpanded = false.obs;

  void _toggleReadMore() {
    _isExpanded.value = !_isExpanded.value;
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.text;
    return Obx(() {
      _isExpanded.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Html(
            data: text,
            style: {
              "body": Style(fontFamily: "M", fontSize: FontSize(12.sp), maxLines: _isExpanded.value ? 99999 : 2, textAlign: TextAlign.start, color: Theme.of(context).primaryColor),
              'h1': Style(fontFamily: "SB", fontSize: FontSize(12.sp), textAlign: TextAlign.start, color: Theme.of(context).primaryColor),
              'strong': Style(fontFamily: "B", fontSize: FontSize(13.sp), textAlign: TextAlign.start, color: greenColor),
            },
          ),
          if (text.length > 20)
            InkWell(
              onTap: _toggleReadMore,
              child: Text(
                _isExpanded.value ? S.of(context).read_less : S.of(context).read_more,
                style: TextStyle(fontSize: 12.sp, fontFamily: 'SB', color: greenColor),
              ),
            ),
        ],
      );
    });
  }
}

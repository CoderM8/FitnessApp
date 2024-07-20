import 'package:fitness_ui/custom_widget/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key, required this.data, required this.title});

  final String data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Back(),
        title: Text(title, style: TextStyle(fontFamily: 'SB', fontSize: 18.sp)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Html(
            data: data,
            shrinkWrap: true,
            style: {
              "body": Style(fontFamily: "M", fontSize: FontSize(12.sp), textAlign: TextAlign.start, color: Theme.of(context).primaryColor),
              'h1': Style(fontFamily: "SB", fontSize: FontSize(12.sp), textAlign: TextAlign.start, color: Theme.of(context).primaryColor),
              'strong': Style(fontFamily: "B", fontSize: FontSize(13.sp), textAlign: TextAlign.start, color: Theme.of(context).primaryColor),
            },
          ),
        ),
      ),
    );
  }
}

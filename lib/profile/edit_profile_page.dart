import 'dart:io';
import 'package:fitness_ui/constant.dart';
import 'package:fitness_ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../custom_widget/custombutton.dart';
import '../custom_widget/textfeild.dart';
import '../generated/l10n.dart';
import '../light_dark_constant.dart';
import '../services/service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController goalWeight = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController age = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? imageProfile;

  Future<void> imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    }
  }

  void _cropImage(filePath) async {
    final croppedImage = await ImageCropper().cropImage(
        sourcePath: filePath,
        uiSettings: [
          AndroidUiSettings(toolbarTitle: 'Crop Image', cropStyle: CropStyle.circle),
          IOSUiSettings(title: 'Crop Image', aspectRatioPickerButtonHidden: true, cropStyle: CropStyle.circle, cancelButtonTitle: Intl.message('Cancel'), doneButtonTitle: Intl.message('done')),
        ],
        maxWidth: 1080,
        maxHeight: 1080);
    if (croppedImage != null) {
      imageProfile = File(croppedImage.path);
      setState(() {});
    }
  }

  @override
  void initState() {
    if (userInfo.isNotEmpty) {
      name.text = userInfo['Name'];
      phone.text = userInfo['Phone'];
      email.text = userInfo['Email'];
      isKg.value = userInfo['weightType'].toString().contains('KG');
      isCm.value = userInfo['heightType'].toString().contains('CM');
      weight.text = userInfo['Weight'];
      goalWeight.text = userInfo['goalWeight'];
      height.text = userInfo['Height'];
      age.text = userInfo['Age'];
      setState(() {});
    }
    super.initState();
  }

  final RxBool isKg = true.obs;
  final RxBool isCm = true.obs;
  final RxBool isLoad = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Back(),
        title: Text(S.of(context).Edit_Profile, style: TextStyle(fontFamily: 'SB', fontSize: 18.sp)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  if (imageProfile == null)
                    Imageview(image: userInfo['Image'], height: 120.h, width: 120.h, circle: true)
                  else
                    Container(
                      height: 120.h,
                      width: 120.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: FileImage(imageProfile!), fit: BoxFit.cover),
                      ),
                    ),
                  Positioned(
                    bottom: -5.h,
                    right: 0.w,
                    child: IconButton(
                      onPressed: imgFromGallery,
                      icon: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: SvgPicture.asset(
                          'assets/icons/camera.svg',
                          height: 12.h,
                          width: 12.w,
                          colorFilter: ColorFilter.mode(Theme.of(context).scaffoldBackgroundColor, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(S.of(context).full_name, style: TextStyle(fontSize: 13.sp, fontFamily: "M")),
            SizedBox(height: 8.h),
            CustomTextFiled(
              textEditingController: name,
              title: S.of(context).full_name,
              textInputType: TextInputType.text,
            ),
            SizedBox(height: 14.h),
            Text(S.of(context).phone, style: TextStyle(fontSize: 13.sp, fontFamily: "M")),
            SizedBox(height: 8.h),
            CustomTextFiled(
              textEditingController: phone,
              textInputType: Platform.isIOS ? const TextInputType.numberWithOptions(signed: true, decimal: false) : TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              title: S.of(context).phone,
            ),
            SizedBox(height: 14.h),
            Text(S.of(context).email, style: TextStyle(fontSize: 13.sp, fontFamily: "M")),
            SizedBox(height: 8.h),
            CustomTextFiled(textEditingController: email, title: '', readOnly: true),
            SizedBox(height: 14.h),
            Text(S.of(context).Weight, style: TextStyle(fontSize: 13.sp, fontFamily: "M")),
            SizedBox(height: 8.h),
            Obx(() {
              isKg.value;
              return TextFormField(
                controller: weight,
                style: TextStyle(fontSize: 16.sp, color: Theme.of(context).primaryColor, fontFamily: "SB"),
                cursorColor: Theme.of(context).primaryColor,
                keyboardType: Platform.isIOS ? const TextInputType.numberWithOptions(signed: true, decimal: false) : TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
                decoration: InputDecoration(
                  suffixIcon: Container(
                    height: 45.h,
                    width: 120.w,
                    margin: EdgeInsets.only(top: 5.h, right: 5.w, bottom: 5.h),
                    padding: EdgeInsets.all(5.r),
                    decoration: BoxDecoration(color: greyColor.withOpacity(0.12), borderRadius: BorderRadius.circular(10.r)),
                    child: Obx(() {
                      isKg.value;
                      return Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                if (isKg.value) {
                                  isKg.value = false;
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5.r),
                                decoration: BoxDecoration(color: isKg.value ? Colors.transparent : Colors.white, borderRadius: BorderRadius.circular(10.r)),
                                child: Text(S.of(context).lbs, style: TextStyle(color: isKg.value ? Theme.of(context).primaryColor : Colors.black, fontFamily: 'M', fontSize: 14.sp)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                if (!isKg.value) {
                                  isKg.value = true;
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5.r),
                                decoration: BoxDecoration(color: !isKg.value ? Colors.transparent : Colors.white, borderRadius: BorderRadius.circular(10.r)),
                                child: Text(S.of(context).kg, style: TextStyle(color: !isKg.value ? Theme.of(context).primaryColor : Colors.black, fontFamily: 'M', fontSize: 14.sp)),
                              ),
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                  fillColor: greyColor.withOpacity(0.12),
                  filled: true,
                  hintText: '',
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14.sp, fontFamily: "M"),
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10.r)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10.r)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10.r)),
                  errorBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10.r)),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10.r)),
                ),
              );
            }),
            SizedBox(height: 14.h),
            Text("${S.of(context).Goal} ${S.of(context).Weight}", style: TextStyle(fontSize: 13.sp, fontFamily: "M")),
            SizedBox(height: 8.h),
            CustomTextFiled(
              textEditingController: goalWeight,
              textAlign: TextAlign.start,
              textInputType: Platform.isIOS ? const TextInputType.numberWithOptions(signed: true, decimal: false) : TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
              title: '00',
              icon: Container(
                height: 45.h,
                width: 60.w,
                margin: EdgeInsets.only(top: 5.h, right: 5.w, bottom: 5.h),
                padding: EdgeInsets.all(5.r),
                decoration: BoxDecoration(color: greyColor.withOpacity(0.12), borderRadius: BorderRadius.circular(10.r)),
                child: Obx(() {
                  isKg.value;
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.r),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
                    child: Text(isKg.value ? S.of(context).kg : S.of(context).lbs, style: TextStyle(color: Colors.black, fontFamily: 'M', fontSize: 16.sp)),
                  );
                }),
              ),
            ),
            SizedBox(height: 14.h),
            Text(S.of(context).Height, style: TextStyle(fontSize: 13.sp, fontFamily: "M")),
            SizedBox(height: 8.h),
            Obx(() {
              isCm.value;
              return TextFormField(
                controller: height,
                style: TextStyle(fontSize: 16.sp, color: Theme.of(context).primaryColor, fontFamily: "SB"),
                cursorColor: Theme.of(context).primaryColor,
                keyboardType: Platform.isIOS ? const TextInputType.numberWithOptions(signed: true, decimal: false) : TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
                decoration: InputDecoration(
                  suffixIcon: Container(
                    height: 45.h,
                    width: 120.w,
                    margin: EdgeInsets.only(top: 5.h, right: 5.w, bottom: 5.h),
                    padding: EdgeInsets.all(5.r),
                    decoration: BoxDecoration(color: greyColor.withOpacity(0.12), borderRadius: BorderRadius.circular(10.r)),
                    child: Obx(() {
                      isCm.value;
                      return Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                if (isCm.value) {
                                  isCm.value = false;
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5.r),
                                decoration: BoxDecoration(color: isCm.value ? Colors.transparent : Colors.white, borderRadius: BorderRadius.circular(10.r)),
                                child: Text(S.of(context).feet, style: TextStyle(color: isCm.value ? Theme.of(context).primaryColor : Colors.black, fontFamily: 'M', fontSize: 14.sp)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                if (!isCm.value) {
                                  isCm.value = true;
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5.r),
                                decoration: BoxDecoration(color: !isCm.value ? Colors.transparent : Colors.white, borderRadius: BorderRadius.circular(10.r)),
                                child: Text(S.of(context).cm, style: TextStyle(color: !isCm.value ? Theme.of(context).primaryColor : Colors.black, fontFamily: 'M', fontSize: 14.sp)),
                              ),
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                  fillColor: greyColor.withOpacity(0.12),
                  filled: true,
                  hintText: '',
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14.sp, fontFamily: "M"),
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10.r)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10.r)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10.r)),
                  errorBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10.r)),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10.r)),
                ),
              );
            }),
            SizedBox(height: 14.h),
            Text(S.of(context).Age, style: TextStyle(fontSize: 13.sp, fontFamily: "M")),
            SizedBox(height: 8.h),
            CustomTextFiled(
              textEditingController: age,
              textInputType: Platform.isIOS ? const TextInputType.numberWithOptions(signed: true, decimal: false) : TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
              title: '+18',
            ),
            SizedBox(height: 20.h),
            Obx(() {
              isLoad.value;
              return CustomButton(
                text: S.of(context).Save,
                isLoad: isLoad.value,
                onTap: () async {
                  isLoad.value = true;
                  await HttpService.profileUpdateService(
                          image: imageProfile,
                          age: age.text.isNotEmpty ? age.text : "+18",
                          email: email.text.isNotEmpty ? email.text : "",
                          height: height.text.isNotEmpty ? height.text : "5",
                          name: name.text.isNotEmpty ? name.text : "User",
                          phone: phone.text.isNotEmpty ? phone.text : "",
                          weight: weight.text.isNotEmpty ? weight.text : "22",
                          goalWeight: goalWeight.text.isNotEmpty ? goalWeight.text : "22",
                          catId: userInfo['catId'].toString().isNotEmpty ? userInfo['catId'] : '64',
                          goal: userInfo['Goal'].toString().isNotEmpty ? userInfo['Goal'] : '0',
                          heightType: isCm.value ? "CM" : "FEET",
                          weightType: isKg.value ? "KG" : "LBS")
                      .then((value) async {
                    if (value != null) {
                      if (value['FITNESS APP'][0]['success'] == '1') {
                        showToast(value['FITNESS APP'][0]['msg']);
                        await UserProfile.getProfile();
                        Get.back();
                      } else {
                        showToast(value['FITNESS APP'][0]['msg']);
                      }
                    }
                    isLoad.value = false;
                  });
                  isLoad.value = false;
                },
                color: const Color(0xffB0C929),
              );
            }),
            SizedBox(height: 20.h),
          ],
        )),
      ),
    );
  }
}

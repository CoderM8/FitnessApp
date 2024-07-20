import 'package:fitness_ui/constant.dart';
import 'package:fitness_ui/custom_widget/imageloader.dart';
import 'package:fitness_ui/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../database/database.dart';

class CustomButtonFav extends StatefulWidget {
  final int id;
  final String title;
  final String time;
  final String type;
  final String image;

  const CustomButtonFav({super.key, required this.id, required this.title, required this.time, required this.type, required this.image});

  @override
  State<CustomButtonFav> createState() => _CustomButtonFavState();
}

class _CustomButtonFavState extends State<CustomButtonFav> {
  final RxBool isFavorite = false.obs;

  @override
  void initState() {
    if (userid != null) {
      getDatabase();
    }
    super.initState();
  }

  Future<void> getDatabase() async {
    isFavorite.value = await DatabaseHelper.instance.getExerciseId(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    if (userid != null) {
      return Obx(() {
        isFavorite.value;
        return InkWell(
          onTap: () async {
            if (isFavorite.value) {
              await DatabaseHelper.instance.deleteExercise(id: widget.id);
              isFavorite.value = false;
            } else {
              await DatabaseHelper.instance.addExercise(ExerciseFavorite(id: widget.id, title: widget.title, image: widget.image, type: widget.type, time: widget.time));
              isFavorite.value = true;
            }
          },
          child: !isFavorite.value
              ? SvgPicture.asset(
                  'assets/icons/like_outline.svg',
                  height: 20.w,
                  width: 20.w,
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                )
              : SvgPicture.asset(
                  'assets/icons/like.svg',
                  height: 20.w,
                  width: 20.w,
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                ),
        );
      });
    } else {
      return InkWell(
        onTap: () {
          showToast(S.of(context).login_Required);
        },
        child: SvgPicture.asset(
          'assets/icons/lock.svg',
          height: 20.w,
          width: 20.w,
          fit: BoxFit.scaleDown,
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
        ),
      );
    }
  }
}

class MealFavButton extends StatefulWidget {
  final int id;
  final String title;
  final String kcal;
  final String image;

  const MealFavButton({super.key, required this.id, required this.kcal, required this.image, required this.title});

  @override
  State<MealFavButton> createState() => _MealFavButtonState();
}

class _MealFavButtonState extends State<MealFavButton> {
  final RxBool isFavorite = false.obs;

  @override
  void initState() {
    if (userid != null) {
      getDatabase();
    }
    super.initState();
  }

  Future<void> getDatabase() async {
    isFavorite.value = await DatabaseHelper.instance.getMealsId(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    if (userid != null) {
      return Obx(() {
        isFavorite.value;
        return InkWell(
          onTap: () async {
            if (isFavorite.value) {
              await DatabaseHelper.instance.deleteMeals(id: widget.id);
              isFavorite.value = false;
            } else {
              await DatabaseHelper.instance.addMeals(MealsFavorite(id: widget.id, title: widget.title, image: widget.image, kcal: widget.kcal));
              isFavorite.value = true;
            }
          },
          child: !isFavorite.value
              ? SvgPicture.asset(
                  'assets/icons/like_outline.svg',
                  height: 20.w,
                  width: 20.w,
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                )
              : SvgPicture.asset(
                  'assets/icons/like.svg',
                  height: 20.w,
                  width: 20.w,
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                ),
        );
      });
    } else {
      return InkWell(
        onTap: () {
          showToast(S.of(context).login_Required);
        },
        child: SvgPicture.asset(
          'assets/icons/lock.svg',
          height: 20.w,
          width: 20.w,
          fit: BoxFit.scaleDown,
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
        ),
      );
    }
  }
}

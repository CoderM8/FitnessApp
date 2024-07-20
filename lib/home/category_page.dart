import 'package:fitness_ui/constant.dart';
import 'package:fitness_ui/controller/createaccount.dart';
import 'package:fitness_ui/custom_widget/custombutton.dart';
import 'package:fitness_ui/home/category_detail_screen.dart';
import 'package:fitness_ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../generated/l10n.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Back(),
        title: Text(S.of(context).categories_screen, style: TextStyle(fontFamily: 'SB', fontSize: 18.sp)),
      ),
      body: AnimationLimiter(
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: allCat.length,
          padding: EdgeInsets.symmetric(vertical: 15.h),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: isTab(context) ? 1.6 : 1, crossAxisCount: 2),
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              columnCount: 2,
              child: SlideAnimation(
                duration: const Duration(milliseconds: 375),
                verticalOffset: 50,
                child: FadeInAnimation(
                  child: Column(
                    children: [
                      Imageview(
                        image: allCat[index].categoryImage,
                        height: 112.w,
                        width: 112.w,
                        circle: true,
                        onTap: () {
                          Get.to(() => CategoryDetailScreen(id: allCat[index].cid, categoryName: allCat[index].categoryName));
                        },
                      ),
                      SizedBox(height: 15.h),
                      Flexible(
                        child: Text(
                          allCat[index].categoryName,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(fontSize: 14.sp, fontFamily: 'SB'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/theme_controller.dart';

AppBar buildAppBar() {
  return AppBar(
    elevation: 0,
    leadingWidth: 70.w,
    leading: Container(
      margin: EdgeInsets.only(left: 20.w),
      height: 30.h,
      width: 30.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.sp),
          color: Colors.grey.withOpacity(0.2)),
      child: const Icon(Icons.person),
    ),
    actions: [
      GetBuilder<ThemeController>(builder: (themecontroller) {
        return IconButton(
          onPressed: () {
            themecontroller.changeAppTheme();
          },
          icon: const Icon(Icons.dark_mode),
        );
      })
    ],
  );
}
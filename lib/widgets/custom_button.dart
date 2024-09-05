import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/pages/constants/color.dart';
import 'package:todo_app/widgets/custom_text.dart';

Widget button(String text, Function()? onPressed, {width = 80.0}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10.sp),

      /// height: 50.h,
      //width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          color: AppColors.mainColor),
      child: reusableText(text, size: 18.0, color: Colors.white),
    ),
  );
}
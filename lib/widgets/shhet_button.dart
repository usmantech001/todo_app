import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/widgets/custom_text.dart';

Widget sheetButton(Color color, String text, Function() onPressed,
    {Color textcolor = Colors.white}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: 50.h,
      width: double.maxFinite,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15.sp),
          color: color),
      child: reusableText(text, color: textcolor, size: 20.0.sp),
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/add_task_controller.dart';
import 'package:todo_app/controllers/theme_controller.dart';
import 'package:todo_app/pages/constants/color.dart';
import 'package:todo_app/widgets/custom_text.dart';


Widget buildTextField(
    {required String hintText,
    String? maintext,
    Widget? widget,
   // Function()? onPressed,
    TextEditingController? controller,
    bool readOnly= false,
    VoidCallback? onTap,
    int? maxLines,
    int? minLines,
    Function(String)? onChanged}) {
  return GetBuilder<ThemeController>(
    builder: (themeController) {
      return GetBuilder<AddTaskController>(builder: (taskController) {
        return Container(
          margin: EdgeInsets.only(bottom: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              maintext != null
                  ? reusableText(maintext, size: 18.0.sp, color: themeController.isdark?Colors.white:Colors.black)
                  : SizedBox(
                      height: 0.h,
                      width: 0.w,
                    ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: TextFormField(
                  
                  controller: controller,
                  readOnly: readOnly,
                  cursorColor: AppColors.mainColor,
                  onChanged: onChanged,
                  onTap: onTap,
                //  minLines: minLines,
                  maxLines: maxLines,
                  scrollPhysics: const BouncingScrollPhysics(),
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: hintText,
                      suffixIcon: widget,
                      
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.sp),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),),
                     
                      focusedBorder:  OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10.sp),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),)),
                ),
              ),
            ],
          ),
        );
      });
    }
  );
}
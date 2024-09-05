import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/controllers/add_task_controller.dart';
import 'package:todo_app/controllers/theme_controller.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/pages/constants/color.dart';

Widget reusableText(String text,
    {color = Colors.black, size = 25.0, fontweight = FontWeight.w500}) {
  return Text(text,
      style: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: size,
              color: color,
              overflow: TextOverflow.ellipsis,
              fontWeight: fontweight)));
}

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

TextStyle datetextStyle({size = 16.0}) {
  return GoogleFonts.lato(
      textStyle: TextStyle(fontSize: size, color: Colors.grey));
}

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

InputBorder get inputFieldBorder {
  return const OutlineInputBorder(borderSide: BorderSide.none);
}

Widget taskListBuilder(BuildContext context, AddTaskController taskcontroller) {
  return Expanded(
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: taskcontroller.taskList.length,
          itemBuilder: (context, index) {
            var task = taskcontroller.taskList[index];
            return GestureDetector(
              onTap: () {
                taskcontroller.showbottomSheet(context, task);
              },
              child: Container(
                  margin:
                      EdgeInsets.only(bottom: 10.h, left: 20.w, right: 20.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  height: 110.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: taskcontroller.choosedColor(task.color),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText(task.title,
                              size: 20.0.sp, color: Colors.white),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.access_time_rounded,
                                color: Colors.white70,
                                size: 28,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              reusableText(task.date,
                                  size: 13.0.sp, color: Colors.white)
                            ],
                          ),
                          SizedBox(
                            width: 250.w,
                            child: reusableText(task.note,
                                size: 18.0.sp, color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          RotatedBox(
                            quarterTurns: 3,
                            child: Container(
                              width: 200.h,
                              color: Colors.grey.shade200,
                              height: 0.7,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          RotatedBox(
                            quarterTurns: 3,
                            child: reusableText(
                                task.isCompleted == 0 ? 'Todo' : 'Completed',
                                size: 15.0.sp,
                                color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  )),
            );
          }));
}

Widget bottomSheetContainer(TaskModel task) {
  return GetBuilder<AddTaskController>(builder: (taskController) {
    return Container(
      padding:
          EdgeInsets.only(left: 20.w, right: 20.w, top: 60.h, bottom: 10.h),
      height: task.isCompleted == 1 ? 200.h : 250.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.sp),
            topRight: Radius.circular(15.sp),
          )),
      child: Column(
        children: [
          task.isCompleted == 1
              ? Container()
              : sheetButton(AppColors.mainColor, 'Task Completed', () {
                  taskController.patchTask(task);
                  Get.back();
                }),
          SizedBox(
            height: 7.h,
          ),
          sheetButton(Colors.redAccent, 'Delete Task', () {
            taskController.deleteTask(task);
          }),
          Expanded(child: Container()),
          sheetButton(Colors.white, 'Close', () {
            Get.back();
          }, textcolor: Colors.black)
        ],
      ),
    );
  });
}

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

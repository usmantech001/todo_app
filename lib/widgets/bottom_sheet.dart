import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/add_task_controller.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/pages/constants/color.dart';
import 'package:todo_app/widgets/shhet_button.dart';





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
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/add_task_controller.dart';
import 'package:todo_app/widgets/custom_text.dart';


Widget taskListBuilder(BuildContext context, TaskController taskcontroller) {
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
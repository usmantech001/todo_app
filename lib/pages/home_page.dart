import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/add_task_controller.dart';
import 'package:todo_app/controllers/location_controller.dart';
import 'package:todo_app/controllers/notification_controller.dart';
import 'package:todo_app/controllers/theme_controller.dart';
import 'package:todo_app/pages/add_task_page.dart';
import 'package:todo_app/pages/constants/color.dart';
import 'package:todo_app/utils/date_style.dart';
import 'package:todo_app/widgets/custom_ap_bar.dart';
import 'package:todo_app/widgets/custom_button.dart';
import 'package:todo_app/widgets/custom_text.dart';
import 'package:todo_app/widgets/task_list.dart';


class HomePage extends GetView<NotificationController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetBuilder<TaskController>(
          builder: (taskcontroller) {
            return Scaffold(
              appBar: buildAppBar(),
              body: Column(
                children: [
                 
                  Container(
                    margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reusableText(DateFormat.yMMMMd().format(DateTime.now()), color: Colors.grey, size: 20.0.sp),
                            reusableText('Today', color: themeController.isdark?Colors.white:Colors.black)
                          ],
                        ),
                        button('+ Add task', (){
                          //controller.showNotification();
                          Get.to(()=>const AddtaskPage());
                        })
                      ],
                    ),
                  ),
                  
                  Container(
                    margin: EdgeInsets.only(top: 20.h,left:20.w, bottom: 20.h),
                    
                    child: DatePicker(
                      
                      DateTime.now(),
                      width: 70.w,
                      height: 100.h,
                      selectionColor: AppColors.mainColor,
                      initialSelectedDate: DateTime.now(),
                      dateTextStyle: datetextStyle(size: 20.0),
                      dayTextStyle: datetextStyle(size: 16.0),
                      monthTextStyle: datetextStyle(size: 14.0),
                      onDateChange: (selectedDate) {
                        taskcontroller.updateHomeSelectedDate(selectedDate);
                         String date = DateFormat('M/d/y').format(selectedDate);
                        taskcontroller.getDbData(date);
                      },
                    ),
                  ),
                 taskcontroller.taskList.isEmpty?
                 Expanded(
                   child: Container(
                   /// margin: EdgeInsets.only(top: 200.h),
                   alignment: Alignment.center,
                    child: reusableText('Your todo list is empty',color:  themeController.isdark?Colors.white:Colors.black),),
                 ) :taskListBuilder(context, taskcontroller)
                
        
                ],
              ),
            );
          }
        );
      }
    );
  }
}


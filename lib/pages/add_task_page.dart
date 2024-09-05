import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/add_task_controller.dart';
import 'package:todo_app/controllers/location_controller.dart';
import 'package:todo_app/controllers/theme_controller.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/pages/constants/color.dart';
import 'package:todo_app/widgets/widgets.dart';

class AddtaskPage extends GetView<LocationController> {
  const AddtaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<AddTaskController>(builder: (addtotaskcontroller) {
        return Scaffold(
            appBar: AppBar(
              //s    backgroundColor: Colors.white,
              scrolledUnderElevation: 0,
            ),
            body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 40.h),
                child: Container(
                  margin: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reusableText('Add Task',
                            color: themeController.isdark
                                ? Colors.white
                                : Colors.black),
                        SizedBox(
                          height: 15.h,
                        ),
                        buildTextField(
                            maintext: 'Title',
                            hintText: 'Enter your task title',
                            controller: addtotaskcontroller.titleController),
                        buildTextField(
                            maintext: 'Date',
                            hintText: DateFormat('M/d/y')
                                .format(addtotaskcontroller.selectedDate),
                            widget: Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.grey.shade400,
                            ),
                            onTap: () {
                              addtotaskcontroller.showdatePicker(context);
                            },
                            readOnly: true),
                        buildTextField(
                            maintext: 'Choose location',
                            hintText: 'choose task location',
                            maxLines: 1,
                            controller:
                                addtotaskcontroller.locationNameControler,
                            readOnly: true,
                            widget: const Icon(Icons.arrow_drop_down),
                            onTap: () => showDialog(
                                  context: context,
                                  builder: (context) {
                                    return GetBuilder<LocationController>(
                                        builder: (controller) {
                                      return Obx(
                                        () => Container(
                                          margin: EdgeInsets.only(
                                              left: 16.w,
                                              right: 16.w,
                                              bottom: 20.h),
                                          height:
                                              MediaQuery.sizeOf(context).height,
                                          width: double.infinity,
                                          color: Colors.white,
                                          child: Scaffold(
                                              backgroundColor: Colors.white,
                                              body: Column(
                                                //mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 16.w,
                                                      right: 16.w,
                                                      top: 15.h,
                                                    ),
                                                    child: buildTextField(
                                                      hintText: 'Search',
                                                      controller:
                                                          addtotaskcontroller
                                                              .serchController,
                                                      onChanged: (query) {
                                                        controller
                                                            .searchForAddress(
                                                                query);
                                                      },
                                                    ),
                                                  ),
                                                  controller.isloading.value
                                                      ? const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        )
                                                      : !controller
                                                                  .isloading.value &&
                                                              controller
                                                                  .locationList
                                                                  .isEmpty &&
                                                              addtotaskcontroller
                                                                  .serchController
                                                                  .text
                                                                  .isNotEmpty
                                                          ? Center(
                                                              child: reusableText(
                                                                  'No location found',
                                                                  size: 14.sp),
                                                            )
                                                          : Obx(
                                                              () => Expanded(
                                                                  child: ListView
                                                                      .builder(
                                                                          itemCount: controller
                                                                              .locationList
                                                                              .length,
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 16.w),
                                                                          itemBuilder: (context, index) {
                                                                            final location =
                                                                                controller.locationList[index];
                                                                            return GestureDetector(
                                                                              onTap: () {
                                                                                controller.setLocation(location);
                                                                                addtotaskcontroller.locationNameControler.text = location.displayName;
                                                                                Get.back();
                                                                              },
                                                                              child: Container(
                                                                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                                                                decoration: BoxDecoration(
                                                                                    //  color: Colors.red,
                                                                                    border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2)))),
                                                                                child: SingleChildScrollView(
                                                                                  physics: const BouncingScrollPhysics(),
                                                                                  scrollDirection: Axis.horizontal,
                                                                                  child: reusableText(location.displayName, size: 14.sp),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          })),
                                                            )
                                                ],
                                              )),
                                        ),
                                      );
                                    });
                                  },
                                )),
                        buildTextField(
                            maintext: 'Note',
                            hintText: 'Enter your note',
                            controller: addtotaskcontroller.noteController,
                            minLines: 7,
                            maxLines: 7),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                reusableText('Color', size: 15.0.sp),
                                SizedBox(
                                  height: 8.0.h,
                                ),
                                Wrap(
                                  children: List.generate(3, (index) {
                                    return GestureDetector(
                                      onTap: () => addtotaskcontroller
                                          .changeColorIndex(index),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: CircleAvatar(
                                          radius: 14.sp,
                                          backgroundColor: index == 0
                                              ? AppColors.mainColor
                                              : index == 1
                                                  ? Colors.redAccent
                                                  : Colors.orangeAccent,
                                          child: addtotaskcontroller
                                                      .selectedColorIndex ==
                                                  index
                                              ? Icon(
                                                  Icons.done,
                                                  color: Colors.white,
                                                  size: 16.sp,
                                                )
                                              : Container(),
                                        ),
                                      ),
                                    );
                                  }),
                                )
                              ],
                            ),
                            button('Create Task', () async {
                              if (addtotaskcontroller
                                      .titleController.text.isNotEmpty &&
                                  addtotaskcontroller
                                      .noteController.text.isNotEmpty && addtotaskcontroller.locationNameControler.text.isNotEmpty ) {
                                String note =
                                    addtotaskcontroller.noteController.text;
                                String title =
                                    addtotaskcontroller.titleController.text;
                                int color =
                                    addtotaskcontroller.selectedColorIndex;
                                String date = DateFormat('M/d/y')
                                    .format(addtotaskcontroller.selectedDate);
                                var task = TaskModel(
                                    note: note,
                                    title: title,
                                    color: color,
                                    date: date,
                                    isCompleted: 0,
                                    latitude: addtotaskcontroller
                                        .locationController.latitude,
                                    longitude: addtotaskcontroller
                                        .locationController.longitude);
                                addtotaskcontroller.addTask(task);
                                addtotaskcontroller.getDbData(date);
                                Get.back();
                              } else if (addtotaskcontroller
                                      .titleController.text.isEmpty ||
                                  addtotaskcontroller
                                      .titleController.text.isEmpty) {
                                Get.snackbar('Required',
                                    'Title and Note field is required',
                                    backgroundColor: Colors.white,
                                    colorText: Colors.redAccent,
                                    icon: const Icon(Icons.warning),
                                    snackPosition: SnackPosition.BOTTOM);
                              }else if(addtotaskcontroller.locationNameControler.text.isEmpty){
                                 Get.snackbar('Required',
                                    'Please select a location',
                                    backgroundColor: Colors.white,
                                    colorText: Colors.redAccent,
                                    icon: const Icon(Icons.warning),
                                    snackPosition: SnackPosition.BOTTOM);
                              }
                            })
                          ],
                        )
                      ]),
                )));
      });
    });
  }
}

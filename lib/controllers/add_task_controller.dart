import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/theme_controller.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/pages/constants/color.dart';
import 'package:todo_app/repo/add_task_repo.dart';
import 'package:todo_app/controllers/location_controller.dart';
import 'package:todo_app/widgets/widgets.dart';

class AddTaskController extends GetxController {
  AddtaskRepo addtaskRepo;
  LocationController locationController;
  ThemeController themeController;
  AddTaskController(
      {required this.addtaskRepo, required this.locationController, required this.themeController});

  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  final noteController = TextEditingController();
  final titleController = TextEditingController();
  final locationNameControler = TextEditingController();
  final serchController = TextEditingController();
  FocusNode focusNode = FocusNode();
  List<TaskModel> taskList = [];
  DateTime homeSelectedDate = DateTime.now();
  int initRemind = 5;
  String initRepeat = 'none';
  int selectedColorIndex = 0;
  List<int> remindTime = [
    5,
    10,
    15,
    20,
    25,
    30,
  ];
  List<String> repeatTaskTime = ['Daily', 'Weekly', 'Monthly', 'Yearly'];
  showdatePicker(context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
    if (pickedDate != null) {
      selectedDate = pickedDate;
      update();
    }
  }

  updateHomeSelectedDate(DateTime date){
    homeSelectedDate=date;
    update();
  }

  showtimePicker(context, bool isStartTime) async {
    TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null) {
      if (isStartTime == true) {
        startTime = pickedTime.format(context);
        update();
      } else {
        endTime = pickedTime.format(context);
        update();
      }
    }
  }

  setRemindMinutes(int value) {
    initRemind = value;
    update();
  }

  setRepeatTime(String value) {
    initRepeat = value;
    update();
  }

  changeColorIndex(int value) {
    selectedColorIndex = value;
    update();
  }

  addTask(TaskModel task) async {
    await DbHelper.addTask(task);
    noteController.clear();
    titleController.clear();
    //print('Task id is ${value}');
  }

  getDbData(String date) async {
    taskList = [];
    List<Map<String, dynamic>> tasks = await DbHelper().getDbData(date);
    // print(tasks.length);
    // ignore: avoid_function_literals_in_foreach_calls
    tasks.forEach((element) {
      taskList.add(TaskModel.fromJson(element));
    });
    update();
  }

  @override
  void onReady() {
    super.onReady();
     String date = DateFormat('M/d/y').format(homeSelectedDate);
    getDbData(date);
  }

  Color choosedColor(int colorNumber) {
    if (colorNumber == 0) {
      return AppColors.mainColor;
    } else if (colorNumber == 1) {
      return Colors.redAccent;
    } else {
      return Colors.orangeAccent;
    }
  }

  deleteTask(
    TaskModel task,
  ) async {
    await DbHelper().deleteTask(task);
    String date = DateFormat('M/d/y').format(homeSelectedDate);
    getDbData(date);
    Get.back();
  }

  showbottomSheet(BuildContext context, TaskModel task) {
    Get.bottomSheet(bottomSheetContainer(task));
  }

  patchTask(TaskModel task) async {
    await DbHelper().patchTask(task);
     String date = DateFormat('M/d/y').format(homeSelectedDate);
    getDbData(date);
  }
}

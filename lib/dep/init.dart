import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/controllers/add_task_controller.dart';
import 'package:todo_app/controllers/notification_controller.dart';
import 'package:todo_app/controllers/theme_controller.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/repo/add_task_repo.dart';
import 'package:todo_app/controllers/location_controller.dart';

Future<void> init() async {
  final sharedPreferences =await SharedPreferences.getInstance();
  await DbHelper.initDb();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(()=> NotificationController(), fenix: true);
  Get.lazyPut(()=> LocationController(), fenix: true);
  Get.lazyPut(() => ThemeController(), fenix: true);
  Get.lazyPut(() => AddTaskController(addtaskRepo: Get.find(), locationController: Get.find(), themeController: Get.find()), fenix: true);
  Get.lazyPut(() => AddtaskRepo(sharedPreferences: Get.find()));
}
import 'dart:async';
import 'dart:ui';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/pages/home_page.dart';

class NotificationController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestNotificationPermission();
    initNotification();
   // requestNotificationPermission();
    initializeSrvice();
  }

  final int helloAlarmID = 0;

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // this will be used as notification channel id
  final notificationChannelId = 'todo_app';
  final notificationId = 888;

  Future<void> requestNotificationPermission() async {
    final notificationStatus = await Permission.notification.status;
    if (notificationStatus == PermissionStatus.denied ) {
      await Permission.notification.request();
    }
  }

  Future<void> initNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
      },
    ).then((value) {
    });
  }

 
  @pragma('vm:entry-point')
  static Future<void> onStartService(ServiceInstance service) async {
    double distanceThreshold = 50.0;
    // Only available for flutter 3.0.0 and later
    DartPluginRegistrant.ensureInitialized();

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
        print('here...');
Timer.periodic(const Duration(seconds: 5), (timer) async{
      Geolocator.getPositionStream().listen((Position position) async {
       String date = DateFormat('M/d/y').format(DateTime.now());
      await DbHelper.initDb();
      List<Map<String, dynamic>> tasks = await DbHelper().getDbData(date);
      for (var task in tasks) {
        var taskList = <TaskModel>[];
        taskList.add(TaskModel.fromJson(task));
        if (taskList.isNotEmpty) {
          for (var task in taskList) {
            double distance = Geolocator.distanceBetween(
              position.latitude,
              position.longitude,
              task.latitude,
              task.longitude,
            );
            if (distance <= distanceThreshold) {
              AndroidNotificationDetails androidNotificationDetails =
                  const AndroidNotificationDetails('todo_app', 'todo_app',
                      importance: Importance.high,
                      playSound: true,
                      priority: Priority.high);
              final notificationDetails =
                  NotificationDetails(android: androidNotificationDetails);
              await flutterLocalNotificationsPlugin.show(task.id!, task.title,
                  task.note, notificationDetails);
            }
          }
        }
      }
    }
    );
});

  //  // bring to foreground
  //   Timer.periodic(const Duration(seconds: 10), (timer) async {
  //     AndroidNotificationDetails androidNotificationDetails =
  //         const AndroidNotificationDetails('todo_app', 'todo_app',
  //             importance: Importance.high,
  //             playSound: true,
  //             priority: Priority.high);
  //     final notificationDetails =
  //         NotificationDetails(android: androidNotificationDetails);
  //     await flutterLocalNotificationsPlugin.show(
  //         3, 'Todo', 'My first todo notification', notificationDetails);
  //   });
  }

  Future<void> initializeSrvice() async {
    final service = FlutterBackgroundService();
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print("The details are ${details.payload} ${details.id}");
        Get.to(()=>HomePage());
      },
    ).then((value) {
    });

    AndroidNotificationChannel channel = AndroidNotificationChannel(
      notificationChannelId, // id
      'MY FOREGROUND SERVICE', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high, // importance must be at low or higher level
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    // await service.startService();

    await service.configure(
        androidConfiguration: AndroidConfiguration(
          // this will be executed when app is in foreground or background in separated isolate
          onStart: onStartService,

          // auto start service
          autoStart: true,
          isForegroundMode: true,

          notificationChannelId:
              notificationChannelId, // this must match with notification channel you created above.
          initialNotificationTitle: 'todo_app',
          initialNotificationContent: 'Initializing',
          foregroundServiceNotificationId: notificationId,
        ),
        iosConfiguration: IosConfiguration());

    //  await service.startService();
  }


  Future<void> showNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('todo_app', 'todo_app',
            importance: Importance.high,
            playSound: true,
            priority: Priority.high);
    final notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'Todo', 'My first todo notification', notificationDetails);
  }
}

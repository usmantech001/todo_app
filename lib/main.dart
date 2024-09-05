import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/location_controller.dart';
import 'package:todo_app/controllers/notification_controller.dart';
import 'package:todo_app/controllers/theme_controller.dart';
import 'package:todo_app/dep/init.dart';
import 'package:todo_app/pages/constants/color.dart';
import 'package:todo_app/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   
  await init();
  await LocationController().checkLocationService();
  final notificationController = NotificationController();
  await notificationController.requestNotificationPermission();
  await NotificationController().initNotification();

  await NotificationController().initializeSrvice();
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themecontroller) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return GetMaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
            //  scaffoldBackgroundColor: Colors.white,
                colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),
                useMaterial3: true,
              ),
              themeMode:themecontroller.isdark==false?ThemeMode.light: ThemeMode.dark,
              darkTheme: ThemeData(
                colorScheme: const ColorScheme.dark()
              ),
              home: const HomePage(),
            );
          }
        );
      }
    );
  }
}








/*

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'location_service.dart';
import 'notification_service.dart';

class ReminderService {
  final LocationService _locationService = LocationService();
  final NotificationService _notificationService = NotificationService();

  // Replace with your own location and distance threshold
  final double reminderLatitude = 37.4219983;
  final double reminderLongitude = -122.084;
  final double distanceThreshold = 100.0; // in meters

  void startReminderTracking() async {
    await _notificationService.initialize();
    _locationService.startLocationTracking((Position position) {
      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        reminderLatitude,
        reminderLongitude,
      );

      if (distance <= distanceThreshold) {
        _notificationService.showNotification(
          'Reminder',
          'You have a task to complete nearby!',
        );
      }
    });
  }
}

*/
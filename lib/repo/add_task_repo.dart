import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddtaskRepo extends GetxService{
  final SharedPreferences sharedPreferences;
  AddtaskRepo({required this.sharedPreferences});
}
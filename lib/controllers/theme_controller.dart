import 'package:get/get.dart';

class ThemeController extends GetxController{
  bool isdark = false;

  changeAppTheme(){
    if(isdark == false){
       isdark=true;
       update();
    }else if(isdark==true){
      isdark=false;
      update();
    }
  }
}
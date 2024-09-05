import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:todo_app/model/location.dart';

class LocationController extends GetxController {

  
  @override
  Future<void> onReady() async {
    // TODO: implement onInit
    super.onReady();
  }

  

  RxBool isloading = false.obs; 
final geolocator = Geolocator();
  RxList<LocationModel> locationList = <LocationModel>[].obs;
  double latitude = 0.0;
  double longitude = 0.0;
  String locationName = '';
bool isEnabled = false;


Future<void> checkLocationService() async{
  isEnabled = await Geolocator.isLocationServiceEnabled();
  
 if(!isEnabled){
 final isOpened = await Geolocator.openLocationSettings();

 }
 final locationPermission = await Geolocator.checkPermission();
 if(locationPermission == LocationPermission.denied){
  await Geolocator.requestPermission();
 }
}
Future<void> searchForAddress(String query) async{
  isloading.value = true;
  locationList.value =[];
  String url = 'https://nominatim.openstreetmap.org/search?q=$query&countrycodes=NG&format=json&addressdetails=1';
  final connect = GetConnect(timeout: Duration(seconds: 30));
 final response = await connect.get(url);
 print(response.statusCode);
 if(response.statusCode == 200){
 
   final dataList = response.body as List;
   if(dataList.isNotEmpty){
       for(var data in dataList){
   final location = LocationModel.fromJson(data);
   locationList.add(location);
   print('The length of the location is ${locationList.length}');
  isloading.value = false;
   }
   }
  
  isloading.value = false;
  
 }else{

 }



}

 setLocation(LocationModel location){
   latitude = double.parse(location.lat);
   longitude = double.parse(location.lon);
   locationName = location.displayName;

   print('The new values are $latitude $longitude $locationName');
 }
}


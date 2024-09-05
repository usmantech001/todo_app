class TaskModel{
  int? id;
 late String title;
 late String note;
 late String date;
 late String startTime;
 late String endTime;
 late int color;
 late int remind;
 late String repeat;
 late int isCompleted;
 late double latitude;
 late double longitude;

  TaskModel({
    this.id,
   required this.note,
   required this.title,
   required this.color,
   required this.date,

   required this.isCompleted,

   required this.latitude,
   required this.longitude
  });

  TaskModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    note = json['note'];
    date = json['date'];
   
    isCompleted = json['isCompleted']??0;
  
    color = json['color'];
   
    latitude = json['latitude'];
    longitude = json['longitude'];

  }

  Map<String, dynamic> toJson(){
    return {
      'id':id,
      'title': title,
      'note':note,
      'date':date,

       'color':color,
       'latitude': latitude,
       'longitude':longitude,
      
      'isCompleted':isCompleted,
      
     
      
      
    };
  }

}
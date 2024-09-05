import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/task_model.dart';

class DbHelper {
  static Database? db;
  static const int version =1;
  static const String tableName = 'tasks';
  DbHelper();

 static Future<void> initDb() async {
    if(db!=null){
      return;
    }else{
      try{
        String path ='${await getDatabasesPath()}task.db';
         db =await openDatabase(
          path,
          version: version,
          onCreate: (db, version) {
            return db.execute('''
              CREATE TABLE $tableName(
                id INTEGER PRIMARY KEY AUTOINCREMENT, 
                title STRING, note TEXT, date STRING,
              
                color INTEGER, 
                latitude REAL, longitude REAL,
                isCompleted INTEGER
                
                )''',
             
            );
          },
          );
      }catch(e){
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

static Future<int> addTask(TaskModel task)async {
   return await db!.insert(tableName, task.toJson());
  }

  Future<List<Map<String, dynamic>>> getDbData(String date) async{
   return await db!.query(tableName, where: 'date = ?', whereArgs: [date]);
  }
  


 Future<int> deleteTask(TaskModel task) async{
   return await db!.delete(tableName, where:'id=?', whereArgs: [task.id] );
  }
 Future<int> patchTask(TaskModel task) async{
  //await db!.update(table, values)
   return await db!.rawUpdate('''
      UPDATE $tableName
      SET isCompleted = ?
      WHERE id = ?
    ''', [1, task.id]);
    
  }
}
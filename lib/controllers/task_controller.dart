import 'package:dairy_habit_reminder/db/db_helper.dart';
import 'package:dairy_habit_reminder/models/task.dart';
import 'package:get/get.dart';

class TaskController extends GetxController{
  @override
  void onReady(){
    getTasks();
    super.onReady();
  }
  var taskList = <Task>[].obs;

 Future<int> addTask({Task? task}) async{
    return await DBhelper.insert(task!);
 }
void getTasks() async {
   List<Map<String, dynamic>> tasks = await DBhelper.query();
   taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
}
void delete(Task task){
 DBhelper.delete(task);
}
}


import 'package:dairy_habit_reminder/controllers/task_controller.dart';
import 'package:dairy_habit_reminder/models/task.dart';
import 'package:dairy_habit_reminder/ui/add_task_bar.dart';
import 'package:dairy_habit_reminder/ui/services/notification_services.dart';
import 'package:dairy_habit_reminder/ui/services/theme_services.dart';
import 'package:dairy_habit_reminder/ui/theme.dart';
import 'package:dairy_habit_reminder/ui/widgets/buttons.dart';
import 'package:dairy_habit_reminder/ui/widgets/task_tile.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dairy_habit_reminder/navbar.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  var notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: _AppBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),

          SizedBox(height: 20,),
          _showTasks(),



        ],
      ),
    );
  }


_showTasks(){
   return Expanded(
       child: Obx((){
      return ListView.builder(
        itemCount: _taskController.taskList.length,
          itemBuilder: (_, index){
          print(_taskController.taskList.length);
         Task task = _taskController.taskList[index];
         print(task.toJson());
       if (task.repeat=='None') {
         DateTime date = DateFormat.jm().parse(task.startTime.toString());
         var myTime = DateFormat("HH:mm").format(date);
         notifyHelper.scheduledNotification(
           int.parse(myTime.toString().split(":")[0]),
           int.parse(myTime.toString().split(":")[1]),
           task,
         );
         return AnimationConfiguration.staggeredList(
             position: index,
             child: SlideAnimation(
                 child: FadeInAnimation(
                     child: Row(
                       children: [
                         GestureDetector(
                             onTap: (){
                               _showBottomSheet(context, task);
                             },
                             child:TaskTile(task)
                         )
                       ],
                     )
                 )
             ));
       }

 if(task.date==DateFormat.yMd().format(_selectedDate)){
   return AnimationConfiguration.staggeredList(
       position: index,
       child: SlideAnimation(
           child: FadeInAnimation(
               child: Row(
                 children: [
                   GestureDetector(
                       onTap: (){
                         _showBottomSheet(context, task);
                       },
                       child:TaskTile(task)
                   )
                 ],
               )
           )
       ));
 }else{
   return Container();
 }
          });
       }),
   );
}
  _addTaskBar(){
    return  Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Container(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat.yMMMd().format(DateTime.now()),
                    style: subHeeadingStyle,
                  ),
                  Text("Today",
                    style: heeadingStyle,
                  ),
                  Text("select date to show that day's task ")
                ],
              )
          ),
          MyButtons(
              label: "+ add task", onTap: () async{
             await Get.to(AddTaskBar());
             _taskController.getTasks();
              }
    )
        ],
      ),
    );
  }

  _showBottomSheet(BuildContext, Task task){
     Get.bottomSheet(
         Container(
           padding: const EdgeInsets.only(top: 5),
           height: task.isCompleted==1?
               MediaQuery.of(context).size.height*0.24:
               MediaQuery.of(context).size.height*0.32,
           color: Get.isDarkMode?darkGrayClr:Colors.white,
           child: Column(
             children: [
               Container(
                 height: 5,
                 width: 390,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
                 ),
               ),
               Spacer(),
               task.isCompleted==1
                   ?Container()
                   : _bottomSheetButton(
                 label: "Task Completed",
                     onTap: (){
                    _taskController.markTaskCompleted(task.id!);
                   Get.back();
                     },
                 clr: primaryClr,
                  context : context,
               ),
               SizedBox(
                height: 20,
               ),
               _bottomSheetButton(
                 label: "Delete task",
                 onTap: (){
                   _taskController.delete(task);
                   // _taskController.getTasks();
                   Get.back();
                 },
                 clr: Colors.red[300]!,
                 context : context,
               ),
               _bottomSheetButton(
         label: "Close",
         onTap: (){
     Get.back();

     },
       clr: Colors.red[300]!,

                 isClosed: true,
       context : context,
     ),
               SizedBox(
                 height: 20,
               ),

             ],
           ),
         )
     );
  }
_bottomSheetButton({
    required String label ,
  required Function()? onTap,
  required Color clr,
  bool isClosed = false,
  required BuildContext context,
}){
  return GestureDetector(
    onTap:onTap,
    child: Container(
      margin:const EdgeInsets.symmetric(vertical:4 ) ,
      height: 55 ,
      width:MediaQuery.of(context).size.width*0.9 ,

      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: isClosed==true?Get.isDarkMode?Colors.grey[600]!:Colors.grey[300]!:clr
        ),
        borderRadius: BorderRadius.circular(20),
        color: isClosed==true?Colors.transparent :clr,
      ),

      child: Center(
        child: Text(
          label,
          style: isClosed?titleStyle:titleStyle.copyWith(color: Colors.white),
        ),
      ) ,

    )
  );
}
  _addDateBar(){
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey
        ),
        dayTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey
        ),
        monthTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey
        ),
        onDateChange: (date) {
         setState(() {
           _selectedDate = date;
         });
        },
      ),
    );
  }

  _AppBar(){
    return AppBar(
      backgroundColor: context.theme.primaryColor,
      // leading: GestureDetector(
      //   onTap: (){
      //     ThemeServices().switchTheme();
      //        notifyHelper.displayNotification(
      //          title: "Theme changed",
      //            body: Get.isDarkMode?"Activated dark theme":"Activated light theme"
      //        );
      //        // notifyHelper.scheduledNotification();
      //   },
      //   child: Icon(Get.isDarkMode ?Icons.wb_sunny_outlined:Icons.nightlight_round, size: 30,
      //   color: Get.isDarkMode ? Colors.white:Colors.black,
      //   ),
      // ),
      // actions: [
      //  CircleAvatar(
      //    backgroundImage: AssetImage(
      //      "image/user.png"
      //    ),
      //  )
      // ],
    );
  }
}
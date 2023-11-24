import 'package:dairy_habit_reminder/ui/add_task_bar.dart';
import 'package:dairy_habit_reminder/ui/services/notification_services.dart';
import 'package:dairy_habit_reminder/ui/services/theme_services.dart';
import 'package:dairy_habit_reminder/ui/theme.dart';
import 'package:dairy_habit_reminder/ui/widgets/buttons.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
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
      appBar: _AppBar(),
      body: Column(
        children: [
         Container(
           margin: const EdgeInsets.only(left: 20, right: 20, top: 10) ,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Container(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                  Text( DateFormat.yMMMd().format(DateTime.now()),
                  style: subHeeadingStyle,
                  ),
                   Text("Today",
                   style: heeadingStyle,
                   )
                 ],
               )
               ),
               MyButtons(label: "+ add task" , onTap: ()=>Get.to(AddTaskBar()))
             ],
           ),
         ),
          Container(
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
              onDateChange: (date){
                    _selectedDate = date;
              },
            ),
          )
        ],
      ),
    );
  }

  _AppBar(){
    return AppBar(
      backgroundColor: context.theme.primaryColor,
      leading: GestureDetector(
        onTap: (){
          ThemeServices().switchTheme();
             notifyHelper.displayNotification(
               title: "Theme changed",
                 body: Get.isDarkMode?"Activated dark theme":"Activated light theme"
             );
             notifyHelper.scheduledNotification();
        },
        child: Icon(Get.isDarkMode ?Icons.wb_sunny_outlined:Icons.nightlight_round, size: 30,
        color: Get.isDarkMode ? Colors.white:Colors.black,
        ),
      ),
      actions: [
       CircleAvatar(
         backgroundImage: AssetImage(
           "image/user.png"
         ),
       )
      ],
    );
  }
}
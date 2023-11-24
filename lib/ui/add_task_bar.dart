import 'package:dairy_habit_reminder/ui/theme.dart';
import 'package:dairy_habit_reminder/ui/widgets/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class AddTaskBar extends StatefulWidget {
  const AddTaskBar({super.key});

  @override
  State<AddTaskBar> createState() => _AddTaskBarState();
}

class _AddTaskBarState extends State<AddTaskBar> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor ,
      appBar: _AppBar(context),
      body: Container(
        padding: const EdgeInsets.only(left:  20, right:  20 ),
        child: SingleChildScrollView(
          child: Column(
            children: [
             Text(
               "Add Task",
               style: heeadingStyle,
             ),
              InputField(title: "Title", hint:"add activity title" ,),
              InputField(title: "Activity", hint:"add activity" ,),
              InputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate) ,)
            ],
          ),
        ),
      ),
    );
  }

  _AppBar(BuildContext context){
    return AppBar(
      leading: GestureDetector(
        onTap: (){
         Get.back();

        },
        child: Icon(Icons.arrow_back_ios, size: 30,
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

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
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _AppBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Add Task",
                style: heeadingStyle,
              ),
              InputField(title: "Title", hint: "add activity title",),
              InputField(title: "Activity", hint: "add activity",),
              InputField(
                title: "Date", hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(
                    Icons.calendar_today_outlined, color: Colors.grey,),
                  onPressed: () {
                    _getDateFromUser();
                  },

                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: "Start Date" ,
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: (){
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ) ,
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: InputField(
                      title: "End time" ,
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: (){
                          _getTimeFromUser(isStartTime:false);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ) ,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _AppBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios, size: 30,
          color: Get.isDarkMode ? Colors.white : Colors.black,
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

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2024)
    );
    if(_pickerDate!=null){
      setState(() {
        _selectedDate = _pickerDate;
      });

    }else{

    }
  }
  _getTimeFromUser({required bool isStartTime}){
 var pickedTime= _showTimePicker();
 String _formatedTime = pickedTime.format(context);
 if(pickedTime){

 }else if(isStartTime==true){
   _startTime = _formatedTime;
 }else if(isStartTime ==false ){
_endTime =_formatedTime;
 }

  }
  _showTimePicker(){
  return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
        initialTime: TimeOfDay(
            hour: 9,
            minute: 10)
  );
  }
}

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
  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];
  String _selectedRepeat = "none";
  List<String> repeatList = [
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];
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
              InputField(title: "Remind", hint: "$_selectedRemind minutes early",
              widget : DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down,
                  color: Colors.grey,

                ),
                iconSize: 32,
                elevation: 4,
                style: subTitleStyle,
                underline: Container(height: 0,),
                onChanged: (String? newValue){
                  setState(() {
                    _selectedRemind = int.parse(newValue!);
                  });
                },
                items: remindList.map<DropdownMenuItem<String>>((int value){
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),

                  );
                }
                ).toList(),
              ),

              ),
              InputField(title: "Repeat", hint: "$_selectedRepeat",
                widget : DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down,
                    color: Colors.grey,

                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0,),
                  onChanged: (String? newValue){
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  items: repeatList.map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: Colors.grey),),

                    );
                  }
                  ).toList(),
                ),

              ),
               SizedBox(height: 18,),
               Row(
                 children: [
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Color",
                       style: titleStyle,
                       ),
                       SizedBox(height: 8.0,),
                       Wrap(
                         children: List<Widget>.generate(
                             3, (int index){
                               return Padding(
                                 padding: const EdgeInsets.only(right: 8.0),
                                 child: CircleAvatar(
                                   radius: 14,
                                   backgroundColor: index==0?primaryClr:index==1?pinkshClr:yellowshClr,
                                 ),
                               );
                         }),
                       )
                     ],
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
  _getTimeFromUser({required bool isStartTime}) async {
 var pickedTime= await _showTimePicker();
 String _formatedTime = pickedTime.format(context);
 if(pickedTime){

 }else if(isStartTime==true){
   setState(() {
     _startTime = _formatedTime;
   });
 }else if(isStartTime ==false ){
setState(() {
  _endTime =_formatedTime;
});
 }

  }
  _showTimePicker(){
  return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        )
  );
  }
}

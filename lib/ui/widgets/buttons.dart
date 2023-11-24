import 'package:dairy_habit_reminder/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButtons({Key? key , required this.label, required this.onTap}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height:45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryClr
        ),
    child: Text(
      label,
      style:TextStyle(
        color:Colors.white,
      ) ,
    ),
      ),
    );
  }
}

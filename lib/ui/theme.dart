import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
const Color bluishClr = Color(0xFF4e5ae8);
const Color pinkClr = Color(0xFFff4667);
const Color yellowClr = Color(0xFFFFB746);
const Color white = Colors.white;
const Color primaryClr = Color(0xFF4e5ae8);
const Color darkGrayClr = Color(0xFF121212);
const Color darkheadershClr = Color(0xFF424242);

class Themes{
  static final light= ThemeData(
  primaryColor: Colors.blue,
  brightness: Brightness.light
  );

  static final dark= ThemeData (
  primaryColor: darkGrayClr,
  brightness: Brightness.dark
  );
}
TextStyle get subHeeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
        color:Get.isDarkMode?Colors.grey[400]:Colors.grey
    )
  );
}
TextStyle get heeadingStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color:Get.isDarkMode?Colors.white:Colors.black
      )
  );
}
TextStyle get titleStyle{
  return GoogleFonts.lato(
    textStyle:  TextStyle(

      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode?Colors.white:Colors.black
    )
  );
}
TextStyle get subTitleStyle{
  return GoogleFonts.lato(
      textStyle:  TextStyle(

          fontSize: 14,
          fontWeight: FontWeight.w400,
         color: Get.isDarkMode?Colors.grey[100]:Colors.grey[700]
      )
  );
}
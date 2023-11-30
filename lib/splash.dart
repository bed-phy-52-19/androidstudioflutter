import 'package:dairy_habit_reminder/ui/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Splash  extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    _navigateToHome();

  }
_navigateToHome()async{
    await Future.delayed(Duration(milliseconds:1500 ),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>HomePage()));
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(

body: Container(
      width: double.infinity,
      decoration: const BoxDecoration( gradient: LinearGradient(colors: [Colors.blue,
      Colors.purple],begin: Alignment.topRight,end: Alignment.bottomLeft),
      ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const[
      Icon(
        Icons.access_alarms_rounded,
        size: 80,
        color: CupertinoColors.white,



      ),
      SizedBox(height: 20,),
      Text("Daily habit tracker",
        style: TextStyle(fontStyle: FontStyle.italic,color: CupertinoColors.white,
        fontSize: 32),
      )
    ],
  ),

),
    );
  }
}

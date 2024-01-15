import 'package:dairy_habit_reminder/ui/services/notification_services.dart';
import 'package:dairy_habit_reminder/ui/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:share/share.dart';

import 'chat.dart';


class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _HomePageState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
  class _HomePageState extends State<NavBar> {
  var notifyHelper;
  var chart;

  @override
  void initState() {
  // TODO: implement initState
  super.initState();
 chart = ChatScreen();
  notifyHelper = NotifyHelper();
  notifyHelper.initializeNotification();
  notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(

            child: ListView(
              padding: EdgeInsets.zero,

              children: [

                UserAccountsDrawerHeader(accountName: const Text("Task reminder"), accountEmail:
                const Text("chart with friends and share experiences "),
                // currentAccountPicture: CircleAvatar(
                //   child: ClipOval(child: Image.asset('image/profile.png'),),
                // ),
                ),

ListTile(
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
  title: Text('switch mode', style: TextStyle(fontSize: 15,),
  ),

),

                ListTile(
                  leading: Icon(
                      Icons.chat_sharp
                  ),
                  title: Text('Chart and share activity', style: TextStyle(fontSize: 15),),
    onTap: () async{
    await Get.to(ChatScreen());
    }

                ),


                ListTile(
                  leading: Icon(
                      Icons.star_rate
                  ),
                  title: Text('Show progress', style: TextStyle(fontSize: 15),),
                  onTap: ()=> {

                },
                ),


                ListTile(
                  leading: Icon(
                    Icons.share_rounded
                  ),
                  title: Text('invite friends', style: TextStyle(fontSize: 15),),
                  onTap: ()=>(
                  Share.share("https://play.google.com./store/apps/details?id=com.instructivetech.testapp")
                  ),
                ),
              ],
            ),
    );
  }

}

import 'package:dairy_habit_reminder/db/db_helper.dart';
import 'package:dairy_habit_reminder/ui/home_page.dart';
import 'package:dairy_habit_reminder/ui/services/theme_services.dart';
import 'package:dairy_habit_reminder/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBhelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeServices().theme,

        home: HomePage()
    );
  }
}


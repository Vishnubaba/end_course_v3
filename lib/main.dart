import 'package:end_course/global_theme.dart';
import 'package:flutter/material.dart';
import 'string_const.dart';
import 'package:end_course/reg_screen.dart';
import 'package:end_course/user_screen.dart';
import 'package:end_course/task_screen.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const RegScreen(),
        '/users': (context) => const UserScreen(),
        '/tasks': (context) => const TaskMainScreen(),
      },
      title: Strings.appTitle,
      theme: myTheme(),
    );
  }
}


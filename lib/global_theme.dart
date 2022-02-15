import 'package:end_course/string_const.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

ThemeData myTheme() => ThemeData(
  primarySwatch: Colors.lightBlue,
  textTheme:const TextTheme(
    headline6: TextStyle(
      fontSize: 20,
      fontFamily: 'Roboto',
    ),
    headline5: TextStyle(
      fontSize: 18,
      fontFamily: 'Roboto',
    ),
  ),
);

InputDecoration textFieldDecoration(String label, BuildContext context) => InputDecoration(
  filled: true,
  fillColor: Theme.of(context).backgroundColor.withAlpha(100),
  labelText: label,
);

AppBar myAppBar(String myTitle) => AppBar(
  title: Text(myTitle),
);

Widget navDrawer(context) => Drawer(
  child: ListView(
    children: [
      ListTile(
        leading: const Icon(Icons.verified_user),
        title: const Text('Страница авторизации'),
        onTap: () {
          Navigator.pushNamed(context, '/');
        },
      ),
      ListTile(
        leading: const Icon(Icons.list),
        title: const Text('Список пользователей'),
        onTap: () {
          Navigator.pushNamed(context, '/users');
        },
      ),
/*      ListTile(
        leading: const Icon(Icons.task),
        title: const Text('Список задач'),
        onTap: () {
          Navigator.pushNamed(context, '/tasks');
        },
      ),
      */
    ],
  ),
);
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:store_app_proj/tools/app_tools.dart';
import 'userScreens/HomeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future openDB() async {
    print(DBProvider.db.deleteAll());
    print(DBProvider.db.getAllClients());
    print('DB opened');
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    openDB();
    return MaterialApp(
      title: 'Flutter Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => HomeScreen(),
      }
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

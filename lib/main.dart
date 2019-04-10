import 'dart:async';

import 'package:flutter/material.dart';
import 'userScreens/HomeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Store',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Oxygen'
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

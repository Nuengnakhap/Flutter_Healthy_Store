import 'package:flutter/material.dart';
import 'userScreens/HomeScreen.dart';
import 'userScreens/item_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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

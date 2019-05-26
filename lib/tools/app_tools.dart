import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../tools/progressdialog.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'app_data.dart';

Widget appTextField(
    {IconData textIcon,
    String textHint,
    String type,
    double sidePadding,
    TextEditingController controller}) {
  sidePadding == null ? sidePadding = 0.0 : sidePadding;
  textHint == null ? textHint = '' : textHint;
  TextInputType txtType;
  if (type == 'Email') {
    txtType = TextInputType.emailAddress;
  } else if (type == 'Phone') {
    txtType = TextInputType.number;
  } else {
    txtType = null;
  }
  return Padding(
    padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: TextField(
        controller: controller,
        obscureText: type == 'Password' ? true : false,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: textHint,
          prefixIcon: textIcon == null ? Container() : Icon(textIcon),
        ),
        keyboardType: txtType,
      ),
    ),
  );
}

Widget appButton(
    {String btnTxt,
    double btnPadding,
    Color btnColor,
    VoidCallback onBtnclicked}) {
  btnTxt == null ? btnTxt = 'App Button' : btnTxt;
  btnPadding == null ? btnPadding = 0.0 : btnPadding;
  btnColor == null ? btnColor = Colors.black : btnColor;

  return Padding(
    padding: EdgeInsets.all(btnPadding),
    child: RaisedButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      onPressed: onBtnclicked,
      child: Container(
        height: 45.0,
        child: Center(
          child: Text(
            btnTxt,
            style: TextStyle(
              color: btnColor,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    ),
  );
}

showSnackbar(String message, final key) {
  key.currentState.showSnackBar(
    SnackBar(
      backgroundColor: Colors.red[600],
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}

displayProgressDialog(BuildContext context) {
  Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return ProgressDialog();
      }));
}

closeProgressDialog(BuildContext context) {
  Navigator.of(context).pop();
}

writeDataLocally({String key, String value}) async {
  Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
  final SharedPreferences localData = await saveLocal;
  localData.setString(key, value);
}

removeDataLocally(String key) async {
  Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
  final SharedPreferences localData = await saveLocal;
  localData.remove(key);
}

Future<String> getDataLocally(String key) async {
  Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
  final SharedPreferences localData = await saveLocal;
  return localData.getString(key) ?? '';
}

// หา application path
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

// สร้าง file
Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/data.txt');
}

// write ลง file
Future<File> writeData(String data) async {
  final file = await _localFile;
  return file.writeAsString('$data');
}

// read จาก file
Future<String> readData() async {
  try {
    final file = await _localFile;
    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    return '';
  }
}


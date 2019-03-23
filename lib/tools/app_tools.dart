import 'package:flutter/material.dart';

Widget appTextField(
    {IconData textIcon,
    String textHint,
    bool isPassword,
    double sidePadding,
    TextEditingController controller}) {
  sidePadding == null ? sidePadding = 0.0 : sidePadding;
  textHint == null ? textHint = '' : textHint;
  return Padding(
    padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword == null ? false : isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: textHint,
          prefixIcon: textIcon == null ? Container() : Icon(textIcon),
        ),
      ),
    ),
  );
}

Widget appButton({String btnTxt, double btnPadding, Color btnColor}) {
  btnTxt == null ? btnTxt = 'App Button' : btnTxt;
  btnPadding == null ? btnPadding = 0.0 : btnPadding;
  btnColor == null ? btnColor = Colors.black : btnColor;
  return Padding(
    padding: EdgeInsets.all(btnPadding),
    child: RaisedButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      onPressed: () {},
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

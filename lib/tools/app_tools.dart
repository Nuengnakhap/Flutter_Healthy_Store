import 'package:flutter/material.dart';

Widget appTextField(
    {IconData textIcon,
    String textHint,
    String type,
    double sidePadding,
    TextEditingController controller}) {
  sidePadding == null ? sidePadding = 0.0 : sidePadding;
  textHint == null ? textHint = '' : textHint;
  TextInputType txtType;
  if(type == 'Email') {
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

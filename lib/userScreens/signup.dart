import 'package:flutter/material.dart';
import 'package:store_app_proj/tools/app_methods.dart';
import 'package:store_app_proj/tools/firebase_methods.dart';
import '../tools/app_tools.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController fullname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController re_password = TextEditingController();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  AppMethods appMethod = FirebaseMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: false,
        // elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            appTextField(
              sidePadding: 18.0,
              textHint: 'Full Name',
              textIcon: Icons.person,
              controller: fullname,
            ),
            SizedBox(
              height: 30.0,
            ),
            appTextField(
              type: 'Phone',
              sidePadding: 18.0,
              textHint: 'Phone Number',
              textIcon: Icons.phone,
              controller: phone,
            ),
            SizedBox(
              height: 30.0,
            ),
            appTextField(
              type: 'Email',
              sidePadding: 18.0,
              textHint: 'Email Address',
              textIcon: Icons.email,
              controller: email,
            ),
            SizedBox(
              height: 30.0,
            ),
            appTextField(
              type: 'Password',
              sidePadding: 18.0,
              textHint: 'Password',
              textIcon: Icons.lock,
              controller: password,
            ),
            SizedBox(
              height: 30.0,
            ),
            appTextField(
              type: 'Password',
              sidePadding: 18.0,
              textHint: 'Re-Password',
              textIcon: Icons.lock,
              controller: re_password,
            ),
            appButton(
              btnTxt: 'Register',
              btnPadding: 18.0,
              btnColor: Theme.of(context).primaryColor,
              onBtnclicked: verifyDetails,
            ),
          ],
        ),
      ),
    );
  }

  verifyDetails() {
    if (fullname.text == '') {
      showSnackbar('Full Name cannot be empty', scaffoldkey);
      return;
    }
    if (phone.text == '') {
      showSnackbar('Phone Number cannot be empty', scaffoldkey);
      return;
    }
    if (email.text == '') {
      showSnackbar('Email cannot be empty', scaffoldkey);
      return;
    }
    if (password.text == '') {
      showSnackbar('Password cannot be empty', scaffoldkey);
      return;
    }
    if (re_password.text == '') {
      showSnackbar('Re-Password cannot be empty', scaffoldkey);
      return;
    }
    if (password.text != re_password.text) {
      showSnackbar('Password don\'t match', scaffoldkey);
      return;
    }
    displayProgressDialog(context);
  }
}
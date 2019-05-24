import 'package:flutter/material.dart';
import '../tools/app_tools.dart';
import 'signup.dart';
import '../tools/app_methods.dart';
import '../tools/firebase_methods.dart';
import '../tools/app_data.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final scaffoldkey = GlobalKey<ScaffoldState>();

  AppMethods appMethod = FirebaseMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Login'),
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
            appButton(
              btnTxt: 'Login',
              btnPadding: 18.0,
              btnColor: Theme.of(context).primaryColor,
              onBtnclicked: verifyLogin,
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SignUp()));
              },
              child: Text(
                'Not Registered? Sign Up Here',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  verifyLogin() async {
    if (email.text == '') {
      showSnackbar('Email cannot be empty', scaffoldkey);
      return;
    }
    if (password.text == '') {
      showSnackbar('Password cannot be empty', scaffoldkey);
      return;
    }
    displayProgressDialog(context);

    String response =
        await appMethod.loginUser(email: email.text, password: password.text);
    if (response == successful) {
      closeProgressDialog(context);
      Navigator.pop(context, true);
      Navigator.pop(context);
    } else {
      closeProgressDialog(context);
      showSnackbar(response, scaffoldkey);
    }
  }
}

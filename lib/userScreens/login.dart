import 'package:flutter/material.dart';
import '../tools/app_tools.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: 'Email Address',
                textIcon: Icons.email,
                controller: email,
              ),
              SizedBox(
                height: 30.0,
              ),
              appTextField(
                isPassword: true,
                sidePadding: 18.0,
                textHint: 'Password',
                textIcon: Icons.lock,
                controller: password,
              ),
              appButton(
                btnTxt: 'Login',
                btnPadding: 18.0,
                btnColor: Theme.of(context).primaryColor,
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Not Registered? Sign Up Here',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ));
  }
}

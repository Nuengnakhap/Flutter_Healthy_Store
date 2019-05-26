import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app_proj/userScreens/HomeScreen.dart';

class PaymentSuccessPage extends StatefulWidget {
  @override
  PaymentSuccessPageState createState() {
    return new PaymentSuccessPageState();
  }
}

class PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  void initState() {
    super.initState();
    showSuccessDialog();
  }

  bool isDataAvailable = true;
  Widget bodyData() => Center(
        child: CircularProgressIndicator(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Success'),
      ),
      body: bodyData(),
    );
  }

  void showSuccessDialog() {
    setState(() {
      isDataAvailable = false;
      Future.delayed(Duration(seconds: 3)).then((_) => goToDialog());
    });
  }

  goToDialog() {
    setState(() {
      isDataAvailable = true;
    });
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    successTicket(),
                    SizedBox(
                      height: 10.0,
                    ),
                    FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      backgroundColor: Colors.black,
                      label: Text(
                        "BACK TO HOME",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    // FloatingActionButton(
                    //   backgroundColor: Colors.black,
                    //   child: Icon(
                    //     Icons.clear,
                    //     color: Colors.white,
                    //   ),
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //   },
                    // )
                  ],
                ),
              ),
            ));
  }

  successTicket() => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Material(
          clipBehavior: Clip.antiAlias,
          elevation: 2.0,
          borderRadius: BorderRadius.circular(4.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                profileTile(
                  title: "Thank You!",
                  textColor: Colors.purple,
                  subtitle: "Your transaction was successful",
                ),
                ListTile(
                  title: Text("Date"),
                  subtitle: Text("26 June 2018"),
                  trailing: Text("11:00 AM"),
                ),
                ListTile(
                  title: Text("Pawan Kumar"),
                  subtitle: Text("mtechviral@gmail.com"),
                  trailing: CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                        "https://avatars0.githubusercontent.com/u/12619420?s=460&v=4"),
                  ),
                ),
                ListTile(
                  title: Text("Amount"),
                  subtitle: Text("\$299"),
                  trailing: Text("Completed"),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 0.0,
                  color: Colors.grey.shade300,
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.ccAmex,
                      color: Colors.blue,
                    ),
                    title: Text("Credit/Debit Card"),
                    subtitle: Text("Amex Card ending ***6"),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}

Widget profileTile({title, subtitle, textColor}) {
  textColor = Colors.black;
  return Column(
    // crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        title,
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.w700, color: textColor),
      ),
      SizedBox(
        height: 5.0,
      ),
      Text(
        subtitle,
        style: TextStyle(
            fontSize: 15.0, fontWeight: FontWeight.normal, color: textColor),
      ),
    ],
  );
}

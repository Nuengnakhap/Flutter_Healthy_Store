import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app_proj/dbModels/client.dart';
import 'package:store_app_proj/tools/address_picker.dart';
import 'package:store_app_proj/tools/app_db.dart';
import 'package:store_app_proj/tools/firebase_methods.dart';

class Delivery extends StatefulWidget {
  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  FirebaseMethods appMethods = FirebaseMethods();
  String uid = "jsjh7p1Tx4M4S4T0oGu0IdvZcWg2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Address'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(CupertinoPageRoute(builder: (BuildContext context) {
                return AddressPicker();
              }));
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: appMethods.getAddress(uid),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot item =
                    snapshot.data.documents.elementAt(index);
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 12, 15, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.data["addressName"],
                          textAlign: TextAlign.left,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                child: Text(
                                  "Edit",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            Expanded(
                              child: RaisedButton(
                                color: Colors.red,
                                child: Text(
                                  "Remove",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                                onPressed: () async {
                                  item.reference.delete();
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('Please add your Address'),
            );
          }
        },
      ),
    );
  }
}

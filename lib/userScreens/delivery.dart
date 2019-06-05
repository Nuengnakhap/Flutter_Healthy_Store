import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:store_app_proj/tools/address_picker.dart';
import 'package:store_app_proj/tools/firebase_methods.dart';
import 'package:store_app_proj/userScreens/HomeScreen.dart';

class Delivery extends StatefulWidget {
  final String userId;

  const Delivery({Key key, this.userId}) : super(key: key);
  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  FirebaseMethods appMethods = FirebaseMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Address'),
        automaticallyImplyLeading: false,
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) {
                  return HomeScreen();
                },
              ));
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Location location = Location();
              location.hasPermission().then((value) {
                if (value) {
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (BuildContext context) {
                    return AddressPicker(userId: widget.userId);
                  }));
                } else {
                  Location().getLocation().then((l) {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (BuildContext context) {
                      return AddressPicker(userId: widget.userId);
                    }));
                  });
                }
              });
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: appMethods.getAddress(widget.userId),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data.documents.length > 0) {
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
                    padding: EdgeInsets.fromLTRB(20, 18, 15, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.data["addressname"],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                        Text(
                          "Reciever: ${item.data["fullname"]}",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          "Phone: ${item.data["phone"]}",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          "Address: ${item.data["address"]}",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          "District: ${item.data["district"]}",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          "Province: ${item.data["province"]}",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          "Zipcode: ${item.data["zipcode"]}",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 17),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                child: Text(
                                  "Edit",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (BuildContext context) {
                                    return AddressPicker.update(item);
                                  }));
                                },
                              ),
                            ),
                            Expanded(
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                color: Colors.red,
                                child: Text(
                                  "Remove",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                                onPressed: () async {
                                  await item.reference.delete();
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

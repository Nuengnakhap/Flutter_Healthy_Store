import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store_app_proj/tools/app_data.dart' as prefix0;
import 'package:store_app_proj/tools/app_methods.dart';
import 'package:store_app_proj/tools/firebase_methods.dart';

class OrderHistory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderHistoryState();
}

class Item {
  final String name;
  final String deliveryTime;
  final String oderId;
  final String oderAmount;
  final String paymentType;
  final String address;
  final String cancelOder;

  Item(
      {this.name,
      this.deliveryTime,
      this.oderId,
      this.oderAmount,
      this.paymentType,
      this.address,
      this.cancelOder});
}

class _OrderHistoryState extends State<OrderHistory> {
  AppMethods appMethods = FirebaseMethods();

  List list = ['12', '11'];
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;

  List<Item> itemList = <Item>[
    Item(
        name: 'Jhone Miller',
        deliveryTime: '26-5-2106',
        oderId: '#CN23656',
        oderAmount: '\₹ 650',
        paymentType: 'online',
        address: '1338 Karen Lane,Louisville,Kentucky',
        cancelOder: 'Cancel Order'),
    Item(
        name: 'Gautam Dass',
        deliveryTime: '10-8-2106',
        oderId: '#CN33568',
        oderAmount: '\₹ 900',
        paymentType: 'COD',
        address: '319 Alexander Drive,Ponder,Texas',
        cancelOder: 'View Receipt'),
    Item(
        name: 'Jhone Hill',
        deliveryTime: '23-3-2107',
        oderId: '#CN75695',
        oderAmount: '\₹ 250',
        paymentType: 'online',
        address: '92 Jarvis Street,Buffalo,New York',
        cancelOder: 'View Receipt'),
    Item(
        name: 'Miller Root',
        deliveryTime: '10-5-2107',
        oderId: '#CN45238',
        oderAmount: '\₹ 500',
        paymentType: 'Bhim/upi',
        address: '103 Romrog Way,Grand Island,Nebraska',
        cancelOder: 'Cancel Order'),
    Item(
        name: 'Lag Gilli',
        deliveryTime: '26-10-2107',
        oderId: '#CN69532',
        oderAmount: '\₹ 1120',
        paymentType: 'online',
        address: '8 Clarksburg Park,Marble Canyon,Arizona',
        cancelOder: 'View Receipt'),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    final Orientation orientation = MediaQuery.of(context).orientation;
    return new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Order History'),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: appMethods.getOrderHistory(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Center(child: new Text("There is no expense"));
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext cont, int index) {
                    return SafeArea(
                        child: Column(children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(
                              left: 5.0, right: 5.0, bottom: 5.0),
                          color: Colors.black12,
                          child: Card(
                              elevation: 4.0,
                              child: Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 10.0, 10.0, 10.0),
                                  child: GestureDetector(
                                      child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      // three line description
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          snapshot.data.documents[index]
                                              .data['userID'],
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(top: 3.0),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'To Deliver On : 2562-5-27',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black54),
                                        ),
                                      ),
                                      Divider(
                                        height: 10.0,
                                        color: Colors.amber.shade500,
                                      ),

                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              padding: EdgeInsets.all(3.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    'Order Id',
                                                    style: TextStyle(
                                                        fontSize: 13.0,
                                                        color: Colors.black54),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 3.0),
                                                    child: Text(
                                                      snapshot
                                                          .data
                                                          .documents[index]
                                                          .documentID,
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                  )
                                                ],
                                              )),
                                          Container(
                                              padding: EdgeInsets.all(3.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    'Order Amount',
                                                    style: TextStyle(
                                                        fontSize: 13.0,
                                                        color: Colors.black54),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 3.0),
                                                    child: Text(
                                                      "\$${snapshot.data.documents[index].data['total_price'].toString()}",
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Container(
                                              padding: EdgeInsets.all(3.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    'Payment Type',
                                                    style: TextStyle(
                                                        fontSize: 13.0,
                                                        color: Colors.black54),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 3.0),
                                                    child: Text(
                                                      "Online",
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                      Divider(
                                        height: 10.0,
                                        color: Colors.amber.shade500,
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            size: 20.0,
                                            color: Colors.amber.shade500,
                                          ),
                                          Text(itemList[index].address,
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black54)),
                                        ],
                                      ),
                                      Divider(
                                        height: 10.0,
                                        color: Colors.amber.shade500,
                                      ),
                                      Container(child: _status("Success"))
                                    ],
                                  ))))),
                    ]));
                  });
            }));
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  Widget _status(status) {
    if (status == 'Cancel Order') {
      return FlatButton.icon(
          label: Text(
            status,
            style: TextStyle(color: Colors.red),
          ),
          icon: const Icon(
            Icons.highlight_off,
            size: 18.0,
            color: Colors.red,
          ),
          onPressed: () {
            // Perform some action
          });
    } else {
      return FlatButton.icon(
          label: Text(
            status,
            style: TextStyle(color: Colors.green),
          ),
          icon: const Icon(
            Icons.check_circle,
            size: 18.0,
            color: Colors.green,
          ),
          onPressed: () {
            // Perform some action
          });
    }
    if (status == "3") {
      return Text('Process');
    } else if (status == "1") {
      return Text('Order');
    } else {
      return Text("Waiting");
    }
  }

  erticalD() => Container(
        margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
      );

  bool a = true;
  String mText = "Press to hide";
  double _lowerValue = 1.0;
  double _upperValue = 100.0;

  void _visibilitymethod() {
    setState(() {
      if (a) {
        a = false;
        mText = "Press to show";
      } else {
        a = true;
        mText = "Press to hide";
      }
    });
  }
}

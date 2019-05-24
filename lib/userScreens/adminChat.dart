import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat.dart';

class AdminScreen extends StatefulWidget {
  final String peerAvatar;
  final String userId;
  AdminScreen({Key key, @required this.userId, @required this.peerAvatar})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return AdminScreenState();
  }
}

class AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('List User'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: StreamBuilder(
            stream: Firestore.instance
                .collection('usersData')
                .where('isMessage', isEqualTo: 1)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData && snapshot.data.documents.length == 0) {
                return Center(
                  child: Text('No user chat on you'),
                );
              } else {
                return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (context, index) =>
                      buildList(context, snapshot.data.documents[index]),
                  itemCount: snapshot.data.documents.length,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, DocumentSnapshot document) {
    return Container(
      child: document['isMessage'] == 0
          ? Container()
          : FlatButton(
              child: Row(
                children: <Widget>[
                  Material(
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Container(
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                            ),
                            width: 50.0,
                            height: 50.0,
                            padding: EdgeInsets.all(15.0),
                          ),
                      imageUrl: document['photoURL'],
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    clipBehavior: Clip.hardEdge,
                  ),
                  Flexible(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Name: ${document['acctFullName']}',
                              style: TextStyle(color: Colors.black),
                            ),
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                          ),
                          Container(
                            child: Text(
                              'Tell: ${document['phoneNumber'] ?? '-'}',
                              style: TextStyle(color: Colors.black),
                            ),
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(left: 20.0),
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Firestore.instance
                    .collection('usersData')
                    .document(document.documentID)
                    .get()
                    .then((item) {
                  Firestore.instance
                      .collection('usersData')
                      .document(document.documentID)
                      .setData({
                    'acctFullName': item['acctFullName'],
                    'phoneNumber': item['phoneNumber'],
                    'photoURL': item['photoURL'],
                    'userEmail': item['userEmail'],
                    'userID': item['userID'],
                    'userPassword': item['userPassword'],
                    'isMessage': 0
                  }).then((r) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Chat(
                              peerId: document.documentID,
                              userId: widget.userId,
                              peerAvatar: document['photoURL'],
                            ),
                      ),
                    );
                  });
                });
              },
              color: Colors.yellow,
              padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ),
      margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
    );
  }
}

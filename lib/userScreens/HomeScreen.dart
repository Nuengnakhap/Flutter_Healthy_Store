import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'favorites.dart';
import 'messages.dart';
import 'cart.dart';
import 'notifications.dart';
import 'history.dart';
import 'profile.dart';
import 'delivery.dart';
import 'about.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Healthies'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context)
                  .push(CupertinoPageRoute(builder: (BuildContext context) {
                return Favorites();
              }));
            },
          ),
          Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.chat),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (BuildContext context) {
                    return Messages();
                  }));
                },
              ),
              CircleAvatar(
                radius: 8.0,
                backgroundColor: Colors.red,
                child: Text(
                  '0',
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              )
            ],
          )
        ],
      ),
      body: Center(
        child: Text('data'),
      ),
      floatingActionButton: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(CupertinoPageRoute(builder: (BuildContext context) {
                return Cart();
              }));
            },
            child: Icon(Icons.shopping_cart),
          ),
          CircleAvatar(
            radius: 10.0,
            backgroundColor: Colors.red,
            child: Text(
              '0',
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
              accountName: Text('Kitrawee'),
              accountEmail: Text('60070005@kmitl.ac.th'),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text('Order Notifications'),
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return Notifications();
                }));
              },
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  Icons.history,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text('Order History'),
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return History();
                }));
              },
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text('Profile Settings'),
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return Profile();
                }));
              },
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text('Delivery Address'),
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return Delivery();
                }));
              },
            ),
            Divider(),
            ListTile(
              trailing: CircleAvatar(
                child: Icon(
                  Icons.help,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text('About Us'),
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return About();
                }));
              },
            ),
            ListTile(
              trailing: CircleAvatar(
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:store_app_proj/dbModels/Store.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  Future<List<Store>> loadPost() async {
    Response response = await get(
        "http://api.walmartlabs.com/v1/search?apiKey=yvjjwrpu5t9tegghg4a5qs6z&query=healthy&categoryId=976759&start=1&numItems=25");
    // http.Response response = await http.get(
    //     "https://grocery.walmart.com/v4/api/products/search?storeId=1855&page=1&query=healthy");
    Map<String, dynamic> data = json.decode(response.body);
    var rest = data['items'] as List;
    print(data['query']);
    List<Store> stores = rest.map((json) => Store.fromJson(json)).toList();
    return stores;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorites'),
        centerTitle: false,
      ),
      body: FutureBuilder(
        future: loadPost(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) {
            return Container(
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    padding: EdgeInsets.all(15.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(snapshot.data.elementAt(index).itemName),
                            subtitle: Text(snapshot.data.elementAt(index).itemName),
                            onTap: () {
                              print(
                                  "tab on ${snapshot.data.elementAt(index).itemName}");
                            },
                          )
                        ],
                      );
                    }));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

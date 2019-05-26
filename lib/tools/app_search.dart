import 'package:flutter/material.dart';
import 'package:store_app_proj/dbModels/Store.dart';

import 'dart:core';

import 'package:store_app_proj/userScreens/item_details.dart';

class DataSearch extends SearchDelegate<String> {
  List<Store> items;
  DataSearch({this.items});
  final recent = [];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recent
        : items
            .where(
                (p) => p.itemName.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ItemDetail(
                    product: suggestionList[index]
                  );
                },
              ),
            );
          },
          leading: Icon(Icons.shopping_cart),
          title: RichText(
            text: TextSpan(
                text: suggestionList[index].itemName.substring(0, query.length),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                      text: suggestionList[index]
                          .itemName
                          .substring(query.length),
                      style: TextStyle(color: Colors.grey))
                ]),
          ),
        );
      },
      itemCount: suggestionList.length,
    );
  }
}

// REF Search App -> https://www.youtube.com/watch?v=FPcl1tu0gDs 21.33

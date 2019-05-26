import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:store_app_proj/components/product_favorite.dart';
import 'package:store_app_proj/components/products.dart';
import 'package:store_app_proj/components/shopping_cart.dart';
import 'package:store_app_proj/dbModels/Store.dart';
import 'package:store_app_proj/dbModels/client.dart';
import 'package:store_app_proj/dbModels/order.dart';
import 'package:store_app_proj/tools/app_db.dart';
import 'package:store_app_proj/tools/app_methods.dart';
import 'package:store_app_proj/tools/favorite_bloc.dart';
import 'package:store_app_proj/tools/firebase_methods.dart';
import 'package:store_app_proj/tools/progressdialog.dart';
import 'package:store_app_proj/userScreens/HomeScreen.dart';
import 'adminChat.dart';
import 'notifications.dart';
import 'history.dart';
import 'profile.dart';
import 'delivery.dart';
import 'about.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Color firstColor = Color.fromRGBO(29, 233, 182, 1);
Color secondColor = Color.fromRGBO(0, 96, 100, 1);
Color green = Color(0xFF272D34);

class FavoritesScreen extends StatefulWidget {
  @override
  FavoritesScreennState createState() => FavoritesScreennState();
}

class FavoritesScreennState extends State<FavoritesScreen> {
  FavoriteBloc _favoriteBloc = FavoriteBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        initialData: _favoriteBloc.currentFavorite,
        stream: _favoriteBloc.observableFavorite,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) {
            return ListProductFav(items: snapshot.data);
          } else {
            return Center(child: ProgressDialog());
          }
        },
      ),
      floatingActionButton: ShoppingCart(),
    );
  }
}

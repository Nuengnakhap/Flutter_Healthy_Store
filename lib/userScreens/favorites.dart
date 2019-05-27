
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:store_app_proj/components/favorite_card.dart';
import 'package:store_app_proj/components/shopping_cart.dart';
import 'package:store_app_proj/dbModels/Store.dart';
import 'package:store_app_proj/dbModels/favorite.dart';

import 'package:store_app_proj/tools/favorite_bloc.dart';


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
        builder: (BuildContext context, AsyncSnapshot<Favorite> snapshot) {
          MediaQueryData queryData  = MediaQuery.of(context);
          if (snapshot.hasData && snapshot.data.productsCount > 0) {
            return Center(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Favorite products',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                  // HomeScreenTopPart(),
                  SliverGrid(
                    // physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (queryData.size.width / 2) / 270),
                    // itemCount: items.length,
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Card(
                          child: FavoriteCard(
                            product: Store.items(
                              itemName: snapshot.data.products.elementAt(index).itemName,
                              itemImage: snapshot.data.products.elementAt(index).itemImage,
                              itemPrice: snapshot.data.products.elementAt(index).itemPrice,
                              itemRating: snapshot.data.products.elementAt(index).itemRating,
                              itemDesc: snapshot.data.products.elementAt(index).itemDesc,
                            ),
                          ),
                        );
                      },
                      childCount: snapshot.data.products.length,
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(child: Text('Don\'t have favorite products!'));
          }
        },
      ),
      floatingActionButton: ShoppingCart(),
    );
  }
}

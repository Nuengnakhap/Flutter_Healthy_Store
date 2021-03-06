import 'package:flutter/material.dart';
import 'package:store_app_proj/components/mostrating.dart';
import 'package:store_app_proj/components/product_card.dart';
import 'package:store_app_proj/components/searchbar.dart';
import 'package:store_app_proj/dbModels/Store.dart';
import 'package:store_app_proj/tools/favorite_bloc.dart';

class ListProduct extends StatefulWidget {
  List<Store> items;
  bool isLoggedIn;
  ListProduct({Key key, this.items, this.isLoggedIn}) : super(key: key);

  @override
  ListProductState createState() => ListProductState();
}

class ListProductState extends State<ListProduct> {
  FavoriteBloc _favoriteBloc = FavoriteBloc();
  @override
  Widget build(BuildContext context) {
    List<Store> items = widget.items;
    MediaQueryData queryData = MediaQuery.of(context);
    return Center(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              SearchBar(items: items),
              Card(
                child: MostRating(
                  items: items,
                  isLoggedIn: widget.isLoggedIn,
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'All products',
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
                bool checked = false;
                for (var item in _favoriteBloc.currentFavorite.products) {
                  if (item.itemName == items.elementAt(index).itemName) {
                    checked = true;
                  }
                }
                return Card(
                  child: ProductCard(
                    product: Store.items(
                      itemName: items.elementAt(index).itemName,
                      itemImage: items.elementAt(index).itemImage,
                      itemPrice: items.elementAt(index).itemPrice,
                      itemRating: items.elementAt(index).itemRating,
                      itemDesc: items.elementAt(index).itemDesc,
                    ),
                    checked: checked,
                    isLoggedIn: widget.isLoggedIn,
                  ),
                );
              },
              childCount: items.length,
            ),
          )
        ],
      ),
    );
  }
}

// Reference Sliver -> https://benzneststudios.com/blog/flutter/what-is-a-sliver-and-sliver-delegate-in-flutter-ep-1/
// https://medium.com/flutterpub/flutter-listview-gridview-inside-scrollview-68b722ae89d4

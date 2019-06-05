import 'package:flutter/material.dart';
import 'package:store_app_proj/components/product_card.dart';
import 'package:store_app_proj/dbModels/Store.dart';
import 'package:store_app_proj/tools/favorite_bloc.dart';

class MostRating extends StatefulWidget {
  List<Store> items;
  bool isLoggedIn;
  MostRating({Key key, this.items, this.isLoggedIn}) : super(key: key);

  @override
  _MostRatingState createState() => _MostRatingState();
}

class _MostRatingState extends State<MostRating> {
  FavoriteBloc _favoriteBloc = FavoriteBloc();
  List<Store> newList;

  @override
  void initState() {
    super.initState();
    checkRatings();
  }

  checkRatings() async {
    newList = List();
    List<Store> useList = List();
    for (var item in widget.items) {
      newList.add(item);
    }
    newList.sort((a, b) =>
        double.parse(a.itemRating).compareTo(double.parse(b.itemRating)));
    for (var i = newList.length - 1; i > newList.length - 6; i--) {
      useList.add(newList[i]);
    }
    newList.clear();
    newList = useList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Top 5 Most popular products',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 260.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                bool checked = false;
                for (var item in _favoriteBloc.currentFavorite.products) {
                  if (item.itemName == newList[index].itemName) {
                    print(newList[index].itemName);
                    checked = true;
                  }
                }
                return ProductCard(
                  product: Store.items(
                    itemName: newList[index].itemName,
                    itemPrice: newList[index].itemPrice,
                    itemImage: newList[index].itemImage,
                    itemRating: newList[index].itemRating,
                    itemDesc: newList[index].itemDesc,
                  ),
                  checked: checked,
                  isLoggedIn: widget.isLoggedIn,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

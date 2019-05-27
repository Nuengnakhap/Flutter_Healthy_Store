import 'package:flutter/material.dart';
import 'package:store_app_proj/components/product_card.dart';
import 'package:store_app_proj/dbModels/Store.dart';

class MostRating extends StatefulWidget {
  List<Store> items;
  MostRating({Key key, this.items}) : super(key: key);

  @override
  _MostRatingState createState() => _MostRatingState();
}

class _MostRatingState extends State<MostRating> {
  List<Store> newList;
  @override
  void initState() {
    super.initState();
    checkRatings();
  }

  checkRatings() async {
    newList = List();
    for (var item in widget.items) {
      newList.add(item);
    }
    newList.sort((a, b) => double.parse(a.itemRating).compareTo(double.parse(b.itemRating)));
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
                return ProductCard(
                  product: Store.items(
                    itemName: newList[newList.length - 1 - index].itemName,
                    itemPrice: newList[newList.length - 1 - index].itemPrice,
                    itemImage: newList[newList.length - 1 - index].itemImage,
                    itemRating: newList[newList.length - 1 - index].itemRating,
                    itemDesc: newList[newList.length - 1 - index].itemDesc,
                  ),
                  checked: false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

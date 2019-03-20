import 'package:flutter/material.dart';
import '../tools/utils.dart';

class ItemDetail extends StatefulWidget {
  String itemName;
  double itemPrice;
  String itemImage;
  double itemRating;

  ItemDetail({this.itemName, this.itemPrice, this.itemImage, this.itemRating});
  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF696D77), Color(0xFF292C36)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          tileMode: TileMode.clamp,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            'Item Detail',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            ProductScreenTopPart(
              itemName: widget.itemName,
              itemImage: widget.itemImage,
              itemPrice: widget.itemPrice,
              itemRating: widget.itemRating,
            )
          ],
        ),
      ),
    );
  }
}

class ProductScreenTopPart extends StatefulWidget {
  String itemName;
  double itemPrice;
  String itemImage;
  double itemRating;

  ProductScreenTopPart(
      {this.itemName, this.itemPrice, this.itemImage, this.itemRating});
  @override
  _ProductScreenTopPartState createState() => _ProductScreenTopPartState();
}

class _ProductScreenTopPartState extends State<ProductScreenTopPart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenAwareSize(245.0, context),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                child: Image.network(
                  widget.itemImage,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: NetworkImage(widget.itemImage),
                //     fit: BoxFit.fitWidth,
                //   ),
                // ),
              ),
            ],
          ),
          Positioned(
            left: 18.0,
            bottom: 15.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Rating',
                  style: TextStyle(
                    color: Color(0xFF949598),
                    fontSize: 10.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 8.0,
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xFFFFE600),
                      size: 10.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "${widget.itemRating}",
                      style: TextStyle(
                        color: Color(0xFFFFE600),
                        fontSize: 10.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '(370 People)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

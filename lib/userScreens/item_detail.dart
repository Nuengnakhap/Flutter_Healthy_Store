import 'package:flutter/material.dart';
import '../tools/utils.dart';

class ItemDetail extends StatefulWidget {
  String itemName;
  double itemPrice;
  String itemImage;
  double itemRating;
  String itemDesc;
  List<String> sizeList;

  ItemDetail({
    this.itemName,
    this.itemPrice,
    this.itemImage,
    this.itemRating,
    this.itemDesc,
    this.sizeList,
  });
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
              itemDesc: widget.itemDesc,
              sizeList: widget.sizeList,
            ),
            ProductScreenBottomPart(
              itemName: widget.itemName,
              itemImage: widget.itemImage,
              itemPrice: widget.itemPrice,
              itemRating: widget.itemRating,
              itemDesc: widget.itemDesc,
              sizeList: widget.sizeList,
            ),
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
  String itemDesc;
  List<String> sizeList;

  ProductScreenTopPart({
    this.itemName,
    this.itemPrice,
    this.itemImage,
    this.itemRating,
    this.itemDesc,
    this.sizeList,
  });
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

class ProductScreenBottomPart extends StatefulWidget {
  String itemName;
  double itemPrice;
  String itemImage;
  double itemRating;
  String itemDesc;
  List<String> sizeList;

  ProductScreenBottomPart({
    this.itemName,
    this.itemPrice,
    this.itemImage,
    this.itemRating,
    this.itemDesc,
    this.sizeList,
  });
  @override
  _ProductScreenBottomPartState createState() =>
      _ProductScreenBottomPartState();
}

class _ProductScreenBottomPartState extends State<ProductScreenBottomPart> {
  bool isExpanded = false;

  void _expand() {
    setState(() {
      isExpanded ? isExpanded = false : isExpanded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 18.0),
            child: Text(
              'Product Description',
              style: TextStyle(
                color: Color(0xFF949598),
                fontSize: 10.0,
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 26.0, right: 18.0),
            child: AnimatedCrossFade(
              firstChild: Text(
                widget.itemDesc,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                ),
              ),
              secondChild: Text(
                widget.itemDesc,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                ),
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: kThemeAnimationDuration,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 26.0, right: 18.0),
            child: GestureDetector(
              onTap: _expand,
              child: Text(
                isExpanded ? "less" : "more...",
                style: TextStyle(
                  color: Color(0xFFFB382F),
                  fontWeight: FontWeight.w700,
                  fontSize: 10.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
              right: 75.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Size',
                  style: TextStyle(
                    color: Color(0xFF949598),
                    fontSize: 10.0,
                  ),
                ),
                Text(
                  'Quantity',
                  style: TextStyle(
                    color: Color(0xFF949598),
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: widget.sizeList.map((item) {
                  return GestureDetector(
                    onTap: () {},
                    child: sizeItem(),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget sizeItem(String size, bool isSelected, BuildContext context) {
  return Container(
    width: 30.0,
    height: 30.0,
    decoration: BoxDecoration(
      color: isSelected ? Color(0xFFFC3930) : Color(0xFF525663),
      boxShadow: [
        BoxShadow(
          color: isSelected ? Colors.black.withOpacity(.5) : Colors.black12,
        ),
      ],
    ),
  );
}

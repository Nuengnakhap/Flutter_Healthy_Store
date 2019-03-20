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
            left: screenAwareSize(18.0, context),
            bottom: screenAwareSize(15.0, context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Rating',
                  style: TextStyle(
                    color: Color(0xFF949598),
                    fontSize: screenAwareSize(10.0, context),
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
                        fontSize: screenAwareSize(10.0, context),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '(370 People)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenAwareSize(10.0, context),
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
  int currentSizeIndex = 0;
  int _counter = 1;

  void _increase() {
    setState(() {
      _counter++;
    });
  }

  void _decrease() {
    setState(() {
      if (_counter > 1) _counter--;
    });
  }

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
            padding: EdgeInsets.only(
                top: screenAwareSize(10.0, context),
                left: screenAwareSize(18.0, context)),
            child: Text(
              'Product Description',
              style: TextStyle(
                color: Color(0xFF949598),
                fontSize: screenAwareSize(10.0, context),
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenAwareSize(26.0, context),
                right: screenAwareSize(18.0, context)),
            child: AnimatedCrossFade(
              firstChild: Text(
                widget.itemDesc,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenAwareSize(10.0, context),
                ),
              ),
              secondChild: Text(
                widget.itemDesc,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenAwareSize(10.0, context),
                ),
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: kThemeAnimationDuration,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenAwareSize(26.0, context),
                right: screenAwareSize(18.0, context)),
            child: GestureDetector(
              onTap: _expand,
              child: Text(
                isExpanded ? "less" : "more...",
                style: TextStyle(
                  color: Color(0xFFFB382F),
                  fontWeight: FontWeight.w700,
                  fontSize: screenAwareSize(10.0, context),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: screenAwareSize(18.0, context),
              right: screenAwareSize(90.0, context),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Size',
                  style: TextStyle(
                    color: Color(0xFF949598),
                    fontSize: screenAwareSize(10.0, context),
                  ),
                ),
                Text(
                  'Quantity',
                  style: TextStyle(
                    color: Color(0xFF949598),
                    fontSize: screenAwareSize(10.0, context),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenAwareSize(16.0, context),
                right: screenAwareSize(13.0, context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: screenAwareSize(38.0, context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.sizeList.map((item) {
                      var index = widget.sizeList.indexOf(item);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            currentSizeIndex = index;
                          });
                        },
                        child:
                            sizeItem(item, index == currentSizeIndex, context),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Container(
                    width: screenAwareSize(100.0, context),
                    height: screenAwareSize(30.0, context),
                    decoration: BoxDecoration(
                      color: Color(0xFF525663),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible(
                          flex: 3,
                          child: GestureDetector(
                            onTap: _decrease,
                            child: Container(
                              height: double.infinity,
                              child: Center(
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        divider(),
                        Flexible(
                          flex: 3,
                          child: Container(
                            height: double.infinity,
                            child: Center(
                              child: Text(
                                _counter.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        divider(),
                        Flexible(
                          flex: 3,
                          child: GestureDetector(
                            onTap: _increase,
                            child: Container(
                              height: double.infinity,
                              child: Center(
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: screenAwareSize(18.0, context)),
            child: Text(
              'Price',
              style: TextStyle(
                fontSize: screenAwareSize(10.0, context),
                color: Color(0xFF949598),
              ),
            ),
          ),
          SizedBox(
            height: screenAwareSize(8.0, context),
          ),
          Container(
            width: double.infinity,
            height: screenAwareSize(120.0, context),
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: screenAwareSize(22.0, context)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: screenAwareSize(18.0, context)),
                        child: Row(
                          children: <Widget>[
                            Text(
                              '250',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenAwareSize(26.0, context),
                              ),
                            ),
                            SizedBox(
                              width: screenAwareSize(2.0, context),
                            ),
                            Text(
                              ' Baht',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenAwareSize(26.0, context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenAwareSize(10.0, context),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: MaterialButton(
                          color: Color(0xFFFB382F),
                          padding: EdgeInsets.symmetric(
                            vertical: screenAwareSize(14.0, context),
                          ),
                          onPressed: () {},
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: screenAwareSize(35.0, context)),
                              child: Text(
                                'Add To Cart',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenAwareSize(15.0, context),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget sizeItem(String size, bool isSelected, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(left: screenAwareSize(12.0, context)),
    child: Container(
      width: screenAwareSize(30.0, context),
      height: screenAwareSize(30.0, context),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFFFC3930) : Color(0xFF525663),
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: isSelected ? Colors.black.withOpacity(.5) : Colors.black12,
            offset: Offset(0.0, 10.0),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Center(
        child: Text(
          size,
          style: TextStyle(
            fontSize: screenAwareSize(10.0, context),
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

Widget divider() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    child: Container(
      width: 0.8,
      color: Colors.black,
    ),
  );
}

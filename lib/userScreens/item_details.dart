import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app_proj/dbModels/Store.dart';
import 'package:store_app_proj/dbModels/order.dart';
import 'package:store_app_proj/tools/app_db.dart';
import 'package:store_app_proj/userScreens/cart.dart';

class ItemDetail extends StatefulWidget {
  Store product;

  ItemDetail({
    this.product
  });

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
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
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Detail'),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            height: 300.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.product.itemImage),
                fit: BoxFit.fitHeight,
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(120.0),
                bottomLeft: Radius.circular(120.0),
              ),
            ),
          ),
          Container(
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(50),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(120.0),
                bottomLeft: Radius.circular(120.0),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Card(
                  child: Container(
                    width: screenSize.width,
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          widget.product.itemName,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.blue,
                                  size: 20.0,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  "${widget.product.itemRating}",
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                            Text(
                              "\$${widget.product.itemPrice}",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.red[500],
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    width: screenSize.width,
                    height: 150.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 5.0, right: 5.0),
                              height: 140.0,
                              width: 100.0,
                              child: Image.network(widget.product.itemImage),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0, right: 5.0),
                              height: 140.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withAlpha(50)),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    width: screenSize.width,
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(),
                          child: AnimatedCrossFade(
                            firstChild: Text(
                              widget.product.itemDesc,
                              maxLines: 2,
                            ),
                            secondChild: Text(
                              widget.product.itemDesc,
                            ),
                            crossFadeState: isExpanded
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            duration: kThemeAnimationDuration,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(),
                          child: GestureDetector(
                            onTap: _expand,
                            child: Text(
                              isExpanded ? "less" : "more...",
                              style: TextStyle(
                                color: Color(0xFFFB382F),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    width: screenSize.width,
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // SizedBox(
                        //   height: 10.0,
                        // ),
                        // Text(
                        //   "Sizes",
                        //   style: TextStyle(
                        //       fontSize: 18.0, fontWeight: FontWeight.w700),
                        // ),
                        // SizedBox(
                        //   height: 10.0,
                        // ),
                        // SizedBox(
                        //   height: 50.0,
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: widget.product.category.length,
                        //     itemBuilder: (context, index) {
                        //       return Padding(
                        //         padding: const EdgeInsets.all(4.0),
                        //         child: ChoiceChip(
                        //           label: Text("${widget.product.category[index]}"),
                        //           selected: currentSizeIndex == index,
                        //           onSelected: (bool selected) {
                        //             setState(() {
                        //               currentSizeIndex =
                        //                   selected ? index : null;
                        //             });
                        //           },
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Quantity",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  _decrease();
                                },
                                icon: Icon(Icons.remove),
                              ),
                            ),
                            Text(_counter.toString()),
                            CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  _increase();
                                },
                                icon: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (BuildContext context) {
                    return CartScreen();
                  },
                ),
              );
            },
            child: Icon(Icons.shopping_cart),
          ),
          CircleAvatar(
            radius: 10.0,
            backgroundColor: Colors.red,
            child: Text(
              '0',
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        elevation: 0.0,
        shape: CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: Container(
          height: 50.0,
          // decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: (screenSize.width - 20) / 2,
                child: Text(
                  "ADD TO FAVORITES",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                width: (screenSize.width - 20) / 2,
                child: GestureDetector(
                  onTap: () async {
                    await DBProvider(dbName: 'Cart').newDB(
                      Order(
                        order_product: widget.product,
                        order_quantity: _counter,
                      ),
                    );
                  },
                  child: Text(
                    "ORDER NOW",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app_proj/components/shopping_cart.dart';
import 'package:store_app_proj/dbModels/Store.dart';
import 'package:store_app_proj/tools/app_methods.dart';
import 'package:store_app_proj/tools/cart_bloc.dart';
import 'package:store_app_proj/tools/favorite_bloc.dart';
import 'package:store_app_proj/tools/firebase_methods.dart';

class ItemDetail extends StatefulWidget {
  Store product;

  ItemDetail({this.product});

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  AppMethods appMethod = FirebaseMethods();

  final CartBloc _cartBloc = new CartBloc();
  final FavoriteBloc _favoriteBloc = FavoriteBloc();
  bool isExpanded = false;
  int currentSizeIndex = 0;
  int _counter = 1;
  double price = 0;

  @override
  void initState() {
    super.initState();
    price = widget.product.itemPrice;
  }

  void _increase() {
    setState(() {
      _counter++;
      price = (widget.product.itemPrice * _counter);
    });
  }

  void _decrease() {
    setState(() {
      if (_counter > 1) _counter--;
      price = (widget.product.itemPrice * _counter);
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height * 0.73,
              // color: Colors.black,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Hero(
                        tag: widget.product.itemName,
                        child: Image.network(
                          widget.product.itemImage,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        widget.product.itemName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.teal),
                                borderRadius: BorderRadius.circular(50)),
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                  child: Icon(
                                    Icons.remove,
                                    size: 15,
                                    color: Colors.teal,
                                  ),
                                  onTap: _decrease,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    _counter.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  child: new Icon(
                                    Icons.add,
                                    size: 15,
                                    color: Colors.teal,
                                  ),
                                  onTap: _increase,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '\$${price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                              fontSize: 24,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'About the product',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              widget.product.itemDesc,
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Stack(
      //   alignment: Alignment.topCenter,
      //   children: <Widget>[
      //     Container(
      //       height: 300.0,
      //       decoration: BoxDecoration(
      //         image: DecorationImage(
      //           image: NetworkImage(widget.product.itemImage),
      //           fit: BoxFit.fitHeight,
      //         ),
      //         borderRadius: BorderRadius.only(
      //           bottomRight: Radius.circular(120.0),
      //           bottomLeft: Radius.circular(120.0),
      //         ),
      //       ),
      //     ),
      //     Container(
      //       height: 300.0,
      //       decoration: BoxDecoration(
      //         color: Colors.grey.withAlpha(50),
      //         borderRadius: BorderRadius.only(
      //           bottomRight: Radius.circular(120.0),
      //           bottomLeft: Radius.circular(120.0),
      //         ),
      //       ),
      //     ),
      //     SingleChildScrollView(
      //       child: Column(
      //         children: <Widget>[
      //           SizedBox(
      //             height: 50.0,
      //           ),
      //           Card(
      //             child: Container(
      //               width: screenSize.width,
      //               margin: EdgeInsets.only(left: 20.0, right: 20.0),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: <Widget>[
      //                   SizedBox(
      //                     height: 10.0,
      //                   ),
      //                   Text(
      //                     widget.product.itemName,
      //                     style: TextStyle(
      //                         fontSize: 18.0, fontWeight: FontWeight.w700),
      //                   ),
      //                   SizedBox(
      //                     height: 10.0,
      //                   ),
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: <Widget>[
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                         children: <Widget>[
      //                           Icon(
      //                             Icons.star,
      //                             color: Colors.blue,
      //                             size: 20.0,
      //                           ),
      //                           SizedBox(
      //                             width: 5.0,
      //                           ),
      //                           Text(
      //                             "${widget.product.itemRating}",
      //                             style: TextStyle(color: Colors.black),
      //                           )
      //                         ],
      //                       ),
      //                       Text(
      //                         "\$${widget.product.itemPrice}",
      //                         style: TextStyle(
      //                             fontSize: 20.0,
      //                             color: Colors.red[500],
      //                             fontWeight: FontWeight.w700),
      //                       ),
      //                     ],
      //                   ),
      //                   SizedBox(
      //                     height: 10.0,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //           Card(
      //             child: Container(
      //               width: screenSize.width,
      //               height: 150.0,
      //               child: ListView.builder(
      //                 scrollDirection: Axis.horizontal,
      //                 itemCount: 5,
      //                 itemBuilder: (context, index) {
      //                   return Stack(
      //                     alignment: Alignment.center,
      //                     children: <Widget>[
      //                       Container(
      //                         margin: EdgeInsets.only(left: 5.0, right: 5.0),
      //                         height: 140.0,
      //                         width: 100.0,
      //                         child: Image.network(widget.product.itemImage),
      //                       ),
      //                       Container(
      //                         margin: EdgeInsets.only(left: 5.0, right: 5.0),
      //                         height: 140.0,
      //                         width: 100.0,
      //                         decoration: BoxDecoration(
      //                             color: Colors.grey.withAlpha(50)),
      //                       ),
      //                     ],
      //                   );
      //                 },
      //               ),
      //             ),
      //           ),
      //           Card(
      //             child: Container(
      //               width: screenSize.width,
      //               margin: EdgeInsets.only(left: 20.0, right: 20.0),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: <Widget>[
      //                   SizedBox(
      //                     height: 10.0,
      //                   ),
      //                   Text(
      //                     "Description",
      //                     style: TextStyle(
      //                         fontSize: 18.0, fontWeight: FontWeight.w700),
      //                   ),
      //                   SizedBox(
      //                     height: 10.0,
      //                   ),
      //                   Padding(
      //                     padding: EdgeInsets.only(),
      //                     child: AnimatedCrossFade(
      //                       firstChild: Text(
      //                         widget.product.itemDesc,
      //                         maxLines: 2,
      //                       ),
      //                       secondChild: Text(
      //                         widget.product.itemDesc,
      //                       ),
      //                       crossFadeState: isExpanded
      //                           ? CrossFadeState.showSecond
      //                           : CrossFadeState.showFirst,
      //                       duration: kThemeAnimationDuration,
      //                     ),
      //                   ),
      //                   Padding(
      //                     padding: EdgeInsets.only(),
      //                     child: GestureDetector(
      //                       onTap: _expand,
      //                       child: Text(
      //                         isExpanded ? "less" : "more...",
      //                         style: TextStyle(
      //                           color: Color(0xFFFB382F),
      //                           fontWeight: FontWeight.w700,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                   SizedBox(
      //                     height: 10.0,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //           Card(
      //             child: Container(
      //               width: screenSize.width,
      //               margin: EdgeInsets.only(left: 20.0, right: 20.0),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: <Widget>[
      //                   // SizedBox(
      //                   //   height: 10.0,
      //                   // ),
      //                   // Text(
      //                   //   "Sizes",
      //                   //   style: TextStyle(
      //                   //       fontSize: 18.0, fontWeight: FontWeight.w700),
      //                   // ),
      //                   // SizedBox(
      //                   //   height: 10.0,
      //                   // ),
      //                   // SizedBox(
      //                   //   height: 50.0,
      //                   //   child: ListView.builder(
      //                   //     scrollDirection: Axis.horizontal,
      //                   //     itemCount: widget.product.category.length,
      //                   //     itemBuilder: (context, index) {
      //                   //       return Padding(
      //                   //         padding: const EdgeInsets.all(4.0),
      //                   //         child: ChoiceChip(
      //                   //           label: Text("${widget.product.category[index]}"),
      //                   //           selected: currentSizeIndex == index,
      //                   //           onSelected: (bool selected) {
      //                   //             setState(() {
      //                   //               currentSizeIndex =
      //                   //                   selected ? index : null;
      //                   //             });
      //                   //           },
      //                   //         ),
      //                   //       );
      //                   //     },
      //                   //   ),
      //                   // ),
      //                   SizedBox(
      //                     height: 10.0,
      //                   ),
      //                   Text(
      //                     "Quantity",
      //                     style: TextStyle(
      //                         fontSize: 18.0, fontWeight: FontWeight.w700),
      //                   ),
      //                   SizedBox(
      //                     height: 10.0,
      //                   ),
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                     children: <Widget>[
      //                       CircleAvatar(
      //                         child: IconButton(
      //                           onPressed: () {
      //                             _decrease();
      //                           },
      //                           icon: Icon(Icons.remove),
      //                         ),
      //                       ),
      //                       Text(_counter.toString()),
      //                       CircleAvatar(
      //                         child: IconButton(
      //                           onPressed: () {
      //                             _increase();
      //                           },
      //                           icon: Icon(Icons.add),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   SizedBox(
      //                     height: 50.0,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     )
      //   ],
      // ),
      floatingActionButton: ShoppingCart(),
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
                child: GestureDetector(
                  onTap: () {
                    _favoriteBloc.addProductToFavorite(widget.product);
                  },
                  child: Text(
                    "ADD TO FAVORITES",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Container(
                width: (screenSize.width - 20) / 2,
                child: GestureDetector(
                  onTap: () async {
                    _cartBloc.addOrderToCart(widget.product, _counter);
                    Navigator.pop(context);
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

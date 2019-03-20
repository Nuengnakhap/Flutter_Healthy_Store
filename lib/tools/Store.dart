import 'package:flutter/material.dart';

class Store {
  String itemName;
  double itemPrice;
  String itemImage;
  double itemRating;
  String itemDesc;
  List<String> sizeList;

  Store.items({
    this.itemName,
    this.itemPrice,
    this.itemImage,
    this.itemRating,
    this.itemDesc,
    this.sizeList,
  });
}

List<Store> storeItems = [
  Store.items(
    itemName: 'FORCHY BROWNIE PURE BUTTER 170 G',
    itemPrice: 2500.00,
    itemImage: "https://goo.gl/yhZbVV",
    itemRating: 0.0,
    itemDesc: '''
A tasty recipe pure butter and cane sugar with a fine touch of naturel sea salt.

Main ingredients
Cane sugar - eggs - butter - chocolate chips - chocolate - wheat flour - soya flour - cocoa powder - sea salt

Contains following allergen(s)
Eggs, milk, soya and wheat

May contain following allergen(s)
Nuts
    ''',
    sizeList: ['25G', '50G', '75G'],
  ),
  Store.items(
    itemName: 'FORCHY CARAMEL BROWNIE 285 G',
    itemPrice: 2400.00,
    itemImage: "https://goo.gl/TY8VTE",
    itemRating: 0.0,
    itemDesc: '''
Chocolate and salted butter caramel With delicious salted butter caramel from Normandy.

Main ingredients
Sugar - eggs - canola oil - chocolate - chocolate chips - wheat flour - caramel with salted butter.

Contains following allergen(s)
Eggs, milk, soya and wheat.

May contain following allergen(s)
Nuts.
      ''',
    sizeList: ['25G', '50G', '75G'],
  ),
  Store.items(
    itemName: 'FORCHY HAZELNUT BROWNIE 285 G',
    itemPrice: 2300.00,
    itemImage: "https://goo.gl/uZygLD",
    itemRating: 0.0,
    itemDesc: '''
Chocolate and hazelnuts.
The mix of chocolate and hazelnuts.

Main ingredients
Sugar - eggs - canola oil - chocolate - wheat flour - chocolate chips - hazelnuts

Contains following allergen(s)
Wheat, eggs, nuts, milk and soya.
      ''',
    sizeList: ['25G', '50G', '75G'],
  ),
  Store.items(
    itemName: 'FORCHY SPECULOOS BROWNIE 285 G',
    itemPrice: 2200.00,
    itemImage: "https://goo.gl/fo76Pz",
    itemRating: 0.0,
    itemDesc: '''
Chocolate and speculoos
With famous Speculoos from Belgium.

Main ingredients
Sugar - eggs - canola oil - chocolate chips - chocolate - wheat flour - caramelised biscuit.

Contains following allergen(s)
Wheat, milk, eggs and soya.

May contain following allergen(s)
Nuts
      ''',
    sizeList: ['25G', '50G', '75G'],
  ),
];

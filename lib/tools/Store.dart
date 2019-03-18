import 'package:flutter/material.dart';

class Store {
  String itemName;
  double itemPrice;
  String itemImage;
  double itemRating;

  Store.items({
    this.itemName,
    this.itemPrice,
    this.itemImage,
    this.itemRating
  });
}

List<Store> storeItems = [
  Store.items(
    itemName: 'FORCHY BROWNIE PURE BUTTER 170 G',
    itemPrice: 2500.00,
    itemImage: "https://goo.gl/yhZbVV",
    itemRating: 0.0
  ),
  Store.items(
    itemName: 'FORCHY CARAMEL BROWNIE 285 G',
    itemPrice: 2400.00,
    itemImage: "https://goo.gl/TY8VTE",
    itemRating: 0.0
  ),
  Store.items(
    itemName: 'FORCHY HAZELNUT BROWNIE 285 G',
    itemPrice: 2300.00,
    itemImage: "https://goo.gl/uZygLD",
    itemRating: 0.0
  ),
  Store.items(
    itemName: 'FORCHY SPECULOOS BROWNIE 285 G',
    itemPrice: 2200.00,
    itemImage: "https://goo.gl/fo76Pz",
    itemRating: 0.0
  ),
  
];
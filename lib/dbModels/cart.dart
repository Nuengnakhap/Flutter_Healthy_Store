import 'dart:async';

import 'package:store_app_proj/dbModels/client.dart';
import 'package:store_app_proj/dbModels/order.dart';
import 'package:store_app_proj/tools/app_db.dart';
import 'package:store_app_proj/tools/app_methods.dart';
import 'package:store_app_proj/tools/firebase_methods.dart';

class Cart {
  List<Order> _orders;
  AppMethods appMethod = FirebaseMethods();

  Cart() {
    _orders = List();
    fetchCart();
  }

  Future fetchCart() async {
    List dd = await DBProvider(dbName: 'Cart').getAllDB();
    for (var item in dd) {
      _orders.add(item);
    }
  }

  void addOrder(Order order) {
    _orders.add(order);
  }

  void removeOrder(Order order) {
    _orders.remove(order);
  }

  void removeAllOrder() async {
    Client _client = await DBProvider(dbName: 'Client').getLasted();
    await appMethod.setOrderHistory(order: _orders, userID: _client.userUID);
    _orders.clear();
  }

  void clearCart() {
    _orders.clear();
  }

  void updateOrder(Order order) {
    for (var item in _orders) {
      if (item.id == order.id) {
        item.order_quantity = order.order_quantity;
      }
    }
  }

  double totalPrice() {
    double total = 0;
    _orders.forEach((o) {
      total += o.orderPrice;
    });

    return total;
  }

  List<Order> get orders => _orders;

  int get orderCount => _orders.length;

  bool get isEmpty => _orders.length == 0;
}

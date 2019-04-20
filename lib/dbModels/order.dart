import 'package:store_app_proj/dbModels/Store.dart';
import 'package:store_app_proj/tools/app_data.dart';

class Order {
  Store order_product;
  int order_quantity;
  int order_id;

  Order({this.order_product, this.order_quantity, this.order_id});
  String pname;
  int get id => order_id;

  int get quantity => order_quantity;

  Store get product => order_product;

  double get orderPrice => order_quantity * order_product.itemPrice;

  factory Order.fromMap(Map<String, dynamic> json) {
    Store _p = Store.items(
      itemName: json[c_pro_name],
      itemPrice: json[c_pro_price],
      itemImage: json[c_pro_image],
      itemRating: json[c_pro_rating],
      itemDesc: json[c_pro_desc],
    );
    return Order(
      order_id: json['id'],
      order_product: _p,
      order_quantity: json[c_pro_quantity],
    );
  }

  Map<String, dynamic> toMap() => {
        c_pro_name: order_product.itemName,
        c_pro_price: order_product.itemPrice,
        c_pro_image: order_product.itemImage,
        c_pro_rating: order_product.itemRating,
        c_pro_desc: order_product.itemDesc,
        c_pro_quantity: order_quantity,
      };
}

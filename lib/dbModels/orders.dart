import 'package:store_app_proj/dbModels/order.dart';

class Orders {
  List<Order> lstOrd;
  int id;
  double price = 0;
  String user;

  Orders({this.lstOrd, this.id, this.user});


  // factory Orders.fromMap(Map<String, dynamic> json) {
  //   Store _p = Store.items(
  //     itemName: json[c_pro_name],
  //     itemPrice: json[c_pro_price],
  //     itemImage: json[c_pro_image],
  //     itemRating: json[c_pro_rating],
  //     itemDesc: json[c_pro_desc],
  //   );
  //   return Orders(
  //     id: json['id'],
  //     order_product: _p,
  //     order_quantity: json[c_pro_quantity],
  //   );
  // }

  Map<String, dynamic> toMap() {
    lstOrd.forEach((f) {
      price += (f.order_product.itemPrice * f.order_quantity);
    });
    return  {
      'items_id': lstOrd.toString(),
      'total_price': price,
      'userID': user,
    };
  }
}

import 'package:store_app_proj/tools/app_data.dart';

class Cart {
  int id;
  String cartName;
  double cartPrice;
  String cartImage;
  String cartRating;
  String cartDesc;
  int cartQuantity;
  
  static String cmdInitDB = "CREATE TABLE Cart("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "$c_pro_name TEXT,"
          "$c_pro_price DOUBLE,"
          "$c_pro_image TEXT,"
          "$c_pro_rating TEXT,"
          "$c_pro_desc TEXT,"
          "$c_pro_quantity INTEGER"
          ")";

  Cart({
    this.id,
    this.cartName,
    this.cartPrice,
    this.cartImage,
    this.cartRating,
    this.cartDesc,
    this.cartQuantity,
  });

  factory Cart.fromMap(Map<String, dynamic> json) => new Cart(
        id: json['id'],
        cartName: json[c_pro_name],
        cartPrice: json[c_pro_price],
        cartImage: json[c_pro_image],
        cartRating: json[c_pro_rating],
        cartDesc: json[c_pro_desc],
        cartQuantity: json[c_pro_quantity],
      );

  Map<String, dynamic> toMap() => {
        c_pro_name: cartName,
        c_pro_price: cartPrice,
        c_pro_image: cartImage,
        c_pro_rating: cartRating,
        c_pro_desc: cartDesc,
        c_pro_quantity: cartQuantity,
      };
}
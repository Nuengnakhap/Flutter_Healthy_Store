import 'package:rxdart/rxdart.dart';
import 'package:store_app_proj/dbModels/Store.dart';
import 'package:store_app_proj/dbModels/cart.dart';
import 'package:store_app_proj/dbModels/order.dart';
import 'package:store_app_proj/tools/app_db.dart';

class CartBloc {
  static int _orderId = 0;
  static CartBloc _cartBloc;
  Cart _currentCart;
  Order _lastOrder;
  PublishSubject<Cart> _publishSubjectCart;
  PublishSubject<Order> _publishSubjectOrder;

  factory CartBloc() {
    if (_cartBloc == null) _cartBloc = new CartBloc._();

    return _cartBloc;
  }

  CartBloc._() {
    _currentCart = new Cart();
    _publishSubjectCart = new PublishSubject<Cart>();
    _publishSubjectOrder = new PublishSubject<Order>();
  }

  Observable<Cart> get observableCart => _publishSubjectCart.stream;
  Observable<Order> get observableLastOrder => _publishSubjectOrder.stream;

  void _updateCart() {
    _publishSubjectCart.sink.add(_currentCart);
  }

  void _updateLastOrder() {
    _publishSubjectOrder.sink.add(_lastOrder);
  }

  void addOrderToCart(Store product, int quantity) async {
    _lastOrder = Order(
      order_product: product,
      order_quantity: quantity,
      id: _orderId++,
    );
    _currentCart.addOrder(_lastOrder);
    await DBProvider(dbName: 'Cart').newDB(
      Order(
        order_product: product,
        order_quantity: quantity,
      ),
    );
    _updateLastOrder();
    _updateCart();
  }

  void removerOrderOfCart(Order order) async {
    _currentCart.removeOrder(order);
    await DBProvider(dbName: 'Cart').deleteDB(
      Order(
        id: order.id,
        order_product: order.order_product,
        order_quantity: order.order_quantity,
      ),
    );
    _updateCart();
  }

  void removeAllOrder() async {
    _currentCart.removeAllOreder();
    await DBProvider(dbName: 'Cart').deleteAll();
    _updateCart();
  }

  void updateOrderOfCart(Order order) async {
    _currentCart.updateOrder(order);
    await DBProvider(dbName: 'Cart').updateDB(
      Order(
        id: order.id,
        order_product: order.order_product,
        order_quantity: order.order_quantity,
      ),
    );
    _updateCart();
  }

  Cart get currentCart => _currentCart;

  Order get lastOrder => _lastOrder;

  dispose() {
    _cartBloc = null;
    _publishSubjectCart.close();
    _publishSubjectOrder.close();
  }
}

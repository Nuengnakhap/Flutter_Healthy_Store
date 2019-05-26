import 'package:rxdart/rxdart.dart';
import 'package:store_app_proj/dbModels/Store.dart';
import 'package:store_app_proj/dbModels/cart.dart';
import 'package:store_app_proj/dbModels/favorite.dart';
import 'package:store_app_proj/dbModels/order.dart';
import 'package:store_app_proj/tools/app_db.dart';
import 'package:store_app_proj/tools/app_methods.dart';
import 'package:store_app_proj/tools/firebase_methods.dart';

class FavoriteBloc {
  static FavoriteBloc _favoriteBloc;
  Favorite _currentFavorite;
  Store _lastProduct;
  PublishSubject<Favorite> _publishSubjectFav;
  PublishSubject<Store> _publishSubjectProduct;
  AppMethods appMethod = FirebaseMethods();

  factory FavoriteBloc() {
    if (_favoriteBloc == null) _favoriteBloc = new FavoriteBloc._();

    return _favoriteBloc;
  }

  FavoriteBloc._() {
    _currentFavorite = new Favorite();
    _publishSubjectFav = new PublishSubject<Favorite>();
    _publishSubjectProduct = new PublishSubject<Store>();
  }

  Observable<Favorite> get observableFavorite => _publishSubjectFav.stream;
  Observable<Store> get observableLastStore => _publishSubjectProduct.stream;

  void _updateFavorite() {
    _publishSubjectFav.sink.add(_currentFavorite);
  }

  void _updateLastProduct() {
    _publishSubjectProduct.sink.add(_lastProduct);
  }

  void addProductToFavorite(Store product) async {
    _lastProduct = Store.items(
      itemName: product.itemName,
      itemImage: product.itemImage,
      itemPrice: product.itemPrice,
      itemDesc: product.itemDesc,
      itemRating: product.itemRating
    );
    _currentFavorite.addProduct(_lastProduct);

    _updateLastProduct();
    _updateFavorite();
  }

  void removeProductofFav(Store product) async {
    _currentFavorite.removeProduct(product);
    _updateFavorite();
    await appMethod.removeFavorite(product);
  }

  void removeAllProduct() async {
    _currentFavorite.removeAllProduct();
    _updateFavorite();
  }

  void clearFavorite() async {
    _currentFavorite.clearFavorite();
    _updateFavorite();
  }

  Favorite get currentFavorite => _currentFavorite;

  Store get lastProduct => _lastProduct;

  dispose() {
    _favoriteBloc = null;
    _publishSubjectFav.close();
    _publishSubjectProduct.close();
  }
}

import 'package:flutter/material.dart';
import 'package:user_app/data/model/product_model.dart';

class CartProvider extends ChangeNotifier {
  List<ProductModel> cartItems = [];

  List<ProductModel> get cartItemsList => cartItems;

  int get cartItemCount => cartItems.length;

  void addToCart(ProductModel item) {
    cartItems.add(item);
    notifyListeners();
  }

  void removeFromCart(ProductModel item) {
    cartItems.remove(item);
    notifyListeners();
  }

  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/wishlist_model.dart';

class WishlistProvider with ChangeNotifier {
  Map<String, ViewedProdModel> _wishlistItems = {};

  Map<String, ViewedProdModel> get getWishlistItems {
    return _wishlistItems;
  }

  void addRemoveProductsToWishlist({
    required String productId,
  }) {
    if (_wishlistItems.containsKey(productId)) {
      removeOneItem(productId);
    } else {
      _wishlistItems.putIfAbsent(
          productId,
          () => ViewedProdModel(
              id: DateTime.now().toString(), productId: productId));
    }
    notifyListeners();
  }

  void removeOneItem(String productId) {
    _wishlistItems.remove(productId);
    notifyListeners();
  }

  void clearWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}

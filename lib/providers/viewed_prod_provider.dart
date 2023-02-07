import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/wishlist_model.dart';

class ViewedProdProvider with ChangeNotifier {
  Map<String, ViewedProdModel> _viewedProdlistItems = {};

  Map<String, ViewedProdModel> get getViewedProdlistItems {
    return _viewedProdlistItems;
  }

  void addProductToHistory({required String productId}) {
    _viewedProdlistItems.putIfAbsent(
        productId,
        () => ViewedProdModel(
            id: DateTime.now().toString(), productId: productId));

    notifyListeners();
  }

  void clearHistory() {
    _viewedProdlistItems.clear();
    notifyListeners();
  }
}

// class ViewedProdProvider with ChangeNotifier {
//   Map<String, ViewedProdModel> _viewedProdListItems = {};

//   Map<String, ViewedProdModel> get getViewedProdListItems {
//     return _viewedProdListItems;
//   }

//   void addProductsToHistory({
//     required String productId,
//   }) {
//     _viewedProdListItems.putIfAbsent(
//         productId,
//         () => ViewedProdModel(
//             id: DateTime.now().toString(), productId: productId));

//     notifyListeners();
//   }

//   void clearHistory() {
//     _viewedProdListItems.clear();
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';

class ProviderFav with ChangeNotifier {
  List<dynamic> favProducts = [];

  void addProductToFav(List<dynamic> productfav) {
    favProducts.add(productfav);
    notifyListeners();
  }

  void removeProductToFav(List<dynamic> productfav) {
    favProducts.remove(productfav);
    notifyListeners();
  }
}

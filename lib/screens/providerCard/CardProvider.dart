// import 'package:flutter/foundation.dart';

// class ProviderCart extends ChangeNotifier {
//   ///The data
//   // CatalogModel catalog = CatalogModel();

//   /// List of items in the cart.
//   List<String> itemsCard = [];

//   /// The current total price of all items.
//   int get totalPrice => itemsCard.length * 42;

//   bool isLoading = false;

//   /// Adds [item] to cart. This is the only way to modify the cart from outside.
//   void add(String item) {
//     itemsCard.add(item);
//     notifyListeners();
//   }

//   void clearAll() async {
//     isLoading = true;
//     notifyListeners();
//     await Future.delayed(const Duration(seconds: 1));
//     itemsCard.clear();
//     isLoading = false;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';

class ProviderCart with ChangeNotifier {
  List<dynamic> cartProducts = [];

  void addProductToCart(List<dynamic> product) {
    cartProducts.add(product);
    notifyListeners();
  }

  // bool isProductInCart(String productId) {
  //   return cartProducts.any((product) => product['id'] == productId);
  // }
}




// void addProductToCart(List<dynamic> product) {
  //   // تأكد من أن product يحتوي على id
  //   var existingProduct = cartProducts.firstWhere(
  //     (item) => item['id'] == product[0],
  //     orElse: () => null,
  //   );

  //   if (existingProduct != null) {
  //     // المنتج موجود بالفعل, قم بإظهار رسالة إلى المستخدم
  //     print('المنتج موجود بالفعل في سلة التسوق');
  //   } else {
  //     // المنتج غير موجود, قم بإضافته إلى السلة
  //     cartProducts.add(product);
  //     print('تم إضافة المنتج إلى سلة التسوق');
  //     notifyListeners();
  //   }
  // }
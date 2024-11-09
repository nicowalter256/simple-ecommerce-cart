import 'package:flutter/material.dart';

import '../views/custom_snackbar.dart';

class ProductController extends ChangeNotifier {
  int cartCount = 0;
  int subTotal = 0;

  List<Map<String, dynamic>> cartItems = [];

  int cost = 1;
  List<Map<String, dynamic>> products = [
    {
      "name": "Shoes",
      "quantity": 5,
      "description": "Best shoes",
      "price": "2000",
      "incart": true,
      "image":
          "https://cdn.pixabay.com/photo/2021/03/08/12/31/oxford-shoes-6078993_1280.jpg"
    },
    {
      "name": "Chocolate",
      "quantity": 2,
      "description": "Best Chocolate",
      "price": "4000",
      "incart": false,
      "image":
          "https://cdn.pixabay.com/photo/2023/12/18/11/05/chocolate-8455786_1280.jpg"
    },
  ];

  void calculateSubtotal() async {
    subTotal = 0;
    for (var e in products) {
      int cartPrice = 0;

      cartPrice += int.parse('${e['price']}');

      cartPrice *= int.parse(e['quantity']);

      subTotal += cartPrice;
    }
  }

  void removeFromCart(dynamic item) async {
    try {
      cartItems.removeWhere((element) => element == item);
    } catch (err) {}

    notifyListeners();
  }

  void increaseCount() async {
    try {
      cartCount += 1;
    } catch (err) {}
    notifyListeners();
  }

  void descreaseCount() async {
    try {
      cartCount -= 1;
    } catch (err) {}

    notifyListeners();
  }

  void addToCart(dynamic item) {
    var product = products.where((i) => i['name'] == item['name']).first;
    product['incart'] = true;
    if (!cartItems.contains(product)) {
      cartItems.add(product);
      cartCount = cartItems.length;
      CustomSnackBar.success("Product added to cart");
    } else {
      CustomSnackBar.error("Product already exists in cart");
    }

    notifyListeners();
  }
}

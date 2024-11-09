import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:simplecommerce/views/cart_page.dart';

import '../controller/products_controller.dart';

class ShoppingCartButtonWidget extends StatelessWidget {
  final Color iconColor;
  final Color labelColor;
  const ShoppingCartButtonWidget({
    required this.iconColor,
    required this.labelColor,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(
      builder: (_, model, child) {
        return MaterialButton(
          elevation: 0,
          onPressed: () {
            Get.to(
              CartScreen(
                cartItems: model.cartItems,
              ),
            );
          },
          color: Colors.transparent,
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: <Widget>[
              Icon(
                Icons.shopping_cart_outlined,
                color: iconColor,
                size: 28,
              ),
              Container(
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                    color: labelColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                constraints: const BoxConstraints(
                    minWidth: 15, maxWidth: 15, minHeight: 15, maxHeight: 15),
                child: Text(
                  model.cartCount.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplecommerce/views/cart_items.dart';
import '../controller/products_controller.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  const CartScreen({super.key, required this.cartItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ProductController productController = ProductController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    productController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider.value(
        value: productController,
        child: Consumer<ProductController>(
          builder: (_, model, child) {
            if (widget.cartItems.isEmpty) {
              return const Center(
                child: Text(
                  "No Cart Items found",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            return ListView.separated(
                itemBuilder: (ctx, index) {
                  if (index <= widget.cartItems.length) {
                    return CartItemWidget(
                      item: widget.cartItems[index],
                    );
                  } else {
                    return Column(
                      children: [
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Subtotal: ',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            // Text("$subTotal"),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 250,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                              // style:
                              //     Theme.of(context).elevatedButtonTheme.style,
                              onPressed: () {},
                              child: const Text(
                                'Checkout',
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    );
                  }
                },
                separatorBuilder: (ctx, index) {
                  return const SizedBox(
                    height: 5,
                  );
                },
                itemCount: widget.cartItems.length);
          },
        ),
      ),
    );
  }
}

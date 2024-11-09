import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

import '../constants.dart';
import '../controller/products_controller.dart';

class CartItemWidget extends StatefulWidget {
  final dynamic item;
  const CartItemWidget({super.key, required this.item});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  ProductController cartController = ProductController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartController,
      child: Consumer<ProductController>(
        builder: (_, model, child) {
          return InkWell(
            highlightColor: Colors.transparent,
            splashColor: Theme.of(context).focusColor.withOpacity(0.08),
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).focusColor.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.item['image']),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    ReCase('${widget.item['image']}').titleCase,
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              'Ugx',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Constants.blackBG,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          model.removeFromCart(widget.item);
                        },
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(
                            const BorderSide(color: Constants.blackBG),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text('Remove'),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: <Widget>[
                      //     IconButton(
                      //       onPressed: () {
                      //         context
                      //             .read<ProductController>()
                      //             .decrementQuantity(widget.item);
                      //       },
                      //       iconSize: 40,
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 5, vertical: 10),
                      //       icon: const Icon(Icons.remove_circle_outline),
                      //     ),
                      //     Text(
                      //       widget.item['quantity'].toString(),
                      //     ),
                      //     IconButton(
                      //       onPressed: () {
                      //         // model.incrementQuantity(widget.item);
                      //         context
                      //             .read<ProductController>()
                      //             .incrementQuantity(widget.item);
                      //       },
                      //       iconSize: 40,
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 5, vertical: 10),
                      //       icon: const Icon(Icons.add_circle_outline),
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

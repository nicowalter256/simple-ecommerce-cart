import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplecommerce/constants.dart';
import 'package:simplecommerce/views/products.dart';

import '../controller/products_controller.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ProductController productController = ProductController();
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: productController,
      child: Consumer<ProductController>(
        builder: (_, model, child) {
          return Scaffold(
            key: scafoldKey,
            appBar: AppBar(
              backgroundColor: Constants.blackBG,
              leading: IconButton(
                onPressed: () => {
                  scafoldKey.currentState!.openDrawer(),
                },
                icon: const Icon(
                  Icons.menu,
                  color: Constants.whiteBG,
                ),
              ),
              title: const Text(
                'Products',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Constants.whiteBG),
              ),
            ),
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
              child: Column(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 9),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Constants.blackBG),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.search_rounded,
                            color: Constants.blackBG,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Flexible(
                              child: Text(
                            'Search products',
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: Theme.of(context).textTheme.bodySmall!.merge(
                                TextStyle(color: Theme.of(context).hintColor)),
                          )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Products(
                    products: model.products,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

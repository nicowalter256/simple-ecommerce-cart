import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';
import 'package:simplecommerce/constants.dart';
import 'package:simplecommerce/views/cart_page.dart';
import 'package:simplecommerce/views/shopping_cart.dart';

import '../controller/products_controller.dart';

class ProductDetails extends StatefulWidget {
  final dynamic product;
  const ProductDetails({super.key, required this.product});
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductController productController = ProductController();
  // CartController cartController = CartController();
  int currentIndex = 0;

  @override
  void initState() {
    //cartController.getCartCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: productController,
      child: Consumer<ProductController>(builder: (_, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 60),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      //backgroundColor:
                      //    Theme.of(context).accentColor.withOpacity(0.9),
                      expandedHeight: 275,
                      elevation: 0,
                      actions: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Constants.greyBG,
                          ),
                          child: const Center(
                            child: ShoppingCartButtonWidget(
                              iconColor: Colors.white,
                              labelColor: Colors.green,
                            ),
                          ),
                        ),
                      ],
                      leading: GestureDetector(
                        onTap: () {
                          Get.close(1);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              color: Constants.blackBG, shape: BoxShape.circle),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),

                      primary: true,
                      iconTheme: const IconThemeData(color: Colors.white),
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: <Widget>[
                            CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 7),
                                height: 300,
                                viewportFraction: 1.0,
                                onPageChanged: (current, reason) {
                                  setState(() {
                                    currentIndex = current;
                                  });
                                },
                              ),
                              items: List.generate(
                                  1,
                                  (index) => Builder(
                                        builder: (BuildContext context) {
                                          return CachedNetworkImage(
                                            progressIndicatorBuilder:
                                                (context, url, progress) =>
                                                    Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                value: progress.progress,
                                              ),
                                            ),
                                            imageUrl: widget.product['image'],
                                            fit: BoxFit.contain,
                                          );
                                        },
                                      )),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(1, (index) {
                                return Container(
                                  width: 20.0,
                                  height: 5.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 2.0),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      color: currentIndex == index
                                          ? Theme.of(context).canvasColor
                                          : Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.4)),
                                );
                              }).toList(),
                            ),
                            // Positioned(
                            //   top: MediaQuery.of(context).padding.top + 20,
                            //   right: 5,
                            //   child: GestureDetector(
                            //     onTap: () {},
                            //     child: Container(
                            //       padding: EdgeInsets.all(5),
                            //       decoration: BoxDecoration(
                            //           shape: BoxShape.circle,
                            //           color: Theme.of(context)
                            //               .colorScheme
                            //               .primary),
                            //       child: model.loadCart
                            //           ? SizedBox(
                            //               width: 60,
                            //               height: 60,
                            //               child: RefreshProgressIndicator(),
                            //             )
                            //           : Center(
                            //               child: ShoppingCartButtonWidget(
                            //                 iconColor: Colors.white,
                            //                 labelColor: Colors.green,
                            //               ),
                            //             ),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(15),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Text(ReCase('${widget.product['name']}').titleCase,
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.titleLarge
                                //.copyWith(color: Colors.white),
                                ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("Quantity: ${widget.product['quantity']}",
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.titleLarge
                                //  .copyWith(color: Color(0xffE7FF0D)),
                                ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${widget.product['description']}',
                            ),
                            Text(
                              '${widget.product['price']}',
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  height: 60,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            model.addToCart(widget.product);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Constants.greenBG,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              textStyle: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(color: Constants.whiteBG),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:simplecommerce/constants.dart';

import '../controller/products_controller.dart';
// ignore: depend_on_referenced_packages

class PaymentMethod extends StatefulWidget {
  final double amount;
  PaymentMethod({
    Key? key,
    required this.amount,
  }) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  ProductController productController = ProductController();
  double subTotal = 0.0;

  dynamic paymentType = {};

  List<Map<String, dynamic>> paymentMethods = [
    {
      "name": "Mobile money",
    },
    {
      "name": "Card money",
    }
  ];
  // double calculateAddOns() {
  //   for (var e in widget.selectedAddons) {
  //     subTotal += double.parse(e.price);
  //   }
  //   return subTotal;
  // }

  GlobalKey<ScaffoldState> scafoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    //calculateAddOns();
    //paymentController.init();
  }

  //PaymentType paymentType;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: productController,
      child: Consumer<ProductController>(
        builder: (_, model, child) {
          return Scaffold(
            key: scafoldKey,
            backgroundColor: Colors.black,
            body: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Payment methods',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Choose Payment",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(color: Colors.blue),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        top: 15,
                        child: Container(
                          color: Constants.whiteBG,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 20,
                        left: 20,
                        child: SizedBox(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: paymentMethods.length,
                              itemBuilder: (context, index) {
                                var type = paymentMethods[index];
                                return GestureDetector(
                                  onTap: () => {
                                    setState(() {
                                      paymentType = type;
                                    })
                                  },
                                  child: Card(
                                    child: Container(
                                      height: 80,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 25, top: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  type['name'],
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 17),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 25),
                                            child: paymentType == type
                                                ? Icon(
                                                    Icons.check,
                                                    size: 30,
                                                    color: Colors.black,
                                                  )
                                                : const Text(''),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

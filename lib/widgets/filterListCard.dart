// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:annadata/Model/productModel.dart';
import 'package:annadata/screens/product_Page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../env.dart';

class ProductListCard extends StatefulWidget {
  ProductListCard(
      {Key? key, required this.products,
      this.product_count})
      : super(key: key);

  String? product_count;
  List<ProductData> products = <ProductData>[];
  @override
  State<ProductListCard> createState() => _ProductListCardState();
}

class _ProductListCardState extends State<ProductListCard> {
  String product_id = "";


  bool isLoading = false;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: (isLoading)
          ? Shimmer.fromColors(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (_, __) {
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(children: [
                              Container(
                                height: 100,
                                width: 100,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 18,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    height: 15,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    height: 40,
                                    color: Colors.white,
                                  ),
                                ],
                              )
                            ]),
                          ),
                        ));
                  }),
              baseColor: Colors.white,
              highlightColor: Colors.grey.shade300)
          : ((widget.products.isEmpty)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.asset(
                        "assets/no_products_found.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "No Ads Found",
                      style:
                          TextStyle(fontFamily: 'Rubik Regular', fontSize: 18),
                    ),
                  ],
                )
              : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.products.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: InkWell(
                        onTap: () {
                          var product_id_temp =
                              widget.products[index].productId.toString();
                          setState(() {
                            product_id = product_id_temp;
                          });
                          // debugPrint("Product ID");
                          // debugPrint(product_id);
                          // Navigator.pushNamed(context, 'productPage');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductPage(product_id: product_id),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.network(
                                            widget.products[index]
                                                .productImg
                                                .toString(),
                                            errorBuilder:
                                                (context, error, stacktrace) =>
                                                    Image.asset(
                                              "assets/Logo-modified.png",
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Positioned(
                                              left: 0,
                                              top: 5,
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(2),
                                                //color: Colors.orange,
                                                //height: 20,
                                                // width: 35,
                                                decoration: const BoxDecoration(
                                                    color: Colors.orange,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topRight:
                                                                const Radius
                                                                    .circular(
                                                                    5),
                                                            bottomRight:
                                                                const Radius
                                                                    .circular(
                                                                    5))),
                                                child: Text(
                                                  widget.products[index]
                                                      .mdfDt
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ),
                                              ))
                                        ],
                                      )),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(
                                    //     width:
                                    //         MediaQuery.of(context).size.width / 2,
                                    //     child: const Text(
                                    //       "Post on: 14/06/2022",
                                    //       style: TextStyle(fontSize: 10),
                                    //       textAlign: TextAlign.end,
                                    //     )),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      // width: 250,
                                      child: Text(
                                        widget.products[index].productTitle.toString(),
                                        // maxLines: 3,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          "Quantity : ",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        Text(
                                            widget.products[index]
                                                .productQuantity
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                        Text(
                                            widget.products[index].unitName.toString(),
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.2,
                                      height: 35,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            var product_id_temp =
                                                widget.products[index]
                                                    .productId
                                                    .toString();
                                            setState(() {
                                              product_id = product_id_temp;
                                            });

                                            // debugPrint("Product ID");
                                            // debugPrint(product_id);
                                            // Navigator.pushNamed(context, 'productPage');
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductPage(
                                                        product_id: product_id),
                                              ),
                                            );
                                          },
                                          child: const Text("Contact Farmer")),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })),
    );
  }

}

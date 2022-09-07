// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:annadata/Model/productModel.dart';
import 'package:annadata/screens/product_Page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../Test/no_data_found.dart';

class ProductListCard extends StatefulWidget {
  ProductListCard({Key? key, required this.cat_id, required this.sub_id})
      : super(key: key);

  String cat_id = "";
  String? sub_id;

  @override
  State<ProductListCard> createState() => _ProductListCardState();
}

class _ProductListCardState extends State<ProductListCard> {
  String product_id = "";
  String CatId_param = "";
  String? SubId_param;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<ProductData>?>(
          future: getProduct(),
          builder: (context, snapShot) {
            if (!snapShot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            // else {
            //   return NoDataFound()
            // }
            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: snapShot.data!.length,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: InkWell(
                    onTap: () {
                      var product_id_temp =
                          snapShot.data![index].productId.toString();
                      setState(() {
                        product_id = product_id_temp;
                      });
                      debugPrint("Product ID");
                      debugPrint(product_id);
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
                                    children: [
                                      Image.network(
                                        snapShot.data![index].productImg
                                            .toString(),
                                        errorBuilder:
                                            (context, error, stacktrace) =>
                                                Image.asset(
                                          "assets/Logo-modified.png",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Positioned(
                                          top: 5,
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(2),
                                            //color: Colors.orange,
                                            //height: 20,
                                            // width: 35,
                                            decoration: BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5))),
                                            child: Text(
                                              snapShot.data![index].mdfDt
                                                  .toString(),
                                              style: TextStyle(
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
                                  width: MediaQuery.of(context).size.width / 2,
                                  // width: 250,
                                  child: Text(
                                    snapShot.data![index].productTitle
                                        .toString(),
                                    // maxLines: 3,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      "Quantity : ",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                        snapShot.data![index].productQuantity
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                    Text(
                                        snapShot.data![index].unitName
                                            .toString(),
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
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  height: 35,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        var product_id_temp = snapShot
                                            .data![index].productId
                                            .toString();
                                        setState(() {
                                          product_id = product_id_temp;
                                        });

                                        debugPrint("Product ID");
                                        debugPrint(product_id);
                                        // Navigator.pushNamed(context, 'productPage');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductPage(
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
              },
            );
          }),
    );
  }

  Future<List<ProductData>?> getProduct() async {
    print("SubId_param before");
    print(SubId_param);
    setState(() {
      CatId_param = widget.cat_id;
      SubId_param = widget.sub_id;
    });

    print("SubId_param");
    print(SubId_param);

    var data1 = {
      "cat_subcat": jsonEncode([
        {
          "cat_id": CatId_param,
          "sub_cat_id": SubId_param == null ? [] : [SubId_param]
        }
      ])
    };

    var formData = FormData.fromMap(data1);

    // Base URL
    const baseurl = "http://161.97.138.56:3021/mobile/product/list";

    Dio dio = Dio();

    try {
      Response response = await dio.post(baseurl, data: formData);
      ProductModel res = ProductModel.fromJson(response.data);
      print(response);
      print(formData.fields);
      return res.data;
    } on DioError catch (e) {
      print(e);
    }
  }
}

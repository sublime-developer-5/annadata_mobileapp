import 'dart:async';
import 'dart:convert';
import 'package:annadata/Model/categoryCopy.dart';
import 'package:annadata/Model/productModel.dart';
import 'package:annadata/Model/subCatModel.dart';
import 'package:annadata/screens/product_Page.dart';
import 'package:annadata/widgets/filterListCard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryFilterPage extends StatefulWidget {
  CategoryFilterPage(
      {Key? key, this.passCatID, this.passIndex, this.passSubCatId})
      : super(key: key);

  String? passCatID;
  String? passSubCatId;
  int? passIndex;

  @override
  State<CategoryFilterPage> createState() => _CategoryFilterPageState();
}

class _CategoryFilterPageState extends State<CategoryFilterPage> {
  String product_id = "";
  String CatId_param = "";
  String? SubId_param;

  String? product_Count;

  bool filtercheckBox = true;

  String? categoryId;
  String? getCategoryId;
  String? subCatId;
  String? getSubCatId;
  String? select_Cat;

  Color activeColor = Colors.green;
  Color inactiveColor = Color.fromARGB(255, 204, 202, 202);
  Color inactiveColorText = Colors.black;
  Color activeColorText = Colors.white;

  final scrollController = ScrollController();
  final scrollControllerSubCat = ScrollController();

  @override
  void initState() {
    super.initState();

    setState(() {
      getCategoryId = widget.passCatID.toString();
      // subCatId = subCatId == null ? "" : widget.passSubCatId.toString();
      getSubCatId = widget.passSubCatId.toString();
      categoryId == "" ? getCategoryId : categoryId;
      subCatId == "" ? getSubCatId : subCatId;
    });
    print("*********---getCategoryId---********");
    print(getCategoryId);
    print("*********---getSubCatId---********");
    print(getSubCatId);

    Timer(
        Duration(seconds: 1), () => {scrollToIndex(widget.passIndex!.toInt())});
  }

  scrollToIndex(index) async {
    await scrollController.animateTo(100.0 * index,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  scrollToIndexSubCat(index) async {
    await scrollControllerSubCat.animateTo(100.0 * index,
        // MediaQuery.of(context).size.width / 5 * index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 218, 216, 216),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Filter Ads",
          style: TextStyle(fontFamily: 'Rubik Regular'),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [
                Text(
                  "Select category:",
                  style: TextStyle(fontFamily: 'Rubik Regular'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: FutureBuilder<List<CategoryListData>?>(
                future: getCategoryList(),
                builder: (context, snapShot) {
                  if (!snapShot.hasData) {
                    return Shimmer.fromColors(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (_, __) {
                              return SizedBox(
                                height: 40,
                                width: 80,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  elevation: 2,
                                ),
                              );
                            }),
                        baseColor: Colors.white,
                        highlightColor: Colors.grey.shade300);
                  }
                  return ListView.builder(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapShot.data!.length,
                      itemBuilder: (BuildContext context, index) {
                        print(snapShot.data![index].categoryImg);
                        print(
                            "************************ snapShot.data **********************");
                        final catId =
                            snapShot.data![index].categoryId.toString();

                        return SizedBox(
                          height: 40,
                          child: Card(
                            color: categoryId == catId
                                ? activeColor
                                : inactiveColor,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            elevation: 0,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5),
                              highlightColor: Colors.green,
                              focusColor: Colors.green,
                              onTap: () {
                                scrollToIndex(index);

                                print(catId);
                                setState(() {
                                  categoryId = catId;
                                  subCatId = "";
                                  getCategoryId = "";
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      snapShot.data![index].categoryName
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: 'Rubik Regular',
                                          fontSize: 12,
                                          color: categoryId == catId
                                              ? activeColorText
                                              : inactiveColorText),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }),
          ),
          // Container(
          //   margin: const EdgeInsets.symmetric(
          //     vertical: 5,
          //   ),
          //   height: 2,
          //   color: const Color.fromARGB(255, 223, 221, 221),
          // ),

          SizedBox(
            height: 5,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [
                Text(
                  "Select commodity:",
                  style: TextStyle(fontFamily: 'Rubik Regular'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: subCatId == ""
                            ? activeColorText
                            : inactiveColorText,
                        backgroundColor:
                            subCatId == "" ? activeColor : inactiveColor,
                      ),
                      onPressed: () {
                        setState(() {
                          subCatId = "";
                          getSubCatId = "";
                        });
                      },
                      child: const Text(
                        "All",
                        style: TextStyle(
                          fontFamily: 'Rubik Regular',
                          fontSize: 12,
                        ),
                      )),
                ),
                Expanded(
                  child: FutureBuilder<List<SubCatData>?>(
                      future: getSubCategoryList(),
                      builder: (context, snapShot) {
                        if (!snapShot.hasData) {
                          return Shimmer.fromColors(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 10,
                                  itemBuilder: (_, __) {
                                    return SizedBox(
                                      height: 40,
                                      width: 80,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        elevation: 0,
                                      ),
                                    );
                                  }),
                              baseColor: Colors.white,
                              highlightColor: Colors.grey.shade300);
                        }
                        return ListView.builder(
                            controller: scrollControllerSubCat,
                            shrinkWrap: true,
                            addSemanticIndexes: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapShot.data!.length,
                            itemBuilder: (BuildContext context, index) {
                              // Color activeColor = Colors.green;
                              // Color inactiveColor = Colors.white;
                              // Color inactiveColorText = Colors.black;
                              // Color activeColorText = Colors.white;
                              final subCategoryId = snapShot
                                  .data![index].subCategoryId
                                  .toString();
                              return SizedBox(
                                height: 40,
                                child: Card(
                                  color: subCatId == subCategoryId
                                      ? activeColor
                                      : inactiveColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  elevation: 0,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 3),
                                  child: InkWell(
                                    hoverColor: Colors.green,
                                    onTap: () {
                                      scrollToIndexSubCat(index);

                                      setState(() {
                                        subCatId = subCategoryId;
                                        getSubCatId = "";
                                      });
                                      print("subCatId");
                                      print(subCatId);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapShot
                                                .data![index].subCategoryName
                                                .toString(),
                                            style: TextStyle(
                                                fontFamily: 'Rubik Regular',
                                                fontSize: 12,
                                                color: subCatId == subCategoryId
                                                    ? activeColorText
                                                    : inactiveColorText),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            color: const Color.fromARGB(255, 223, 221, 221),
            child: Text(
              "Product Count: " + product_Count.toString(),
            ),
          ),

          Expanded(
            child: FutureBuilder<List<ProductData>?>(
                future: getProduct(),
                builder: (context, snapShot) {
                  // print("product snapShot");
                  // print(snapShot.data);

                  if (!snapShot.hasData) {
                    return Shimmer.fromColors(
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (_, __) {
                              return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                        highlightColor: Colors.grey.shade300);
                    // return Center(
                    //   child: CircularProgressIndicator(),
                    // );
                  } else if (snapShot.data!.length == 0) {
                    return Column(
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
                          style: TextStyle(
                              fontFamily: 'Rubik Regular', fontSize: 18),
                        ),
                      ],
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapShot.data!.length,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: InkWell(
                          onTap: () {
                            var product_id_temp =
                                snapShot.data![index].productId.toString();
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              snapShot.data![index].productImg
                                                  .toString(),
                                              errorBuilder: (context, error,
                                                      stacktrace) =>
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
                                                      borderRadius: const BorderRadius
                                                              .only(
                                                          topRight: const Radius
                                                              .circular(5),
                                                          bottomRight:
                                                              const Radius
                                                                      .circular(
                                                                  5))),
                                                  child: Text(
                                                    snapShot.data![index].mdfDt
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            MediaQuery.of(context).size.width /
                                                2,
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
                                              snapShot
                                                  .data![index].productQuantity
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
                                            MediaQuery.of(context).size.width /
                                                2.2,
                                        height: 35,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              var product_id_temp = snapShot
                                                  .data![index].productId
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
                                                          product_id:
                                                              product_id),
                                                ),
                                              );
                                            },
                                            child:
                                                const Text("Contact Farmer")),
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
          )
          // ProductListCard(
          //   cat_id: categoryId,
          //   sub_id: subCatId,
          // )
        ],
      ),
      // body: NestedScrollView(
      //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      //     return [
      //       SliverAppBar(
      //         expandedHeight: 60,
      //         floating: true,
      //         automaticallyImplyLeading: false,
      //         title: SizedBox(
      //           height: 40,
      //           child: TextFormField(
      //             decoration: InputDecoration(
      //                 suffixIcon: IconButton(
      //                   icon: const Icon(Icons.search),
      //                   onPressed: () {},
      //                 ),
      //                 fillColor: Colors.white,
      //                 filled: true,
      //                 border: OutlineInputBorder(
      //                     borderRadius: BorderRadius.circular(8),
      //                     borderSide: const BorderSide(color: Colors.orange)),
      //                 contentPadding:
      //                     const EdgeInsets.symmetric(horizontal: 15),
      //                 hintText: "Search Category / Commodity",
      //                 // hintStyle: TextStyle(fontSize: 18),
      //                 enabledBorder: OutlineInputBorder(
      //                     borderRadius: BorderRadius.circular(8),
      //                     borderSide: const BorderSide(color: Colors.orange)),
      //                 focusedBorder: OutlineInputBorder(
      //                     borderRadius: BorderRadius.circular(8),
      //                     borderSide: const BorderSide(color: Colors.green))),
      //           ),
      //         ),
      //       ),
      //     ];
      //   },

      // ),
    );
  }

  sort_bottomSheet() {
    int sortValue = 1;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: double.infinity),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(border: Border.all(width: 0.5)),
            child: const Text(
              'SORT BY',
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          RadioListTile(
              title: const Text('Popularity'),
              value: 1,
              groupValue: sortValue,
              onChanged: (Value) {
                setState(() {
                  sortValue = Value as int;
                });
              }),
          RadioListTile(
              title: const Text('Newest First'),
              value: 2,
              groupValue: sortValue,
              onChanged: (Value) {
                setState(() {
                  sortValue = Value as int;
                });
              }),
          RadioListTile(
              title: const Text('Quantity -- Low to High'),
              value: 3,
              groupValue: sortValue,
              onChanged: (Value) {
                setState(() {
                  sortValue = Value as int;
                });
              }),
          RadioListTile(
              title: const Text('Quantity -- High to Low'),
              value: 4,
              groupValue: sortValue,
              onChanged: (Value) {
                setState(() {
                  sortValue = Value as int;
                });
              })
        ],
      ),
    );
  }

  filter_BottomSheet() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "    Filter By",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 1,
            color: Colors.orange,
            thickness: 1,
          ),
          Row(
            children: [
              Container(
                width: 120,
                child: Column(
                  children: [
                    InkWell(
                      // focusColor: Color.fromRGBO(229, 229, 229, 100),
                      onTap: () {},
                      child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(196, 196, 196, 100)),
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text("Categories")),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    InkWell(
                      // focusColor: Color.fromRGBO(229, 229, 229, 100),
                      onTap: () {},
                      child: Container(
                          decoration: const BoxDecoration(
                              color: const Color.fromRGBO(196, 196, 196, 100)),
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text("Categories")),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    InkWell(
                      // focusColor: Color.fromRGBO(229, 229, 229, 100),
                      onTap: () {},
                      child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(196, 196, 196, 100)),
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text("Categories")),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Checkbox(
                  value: this.filtercheckBox,
                  onChanged: (bool? value) {
                    setState(() {
                      this.filtercheckBox = value!;
                    });
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<List<CategoryListData>?> getCategoryList() async {
    // Base URL
    var baseurl = "http://161.97.138.56:3021/mobile/category/list";

    Dio dio = Dio();

    try {
      Response response = await dio.get(baseurl);
      CategoryList res = CategoryList.fromJson(response.data);

      return res.data;
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<List<SubCatData>?> getSubCategoryList() async {
    // Base URL
    var baseurl =
        "http://161.97.138.56:3021/mobile/sub_category/list?category_id=$categoryId";

    Dio dio = Dio();

    try {
      Response response = await dio.get(baseurl);
      SubCategoryList res = SubCategoryList.fromJson(response.data);

      return res.data;
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<List<ProductData>?> getProduct() async {
    // print("SubId_param before");
    // print(SubId_param);
    // setState(() {
    //   CatId_param = categoryId!;
    //   SubId_param = subCatId;
    // });

    // print("SubId_param");
    // print(SubId_param);

    var data1 = {
      "cat_subcat": jsonEncode([
        {
          "cat_id": getCategoryId == "" ? categoryId : getCategoryId,
          "sub_cat_id": subCatId == [] ? [] : subCatId
          // "sub_cat_id": getSubCatId == ""
          //     ? subCatId == []
          //     : getSubCatId == []
          //         ? []
          //         : getCategoryId
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
      setState(() {
        product_Count = res.data!.length.toString();
      });
      // print(response);
      print(formData.fields);
      return res.data;
    } on DioError catch (e) {
      print(e);
    }
  }
}

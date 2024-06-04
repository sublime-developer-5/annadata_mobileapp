import 'package:annadata/Model/contact_farmer_details.dart';
import 'package:annadata/Model/productModel.dart';
import 'package:annadata/screens/login.dart';
import 'package:annadata/widgets/HomeScreen/homeBottumNavBar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../env.dart';
import '../widgets/logisticsListCard.dart';

class ProductPage extends StatefulWidget {
  ProductPage({
    Key? key,
    this.product_id,
  }) : super(key: key);
  String? product_id;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  late final productInfoFuture;
  late final getFarmerContactInfoFuture;

  String? userToken;
  String? userId;
  String? userRole;
  String? contactFarmerMassege;
  String? farmerPincode;
  String? productTitle;

  getID() async {
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.getString("auth_token");
    var role = prefs.getString("userRole");

    setState(() {
      userToken = token;
      userRole = role;
    });

    print("*****token---------");
    print(token);
    print("*****Product ID--------");
    print(widget.product_id);
  }

  @override
  void initState() {
    super.initState();
    getID();

    productInfoFuture = getProductInfo();
    getFarmerContactInfoFuture = getFarmerContactInfo();

    Future.delayed(Duration(milliseconds: 500),
        () => {debugPrint("farmer"), getFarmerContactInfo()});

    debugPrint("Product page ID ");
    debugPrint(widget.product_id);

    tabController = TabController(length: 2, vsync: this);
  }

  Future<List<ProductData>?> getProductInfo() async {
    // Base URL
    var baseurl = EnvConfigs.appBaseUrl+"product/getinfo";

    Dio dio = Dio();

    try {
      Response response =
          await dio.post(baseurl, data: {"product_id": widget.product_id});
      ProductModel res = ProductModel.fromJson(response.data);
      setState(() {
        farmerPincode = res.data![0].pincode.toString();

        productTitle = res.data![0].productTitle.toString();
      });

      print("*******productId*****");
      print(widget.product_id);

      print("-----*****usertokem*******-----");
      print(userToken);

      return res.data;
    } on DioError catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<Data>?> getFarmerContactInfo() async {
    // Base URL
    var baseurl = EnvConfigs.appBaseUrl+"product/farmercontact";

    Dio dio = Dio();

    try {
      Response response = await dio.post(baseurl,
          options: Options(headers: {'x-access-token': userToken}),
          data: {"product_id": widget.product_id});
      ContactFarmerDetailsModel res =
          ContactFarmerDetailsModel.fromJson(response.data);
      setState(() {
        contactFarmerMassege = res.message.toString();
      });

      return res.data;
    } on DioError catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomButtonSheetForProductPage(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.orange,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          productTitle == null ? "" : productTitle.toString(),
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Rubik Regular',
              fontSize: 21,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<ProductData>?>(
          future: productInfoFuture,
          builder: (context, snapShot) {
            var item = snapShot.data;

            if (!snapShot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Text('Post on: 14/06/2022'),
                              Text(
                                'Posted on: ${item![0].mdfDt}',
                                style: const TextStyle(
                                    fontFamily: 'Rubik Regular', fontSize: 11),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 5),
                          //   child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       children: [
                          //         // Text("Product Title",
                          //         //     style: TextStyle(
                          //         //         fontFamily: 'Rubik Regular',
                          //         //         fontSize: 18,
                          //         //         fontWeight: FontWeight.bold,
                          //         //         color: Colors.black)),
                          //         Text(item[0].productTitle.toString(),
                          //             style: const TextStyle(
                          //                 fontFamily: 'Rubik Regular',
                          //                 fontSize: 21,
                          //                 fontWeight: FontWeight.bold,
                          //                 color: Colors.black)),
                          //       ]),
                          // ),
                        ]),
                  ),
                  ProductImage(ProductImg: item[0].productImg.toString()),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  TabBar(
                      isScrollable: false,
                      controller: tabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        const Tab(
                          text: "Description",
                        ),
                        const Tab(
                          text: "Logistic List",
                        )
                      ]),
                  SizedBox(
                    // padding: EdgeInsets.only(bottom: 10),
                    height: MediaQuery.of(context).size.height / 2,
                    child: TabBarView(
                        //dragStartBehavior: DragStartBehavior.start,
                        //physics: ScrollPhysics(),
                        controller: tabController,
                        children: [
                          // Description Tab

                          Container(
                            padding: EdgeInsets.all(5),
                            child: ListView(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: const BoxDecoration(
                                      // color: Color.fromARGB(255, 228, 226, 226)
                                      ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        "Quantity : ",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Rubik Regular',
                                            fontSize: 18),
                                      ),
                                      Text(item[0].productQuantity.toString(),
                                          // "200",
                                          style: const TextStyle(
                                              fontFamily: 'Rubik Regular',
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                      Text(item[0].unitName.toString(),
                                          style: const TextStyle(
                                              fontFamily: 'Rubik Regular',
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12))
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      right: 20, bottom: 5, left: 20, top: 20),
                                  decoration: const BoxDecoration(
                                      // color: Color.fromARGB(255, 228, 226, 226)
                                      ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        "Category:",
                                        style: TextStyle(
                                          fontFamily: 'Rubik Regular',
                                          fontSize: 15,
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          //color: Color.fromARGB(255, 158, 157, 157)
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        item[0].categoryName.toString(),
                                        style: const TextStyle(
                                            fontFamily: 'Rubik Regular',
                                            fontSize: 15,
                                            // fontWeight: FontWeight.bold,
                                            // color: Colors.black
                                            color: Color.fromARGB(
                                                255, 158, 157, 157)),
                                      )
                                    ],
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 10,
                                // ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      right: 20, bottom: 20, left: 20, top: 5),
                                  decoration: const BoxDecoration(
                                      // color: Color.fromARGB(255, 228, 226, 226)
                                      ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        "Commodity:",
                                        style: TextStyle(
                                            fontFamily: 'Rubik Regular',
                                            fontSize: 15,
                                            //fontWeight: FontWeight.bold,
                                            // color: Color.fromARGB(255, 158, 157, 157)
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        item[0].subCategoryName.toString(),
                                        style: const TextStyle(
                                            fontFamily: 'Rubik Regular',
                                            fontSize: 15,
                                            //fontWeight: FontWeight.bold,
                                            // color: Colors.black
                                            color: const Color.fromARGB(
                                                255, 158, 157, 157)),
                                      )
                                    ],
                                  ),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),

                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 21, vertical: 20),
                                  decoration: const BoxDecoration(
                                      // color: Color.fromARGB(255, 228, 226, 226)
                                      ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Description: ",
                                        style: TextStyle(
                                            fontFamily: 'Rubik Regular',
                                            fontSize: 15,
                                            //fontWeight: FontWeight.bold,
                                            // color: Color.fromARGB(255, 158, 157, 157)
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      ReadMoreText(
                                        "       " +
                                            item[0]
                                                .productDescription
                                                .toString(),
                                        style: const TextStyle(
                                            fontFamily: 'Rubik Regular',
                                            fontSize: 15,
                                            // fontWeight: FontWeight.bold,
                                            color: const Color.fromARGB(
                                                255, 158, 157, 157)),
                                        trimCollapsedText: "Read More",
                                        trimExpandedText: "  Less",
                                        trimLines: 3,
                                        trimMode: TrimMode.Line,
                                        colorClickableText: Colors.green,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Logistic List Tab

                          LogisticsListCard(productId: widget.product_id),
                          // Text("data2")
                        ]),
                  ),
                ],
              ),
            );
          }),
    );
  }

  bottomButtonSheetForProductPage() {
    // String ProductId = item[0].productId;

    return Container(
      padding: const EdgeInsets.only(bottom: 20, top: 20),
      //height: 100,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.2,
            height: 45,
            child: ElevatedButton(
                onPressed: () {
                  if (userRole == 'farmer' || userRole == 'logistics') {
                    showDialog(
                        context: context,
                        builder: (_) => Dialog(
                              child: Container(
                                child: SingleChildScrollView(
                                  child: Column(children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              padding: EdgeInsets.only(
                                                  top: 5,
                                                  right: 5,
                                                  bottom: 5,
                                                  left: 5),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(Icons.cancel))
                                        ]),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 20, right: 20),
                                      child: Column(
                                        children: [
                                          Text("Please login as Buyer",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Rubik Regular',
                                                  fontSize: 20)),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginPage()));
                                            },
                                            child: const Text(
                                                "Would you like to Logout?",
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Rubik Regular')),
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            ));
                  } else if (userToken == null) {
                    showDialog(
                        context: context,
                        builder: (_) => Dialog(
                              child: Container(
                                child: SingleChildScrollView(
                                  child: Column(children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              padding: EdgeInsets.only(
                                                  top: 5,
                                                  right: 5,
                                                  bottom: 5,
                                                  left: 5),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(Icons.cancel))
                                        ]),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 20, right: 20),
                                      child: Column(
                                        children: [
                                          Text(
                                              "Please login first for see farmer details",
                                              style: TextStyle(
                                                  fontFamily: 'Rubik Regular',
                                                  fontSize: 20)),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BottumNavBar(
                                                            pageIndex: 1,
                                                          )));
                                            },
                                            child: const Text(
                                                "Would you like to login?",
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Rubik Regular')),
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            ));
                  } else if (contactFarmerMassege == "Membership is expired") {
                    final snackBar = const SnackBar(
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      content: const Text("Membership is expired"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (contactFarmerMassege ==
                      "can't fetched the contact......") {
                    final snackBar = const SnackBar(
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      content: const Text("can't fetched the contact......"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    showDialog(
                        useSafeArea: true,
                        context: context,
                        builder: (
                          context,
                        ) {
                          return FutureBuilder<List<Data>?>(
                              future: getFarmerContactInfo(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }

                                var item = snapshot.data;

                                var farmerContactNo =
                                    item![0].contactNo.toString();
                                var farmerEmail = item[0].emailId.toString();
                                var farmerAddress =
                                    item[0].cityName.toString() +
                                        ", " +
                                        item[0].districtName.toString() +
                                        ", " +
                                        item[0].stateName.toString() +
                                        ", " +
                                        farmerPincode.toString() +
                                        ".";

                                return Dialog(
                                    child: Container(
                                        // padding: const EdgeInsets.only(
                                        //     left: 30,
                                        //     right: 30,
                                        //     bottom: 30,
                                        //     top: 0),
                                        child: SingleChildScrollView(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: Icon(Icons.cancel))
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 30, right: 30, left: 30),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // SizedBox(
                                              //   height: 30,
                                              // ),
                                              const Text(
                                                "Farmer Name:",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        'Rubik Regular'),
                                              ),
                                              // const SizedBox(
                                              //   height: 10,
                                              // ),
                                              Text(
                                                item[0].farmerName.toString(),
                                                style: const TextStyle(
                                                    // color: Colors.green,
                                                    fontSize: 15,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        'Rubik Regular'),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              const Text(
                                                "Mobile Number:",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        'Rubik Regular'),
                                              ),
                                              // const SizedBox(
                                              //   height: 10,
                                              // ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    farmerContactNo,
                                                    // "+91 8956250864",
                                                    style: const TextStyle(
                                                        // color: Colors.green,
                                                        fontSize: 15,
                                                        //  fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            'Rubik Regular'),
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                    child: TextButton(
                                                        onPressed: () async {
                                                          final url =
                                                              'tel:$farmerContactNo';

                                                          // ignore: deprecated_member_use
                                                          if (await canLaunch(
                                                              url)) {
                                                            // ignore: deprecated_member_use
                                                            await launch(url);
                                                          }
                                                        },
                                                        child: const Text(
                                                            "Call Now")),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Text(
                                                "Email ID:",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        'Rubik Regular'),
                                              ),
                                              // const SizedBox(
                                              //   height: 10,
                                              // ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.5,
                                                    child: Text(
                                                      farmerEmail,
                                                      //overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          // color: Colors.green,
                                                          fontSize: 15,
                                                          //fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              'Rubik Regular'),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                    child: TextButton(
                                                        onPressed: () async {
                                                          final url =
                                                              'mailto:$farmerEmail';

                                                          // ignore: deprecated_member_use
                                                          if (await canLaunch(
                                                              url)) {
                                                            // ignore: deprecated_member_use
                                                            await launch(url);
                                                          }
                                                        },
                                                        child: const Text(
                                                            "Email\nNow")),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              const Text(
                                                "Address:",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        'Rubik Regular'),
                                              ),
                                              // const SizedBox(
                                              //   height: 10,
                                              // ),
                                              Text(
                                                farmerAddress,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(

                                                    // color: Colors.green,
                                                    fontSize: 15,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        'Rubik Regular'),
                                              ),

                                              // ElevatedButton(
                                              //     onPressed: () {},
                                              //     style: ButtonStyle(
                                              //         backgroundColor:
                                              //             MaterialStateProperty.all(
                                              //                 Colors.green),
                                              //         shape: MaterialStateProperty.all<
                                              //                 RoundedRectangleBorder>(
                                              //             RoundedRectangleBorder(
                                              //                 borderRadius:
                                              //                     BorderRadius.circular(
                                              //                         10)))),
                                              //     child: const Text(
                                              //       'Call Now',
                                              //       style: TextStyle(
                                              //           fontWeight: FontWeight.bold,
                                              //           fontSize: 15),
                                              //     ))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )));
                              });
                        });
                  }

                  // Contact Farmer/////////////////////////////////
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                child: const Text(
                  'Contact Farmer',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Rubik Regular',
                      fontSize: 15),
                )),
          ),
        ],
      ),
    );
  }
}

class ProductImage extends StatefulWidget {
  String ProductImg;

  ProductImage({Key? key, required this.ProductImg}) : super(key: key);

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          //padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.all(Radius.circular(10))),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3.5,

          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              widget.ProductImg,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stacktrace) => Image.asset(
                "assets/Logo-modified.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

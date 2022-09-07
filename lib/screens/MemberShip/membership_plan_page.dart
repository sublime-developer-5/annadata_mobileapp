import 'package:annadata/Model/membership_plan_model.dart';
import 'package:annadata/Model/razorpay_dataModel.dart';
import 'package:annadata/Model/user_edit_info_model.dart';
import 'package:annadata/Test/razorpay_integration_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../widgets/HomeScreen/homeBottumNavBar.dart';
import '../homepage.dart';
import '../login.dart';

class MembershipDetails extends StatefulWidget {
  const MembershipDetails({Key? key}) : super(key: key);

  @override
  State<MembershipDetails> createState() => _MembershipDetailsState();
}

class _MembershipDetailsState extends State<MembershipDetails> {
  late Razorpay _razorpay;
  var userRole;
  String? userToken;
  String? userID;
  var userContactNo;
  var userEmailID;
  String? planAmount;

  String? getPlanID;
  String? getOrder_id;

  // Razorpay Variables

  var raResponse;
  String? raOrderId;
  String? raPaymentId;
  String? raSignature;

  // User Data Get From Shared Preference
  getID() async {
    final prefs = await SharedPreferences.getInstance();

    var role = prefs.getString("userRole");
    var id = prefs.getString("_id");
    var token = prefs.getString("auth_token");

    setState(() {
      userRole = role.toString();
      userToken = token.toString();
      userID = id.toString();
    });

    debugPrint("userID****-----");
    debugPrint(userID);
    debugPrint("userToken****-----");
    debugPrint(userToken);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getID();
    Future.delayed(Duration(seconds: 1), (() => getUserInfo()));

    getPaymentGatwayDetails();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');

    setState(() {
      raResponse = response.toString();
      raOrderId = response.orderId.toString();
      raPaymentId = response.paymentId.toString();
      raSignature = response.signature.toString();
    });
    uploadRazorpayResponse();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_Ls3MQ1hXnznoHF',
      'amount': planAmount.toString(), //in the smallest currency sub-unit.

      'order_id': getOrder_id, // Generate order_id using Orders API
      'currency': 'INR',
      'name': 'Annadata Bharat',
      //'description': 'Fine T-Shirt',
      //'timeout': 60, // in seconds
      //'prefill': {'contact': '9123456789', 'email': 'gaurav.kumar@example.com'}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Data>?>(
        future: getMembershipPlansList(),
        builder: (context, snapShot) {
          if (!snapShot.hasData) {
            return Scaffold(
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Membership plans"),
            ),
            body: ListView.builder(
                itemCount: snapShot.data!.length,
                itemBuilder: (BuildContext context, index) {
                  var membershipPlanId =
                      snapShot.data![index].membershipPlanId.toString();
                  return Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      elevation: 5,
                      child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              ListTile(
                                leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "₹ " +
                                          snapShot
                                              .data![index].membershipPlanCost
                                              .toString(),
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontFamily: 'Rubik Regular',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                title: Text(
                                  snapShot.data![index].membershipPlanName
                                      .toString(),
                                  style: TextStyle(
                                      // color: Colors.orange,
                                      fontFamily: 'Rubik Regular',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    snapShot.data![index].membershipPlanDesc
                                        .toString(),
                                    style: TextStyle(
                                      // color: Colors.orange,
                                      fontFamily: 'Rubik Regular',
                                      fontSize: 14,
                                      // fontWeight: FontWeight.bold
                                    )),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      getPlanID = membershipPlanId;
                                    });
                                    if (userID == "null") {
                                      showDialog(
                                          context: context,
                                          builder: (_) => Dialog(
                                                child: Container(
                                                  child: SingleChildScrollView(
                                                    child: Column(children: [
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            IconButton(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 5,
                                                                        right:
                                                                            5,
                                                                        bottom:
                                                                            5,
                                                                        left:
                                                                            5),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                icon: Icon(Icons
                                                                    .cancel))
                                                          ]),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 20,
                                                                bottom: 20,
                                                                right: 20),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                                "Please login first for buy membership plan",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Rubik Regular',
                                                                    fontSize:
                                                                        20)),
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
                                    } else {
                                      getPaymentGatwayDetails();
                                    }

                                    // Future.delayed(Duration(seconds: 2),
                                    //     () => {openCheckout()});
                                  },
                                  child: Text("Purchase Link"),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)))),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15))),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Validity: " +
                                          snapShot.data![index].durationMonths
                                              .toString() +
                                          " Months",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                  );
                }),
          );
        });
  }

  Future<List<Data>?> getMembershipPlansList() async {
    String baseUrl = "http://161.97.138.56:3021/mobile/membershipplan/list";
    try {
      Dio dio = Dio();

      final response = await dio.get(baseUrl);
      // String strTemp = response.toString();
      final MembershipPlanModel membershipPlanList =
          MembershipPlanModel.fromJson(response.data);

      return membershipPlanList.data;
    } catch (e) {
      print(e);
    }
  }

  Future<UserEditInfo?> getUserInfo() async {
    // Base URL
    var baseurl = "http://161.97.138.56:3021/mobile/user/edit";

    Dio dio = Dio();
    var formData = FormData.fromMap({
      'user_id': userID,
    });

    try {
      Response response = await dio.post(
        baseurl,
        options: Options(headers: {'x-access-token': userToken}),
        data: formData,
      );

      // Data res = Data.fromJson(response.data);
      UserEditInfo res = UserEditInfo.fromJson(response.data);

      setState(() {
        userContactNo = res.data![0].mobileNo.toString();
        userEmailID = res.data![0].emailId.toString();
      });

      debugPrint("userContactNo******--");
      // debugPrint(for);

      // var res = jsonDecode(response.data);

      // print(res.success);

      print("----****res*****----");
      print(res);

      return res;
    } on DioError catch (e) {
      print(e);
    }
    return UserEditInfo();
  }

  Future<List<RazorPayData>?> getPaymentGatwayDetails() async {
    // Base URL
    var baseurl =
        "http://161.97.138.56:3021/mobile/membershipdetail/paymentgateway";

    Dio dio = Dio();
    var formData = FormData.fromMap({
      'membership_plan_id': getPlanID,
    });

    try {
      Response response = await dio.post(
        baseurl,
        options: Options(headers: {'x-access-token': userToken}),
        data: formData,
      );

      // Data res = Data.fromJson(response.data);
      RazorpayDataModel res = RazorpayDataModel.fromJson(response.data);

      setState(() {
        planAmount = res.order!.amount.toString();

        getOrder_id = res.order!.id.toString();
      });

      openCheckout();
      debugPrint("*****getPlanId*****");
      debugPrint(getPlanID);

      debugPrint("membership_Order_id******--");
      debugPrint(res.order!.id.toString());
      debugPrint("planAmount.toString()**");
      debugPrint(planAmount.toString());
    } on DioError catch (e) {
      print(e);
    }
  }

  Future uploadRazorpayResponse() async {
    // Base URL
    var baseurl = "http://161.97.138.56:3021/mobile/membershipdetail/add";

    Dio dio = Dio();

    try {
      Response response = await dio.post(baseurl,
          options: Options(headers: {'x-access-token': userToken}),
          data: {
            "membership_plan_id": getPlanID,
            "response": {
              "razorpay_order_id": raOrderId,
              "razorpay_payment_id": raPaymentId,
              "razorpay_signature": raSignature
            }
          });

      // Data res = Data.fromJson(response.data);

      debugPrint("/**********Razorpay Response Data*******");
      debugPrint(response.data.toString());
      debugPrint(response.data["message"].toString());
    } on DioError catch (e) {
      print(e);
    }
  }
}

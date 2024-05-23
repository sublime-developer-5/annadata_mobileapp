import 'dart:io';

import 'package:annadata/Model/upcoming_membership_renewals_model.dart';
import 'package:annadata/Model/user_edit_info_model.dart';
import 'package:annadata/Model/user_membership_details_model.dart';
import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../env.dart';

class UserMembershipDetails extends StatefulWidget {
  const UserMembershipDetails({Key? key}) : super(key: key);

  @override
  State<UserMembershipDetails> createState() => _UserMembershipDetailsState();
}

class _UserMembershipDetailsState extends State<UserMembershipDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserInfo();
    getUpcomingMembershipDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Membership Details"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        //height: 20,
                        indent: 10,
                        endIndent: 10,
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Active Membership",
                      style: TextStyle(
                          // color: Colors.orange,
                          fontFamily: 'Rubik Regular',
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Divider(
                        //height: 20,
                        indent: 10,
                        endIndent: 10,
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              FutureBuilder<UserEditInfo?>(
                  future: getUserInfo(),
                  builder: (context, snapShot) {
                    if (!snapShot.hasData) {
                      return Shimmer.fromColors(
                          child: Padding(
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
                              )),
                          baseColor: Colors.white,
                          highlightColor: Colors.grey.shade300);
                    }
                    var item = snapShot.data?.data![0];
                    return item!.membershipDetailId == null
                        ? Text("Not Found Any Active Membership")
                        : Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              elevation: 5,
                              child: InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      ListTile(
                                        // leading: Column(
                                        //   mainAxisAlignment: MainAxisAlignment.center,
                                        //   children: [
                                        //     Text(
                                        //       "₹ ",
                                        //       style: TextStyle(
                                        //           color: Colors.orange,
                                        //           fontFamily: 'Rubik Regular',
                                        //           fontSize: 20,
                                        //           fontWeight: FontWeight.bold),
                                        //       textAlign: TextAlign.center,
                                        //     ),
                                        //   ],
                                        // ),
                                        title: Text(
                                          item.membershipPlanName.toString(),
                                          style: TextStyle(
                                              // color: Colors.orange,
                                              fontFamily: 'Rubik Regular',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // subtitle: Text("",
                                        //     style: TextStyle(
                                        //       // color: Colors.orange,
                                        //       fontFamily: 'Rubik Regular',
                                        //       fontSize: 14,
                                        //       // fontWeight: FontWeight.bold
                                        //     )),
                                        //trailing: Text("Status")
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15))),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Start Date: ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontFamily:
                                                          'Rubik Regular'),
                                                ),
                                                Text(
                                                  item.startDate.toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontFamily:
                                                          'Rubik Regular'),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "End Date: ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontFamily:
                                                          'Rubik Regular'),
                                                ),
                                                Text(
                                                  item.endDate.toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontFamily:
                                                          'Rubik Regular'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          );
                  }),

              // Upcoming Membership Details

              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        //height: 20,
                        indent: 10,
                        endIndent: 10,
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Upcoming Membership",
                      style: TextStyle(
                          // color: Colors.orange,
                          fontFamily: 'Rubik Regular',
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Divider(
                        //height: 20,
                        indent: 10,
                        endIndent: 10,
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder<List<UpcomingMembershipData>?>(
                  future: getUpcomingMembershipDetails(),
                  builder: (context, snapShop) {
                    if (!snapShop.hasData) {
                      return Shimmer.fromColors(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 5,
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

                    } else if (snapShop.data!.length == 0) {
                      return Text("Not Found Any Upcoming Membership");
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapShop.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(left: 20, right: 20, top: 20),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                elevation: 5,
                                child: InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        ListTile(
                                          // leading: Column(
                                          //   mainAxisAlignment: MainAxisAlignment.center,
                                          //   children: [
                                          //     Text(
                                          //       "₹ ",
                                          //       style: TextStyle(
                                          //           color: Colors.orange,
                                          //           fontFamily: 'Rubik Regular',
                                          //           fontSize: 20,
                                          //           fontWeight: FontWeight.bold),
                                          //       textAlign: TextAlign.center,
                                          //     ),
                                          //   ],
                                          // ),
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapShop.data![index]
                                                    .membershipPlanName
                                                    .toString(),
                                                style: TextStyle(
                                                    // color: Colors.orange,
                                                    fontFamily: 'Rubik Regular',
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    debugPrint(
                                                        "*********Invoice*****");
                                                    debugPrint(snapShop
                                                        .data![index].invoice
                                                        .toString());
                                                    openFile(
                                                        url: snapShop
                                                            .data![index]
                                                            .invoice
                                                            .toString(),
                                                        fileName:
                                                            "Invoice.pdf");
                                                  },
                                                  child: Text("Invoice"))
                                            ],
                                          ),
                                          // subtitle: Text("",
                                          //     style: TextStyle(
                                          //       // color: Colors.orange,
                                          //       fontFamily: 'Rubik Regular',
                                          //       fontSize: 14,
                                          //       // fontWeight: FontWeight.bold
                                          //     )),
                                          //trailing: Text("Status")
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15))),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Start Date: ",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11,
                                                        fontFamily:
                                                            'Rubik Regular'),
                                                  ),
                                                  Text(
                                                    snapShop.data![0].startDate
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11,
                                                        fontFamily:
                                                            'Rubik Regular'),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "End Date: ",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11,
                                                        fontFamily:
                                                            'Rubik Regular'),
                                                  ),
                                                  Text(
                                                    snapShop.data![0].endDate
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11,
                                                        fontFamily:
                                                            'Rubik Regular'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            );
                          });
                    }
                  })
            ],
          ),
        ));
  }

  Future<List<UpcomingMembershipData>?> getUpcomingMembershipDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userToken = prefs.getString("auth_token");

    var userRole = prefs.getString("userRole");
    String baseUrl = EnvConfigs.appBaseUrl+"user/usermembership";
    try {
      Dio dio = Dio();

      final response = await dio.post(
        baseUrl,
        options: Options(headers: {'x-access-token': userToken}),
      );
      // String strTemp = response.toString();
      final UpcomingMembershipRenewals membershipPlanList =
          UpcomingMembershipRenewals.fromJson(response.data);

      print("*******membershipPlanList******");
      print(membershipPlanList.data);

      print("*****role****");

      print(userRole.toString());

      return membershipPlanList.data;
    } catch (e) {
      print(e);
    }
  }

  Future<UserEditInfo?> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();

    var id = prefs.getString("_id");
    var token = prefs.getString("auth_token");
    // Base URL
    var baseurl = EnvConfigs.appBaseUrl+"user/edit";

    Dio dio = Dio();

    // final prefs = await SharedPreferences.getInstance();

    // var id = prefs.getString("_id");
    // final userId = id;

    // print("userId");
    // print(userId);

    var formData = FormData.fromMap({
      'user_id': id,
    });

    try {
      Response response = await dio.post(
        baseurl,
        options: Options(headers: {'x-access-token': token}),
        data: formData,
      );

      // Data res = Data.fromJson(response.data);
      UserEditInfo res = UserEditInfo.fromJson(response.data);

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

  //////////////////////////////////////////////////////
  // **********Open User Documents File in phone
  Future openFile({String? url, String? fileName}) async {
    final file = await downloadFile(url, fileName!);

    if (file == null) return;
    print('path: ${file.path}');
   // OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String? url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');

    try {
      final responce = await Dio().get(url!,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0));

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(responce.data);
      await raf.close();
      return file;
    } catch (e) {
      return null;
    }
  }
  // Open User Documents File in phone********/////
  //////////////////////////////////////////////
}

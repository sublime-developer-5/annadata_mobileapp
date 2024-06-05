import 'dart:io';
import 'package:annadata/Model/user_edit_info_model.dart';
import 'package:annadata/Test/profile_edit_page.dart';
import 'package:annadata/widgets/popup_for_sessionExpire.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../env.dart';

class ProfilePageFarmer extends StatefulWidget {
  const ProfilePageFarmer({Key? key}) : super(key: key);

  @override
  State<ProfilePageFarmer> createState() => _ProfileTestScreenState();
}

class _ProfileTestScreenState extends State<ProfilePageFarmer> {
  var user_id;
  var userToken;

  getID() async {
    final prefs = await SharedPreferences.getInstance();

    var id = prefs.getString("_id");
    var token = prefs.getString("auth_token");

    setState(() {
      user_id = id;
      userToken = token;
    });
    print("----*******user_id******----");
    print(user_id);
  }

  navigation() {
    // Future.delayed(Duration(milliseconds: 100),
    //     () => {});

    Navigator.popAndPushNamed(context, "loginPage");
  }

  @override
  void initState() {
    super.initState();
    getID();

    // Future.delayed(const Duration(seconds: 1),
    //     () => user_id == null ? navigation() : null);

    Future.microtask(() => userToken == null ? SessionExpire() : null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user_id == null
          ? Container()
          // ? const Center(
          //     child: const Text(
          //       "No user found",
          //       style: TextStyle(fontFamily: 'Rubik Regular', fontSize: 25),
          //     ),
          //   )
          : FutureBuilder<UserEditInfo?>(
              future: getUserInfo(),
              builder: (context, snapshot) {
                // print(snapshot.data!.success);
                var item = snapshot.data?.data![0];
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                            elevation: 10, child: CircularProgressIndicator()

                            // decoration: BoxDecoration(
                            //     color: Colors.,
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(15))),
                            ),
                      ),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  String role = item!.role.toString();
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      centerTitle: true,
                      // leading: BackButton(
                      //   color: Colors.orange,
                      //   onPressed: (() {
                      //     Navigator.pop(context);
                      //   }),
                      // ),
                      actions: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  useSafeArea: true,
                                  context: context,
                                  builder: (context) {
                                    return ProfileEditPage();
                                  });
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.orange,
                            ))
                      ],
                    ),
                    body: SingleChildScrollView(
                        child: Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.orange,
                                radius: 58,
                                child: CircleAvatar(
                                    radius: 55,
                                    backgroundImage: NetworkImage(
                                      item.profilePhoto.toString(),
                                    )),
                                // "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9va3xlbnwwfHwwfHw%3D&w=1000&q=80")),
                              ),
                              //  Text("User Name")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Card(
                              //   elevation: 10,
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(20)),
                              //   child: ListTile(
                              //     title: const Text("Name",
                              //         style: TextStyle(
                              //             color: Colors.grey,
                              //             fontSize: 15,
                              //             fontFamily: 'Rubik Regular')),
                              //     subtitle: Text(
                              //       item.name.toString(),
                              //       style: const TextStyle(
                              //           color: Colors.black,
                              //           fontSize: 18,
                              //           fontFamily: 'Rubik Regular'),
                              //     ),
                              //   ),
                              // ),

                              SizedBox(
                                height: 10,
                              ),

                              Text("Name",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontFamily: 'Rubik Regular')),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Text(
                                  item.name.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Rubik Regular'),
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              // Card(
                              //   elevation: 10,
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(20)),
                              //   child: ListTile(
                              //     title: const Text("Email ID",
                              //         style: TextStyle(
                              //             color: Colors.grey,
                              //             fontSize: 15,
                              //             fontFamily: 'Rubik Regular')),
                              //     subtitle: Text(item.emailId.toString(),
                              //         style: const TextStyle(
                              //             color: Colors.black,
                              //             fontSize: 18,
                              //             fontFamily: 'Rubik Regular')),
                              //   ),
                              // ),

                              Text("Email ID",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontFamily: 'Rubik Regular')),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Text(
                                  item.emailId.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Rubik Regular'),
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              // Card(
                              //   elevation: 10,
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(20)),
                              //   child: ListTile(
                              //     title: const Text("Mobile Number",
                              //         style: const TextStyle(
                              //             color: Colors.grey,
                              //             fontSize: 15,
                              //             fontFamily: 'Rubik Regular')),
                              //     subtitle: Text(item.mobileNo.toString(),
                              //         style: const TextStyle(
                              //             color: Colors.black,
                              //             fontSize: 18,
                              //             fontFamily: 'Rubik Regular')),
                              //   ),
                              // ),

                              Text("Mobile Number",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontFamily: 'Rubik Regular')),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Text(
                                  item.mobileNo.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Rubik Regular'),
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              // Card(
                              //   elevation: 10,
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(20)),
                              //   child: ListTile(
                              //     title: const Text("Date of Birth",
                              //         style: TextStyle(
                              //             color: Colors.grey,
                              //             fontSize: 15,
                              //             fontFamily: 'Rubik Regular')),
                              //     subtitle: const Text("userDOB",
                              //         style: TextStyle(
                              //             color: Colors.black,
                              //             fontSize: 18,
                              //             fontFamily: 'Rubik Regular')),
                              //   ),
                              // ),
                              // Card(
                              //   elevation: 10,
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(20)),
                              //   child: ListTile(
                              //     title: const Text("Gender",
                              //         // ignore: unnecessary_const
                              //         style: const TextStyle(
                              //             color: Colors.grey,
                              //             fontSize: 15,
                              //             fontFamily: 'Rubik Regular')),
                              //     subtitle: Text(item.gender.toString(),
                              //         style: const TextStyle(
                              //             color: Colors.black,
                              //             fontSize: 18,
                              //             fontFamily: 'Rubik Regular')),
                              //   ),
                              // ),

                              Text("Gender",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontFamily: 'Rubik Regular')),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Text(
                                  item.gender.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Rubik Regular'),
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              // Card(
                              //   elevation: 10,
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(20)),
                              //   child: Padding(
                              //     padding:
                              //         const EdgeInsets.symmetric(vertical: 10),
                              //     // ignore: unnecessary_const
                              //     child: ListTile(
                              //       title: const Text("Address",
                              //           style: TextStyle(
                              //               color: Colors.grey,
                              //               fontSize: 15,
                              //               fontFamily: 'Rubik Regular')),
                              //       subtitle: Text(
                              //           item.address.toString() +
                              //               ", " +
                              //               item.cityName.toString() +
                              //               ", " +
                              //               item.districtName.toString() +
                              //               ", " +
                              //               item.stateName.toString() +
                              //               ", " +
                              //               "India" +
                              //               ", " +
                              //               item.pincode.toString(),
                              //           style: const TextStyle(
                              //               color: Colors.black,
                              //               fontSize: 18,
                              //               fontFamily: 'Rubik Regular')),
                              //     ),
                              //   ),
                              // ),

                              Text("Address",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontFamily: 'Rubik Regular')),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Text(
                                  item.address.toString() +
                                      ", " +
                                      item.cityName.toString() +
                                      ", " +
                                      item.districtName.toString() +
                                      ", " +
                                      item.stateName.toString() +
                                      ", " +
                                      "India" +
                                      ", " +
                                      item.pincode.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Rubik Regular'),
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: ExpansionTile(
                                    leading: const Icon(Icons.badge),
                                    childrenPadding:
                                        const EdgeInsets.only(bottom: 10),
                                    title: const Text(
                                      "ID Proof's",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'Rubik Regular'),
                                    ),
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          // SizedBox(
                                          //   width: MediaQuery.of(context)
                                          //           .size
                                          //           .width /
                                          //       3,
                                          //   child: Image.network(
                                          //       item.documentOne.toString()),
                                          // ),

                                          item.documentOne!=null?   ElevatedButton(
                                              onPressed: () => openFile(
                                                  url: item.documentOne,
                                                  fileName:
                                                      item.documentOneName),
                                              child: Text("Document 1")):SizedBox(),
                                          // SizedBox(
                                          //   width: MediaQuery.of(context)
                                          //           .size
                                          //           .width /
                                          //       3,
                                          //   child: Image.network(
                                          //       item.documentTwo.toString()),
                                          // )

                                          item.documentTwo!=null?   ElevatedButton(
                                              onPressed: () => openFile(
                                                  url: item.documentTwo,
                                                  fileName:
                                                      item.documentTwoName),
                                              child: Text("Document 2")):SizedBox(),
                                        ],
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              // role == "farmer"
                              //     ? Container(
                              //         decoration: BoxDecoration(
                              //             border:
                              //                 Border.all(color: Colors.black),
                              //             borderRadius: BorderRadius.all(
                              //                 Radius.circular(10))),
                              //         child: Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             ExpansionTile(
                              //               leading: const Icon(
                              //                   Icons.account_balance),
                              //               childrenPadding:
                              //                   const EdgeInsets.all(8.0),
                              //               title: const Text("Bank Details",
                              //                   style: const TextStyle(
                              //                       color: Colors.black,
                              //                       fontSize: 15,
                              //                       fontFamily:
                              //                           'Rubik Regular')),
                              //               children: [
                              //                 // Card(
                              //                 //   elevation: 10,
                              //                 //   shape: RoundedRectangleBorder(
                              //                 //       borderRadius:
                              //                 //           BorderRadius.circular(20)),
                              //                 //   child: ListTile(
                              //                 //     title: const Text("Bank Name",
                              //                 //         style: TextStyle(
                              //                 //             color: Colors.grey,
                              //                 //             fontSize: 15,
                              //                 //             fontFamily:
                              //                 //                 'Rubik Regular')),
                              //                 //     subtitle: Text(
                              //                 //         item.bankName.toString(),
                              //                 //         style: const TextStyle(
                              //                 //             color: Colors.black,
                              //                 //             fontSize: 18,
                              //                 //             fontFamily:
                              //                 //                 'Rubik Regular')),
                              //                 //   ),
                              //                 // ),
                              //
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.start,
                              //                   children: [
                              //                     Text("Bank Name",
                              //                         style: TextStyle(
                              //                             color: Colors.grey,
                              //                             fontSize: 15,
                              //                             fontFamily:
                              //                                 'Rubik Regular')),
                              //                   ],
                              //                 ),
                              //                 SizedBox(
                              //                   height: 5,
                              //                 ),
                              //                 Container(
                              //                   padding: EdgeInsets.symmetric(
                              //                       vertical: 10,
                              //                       horizontal: 10),
                              //                   width: MediaQuery.of(context)
                              //                       .size
                              //                       .width,
                              //                   decoration: BoxDecoration(
                              //                       border: Border.all(
                              //                         color: Colors.black,
                              //                       ),
                              //                       borderRadius:
                              //                           BorderRadius.all(
                              //                               Radius.circular(
                              //                                   10))),
                              //                   child: Text(
                              //                     item.bankName.toString(),
                              //                     style: const TextStyle(
                              //                         color: Colors.black,
                              //                         fontSize: 18,
                              //                         fontFamily:
                              //                             'Rubik Regular'),
                              //                   ),
                              //                 ),
                              //
                              //                 SizedBox(
                              //                   height: 10,
                              //                 ),
                              //                 // Card(
                              //                 //   elevation: 10,
                              //                 //   shape: RoundedRectangleBorder(
                              //                 //       borderRadius:
                              //                 //           BorderRadius.circular(20)),
                              //                 //   child: ListTile(
                              //                 //     title: const Text(
                              //                 //         "Account Number",
                              //                 //         style: TextStyle(
                              //                 //             color: Colors.grey,
                              //                 //             fontSize: 15,
                              //                 //             fontFamily:
                              //                 //                 'Rubik Regular')),
                              //                 //     subtitle: Text(
                              //                 //         item.bankAccountNumber
                              //                 //             .toString(),
                              //                 //         style: const TextStyle(
                              //                 //             color: Colors.black,
                              //                 //             fontSize: 18,
                              //                 //             fontFamily:
                              //                 //                 'Rubik Regular')),
                              //                 //   ),
                              //                 // ),
                              //
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.start,
                              //                   children: [
                              //                     Text("Account Number",
                              //                         style: TextStyle(
                              //                             color: Colors.grey,
                              //                             fontSize: 15,
                              //                             fontFamily:
                              //                                 'Rubik Regular')),
                              //                   ],
                              //                 ),
                              //                 SizedBox(
                              //                   height: 5,
                              //                 ),
                              //                 Container(
                              //                   padding: EdgeInsets.symmetric(
                              //                       vertical: 10,
                              //                       horizontal: 10),
                              //                   width: MediaQuery.of(context)
                              //                       .size
                              //                       .width,
                              //                   decoration: BoxDecoration(
                              //                       border: Border.all(
                              //                         color: Colors.black,
                              //                       ),
                              //                       borderRadius:
                              //                           BorderRadius.all(
                              //                               Radius.circular(
                              //                                   10))),
                              //                   child: Text(
                              //                     item.bankAccountNumber
                              //                         .toString(),
                              //                     style: const TextStyle(
                              //                         color: Colors.black,
                              //                         fontSize: 18,
                              //                         fontFamily:
                              //                             'Rubik Regular'),
                              //                   ),
                              //                 ),
                              //
                              //                 SizedBox(
                              //                   height: 10,
                              //                 ),
                              //                 // Card(
                              //                 //   elevation: 10,
                              //                 //   shape: RoundedRectangleBorder(
                              //                 //       borderRadius:
                              //                 //           BorderRadius.circular(20)),
                              //                 //   child: ListTile(
                              //                 //     title: const Text("IFSC Code",
                              //                 //         style: TextStyle(
                              //                 //             color: Colors.grey,
                              //                 //             fontSize: 15,
                              //                 //             fontFamily:
                              //                 //                 'Rubik Regular')),
                              //                 //     subtitle: Text(
                              //                 //         item.bankIfsc.toString(),
                              //                 //         style: const TextStyle(
                              //                 //             color: Colors.black,
                              //                 //             fontSize: 18,
                              //                 //             fontFamily:
                              //                 //                 'Rubik Regular')),
                              //                 //   ),
                              //                 // ),
                              //
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.start,
                              //                   children: [
                              //                     Text("IFSC Code",
                              //                         style: TextStyle(
                              //                             color: Colors.grey,
                              //                             fontSize: 15,
                              //                             fontFamily:
                              //                                 'Rubik Regular')),
                              //                   ],
                              //                 ),
                              //                 SizedBox(
                              //                   height: 5,
                              //                 ),
                              //                 Container(
                              //                   padding: EdgeInsets.symmetric(
                              //                       vertical: 10,
                              //                       horizontal: 10),
                              //                   width: MediaQuery.of(context)
                              //                       .size
                              //                       .width,
                              //                   decoration: BoxDecoration(
                              //                       border: Border.all(
                              //                         color: Colors.black,
                              //                       ),
                              //                       borderRadius:
                              //                           BorderRadius.all(
                              //                               Radius.circular(
                              //                                   10))),
                              //                   child: Text(
                              //                     item.bankIfsc.toString(),
                              //                     style: const TextStyle(
                              //                         color: Colors.black,
                              //                         fontSize: 18,
                              //                         fontFamily:
                              //                             'Rubik Regular'),
                              //                   ),
                              //                 ),
                              //
                              //                 SizedBox(
                              //                   height: 10,
                              //                 ),
                              //                 // Card(
                              //                 //   elevation: 10,
                              //                 //   shape: RoundedRectangleBorder(
                              //                 //       borderRadius:
                              //                 //           BorderRadius.circular(20)),
                              //                 //   child: ListTile(
                              //                 //     title: const Text("Branch",
                              //                 //         style: TextStyle(
                              //                 //             color: Colors.grey,
                              //                 //             fontSize: 15,
                              //                 //             fontFamily:
                              //                 //                 'Rubik Regular')),
                              //                 //     subtitle: Text(
                              //                 //         item.bankBranchName
                              //                 //             .toString(),
                              //                 //         style: const TextStyle(
                              //                 //             color: Colors.black,
                              //                 //             fontSize: 18,
                              //                 //             fontFamily:
                              //                 //                 'Rubik Regular')),
                              //                 //   ),
                              //                 // ),
                              //
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.start,
                              //                   children: [
                              //                     Text("Branch",
                              //                         style: TextStyle(
                              //                             color: Colors.grey,
                              //                             fontSize: 15,
                              //                             fontFamily:
                              //                                 'Rubik Regular')),
                              //                   ],
                              //                 ),
                              //                 SizedBox(
                              //                   height: 5,
                              //                 ),
                              //                 Container(
                              //                   padding: EdgeInsets.symmetric(
                              //                       vertical: 10,
                              //                       horizontal: 10),
                              //                   width: MediaQuery.of(context)
                              //                       .size
                              //                       .width,
                              //                   decoration: BoxDecoration(
                              //                       border: Border.all(
                              //                         color: Colors.black,
                              //                       ),
                              //                       borderRadius:
                              //                           BorderRadius.all(
                              //                               Radius.circular(
                              //                                   10))),
                              //                   child: Text(
                              //                     item.bankBranchName
                              //                         .toString(),
                              //                     style: const TextStyle(
                              //                         color: Colors.black,
                              //                         fontSize: 18,
                              //                         fontFamily:
                              //                             'Rubik Regular'),
                              //                   ),
                              //                 ),
                              //
                              //                 SizedBox(
                              //                   height: 10,
                              //                 ),
                              //                 // Card(
                              //                 //   elevation: 10,
                              //                 //   shape: RoundedRectangleBorder(
                              //                 //       borderRadius:
                              //                 //           BorderRadius.circular(20)),
                              //                 //   child: ListTile(
                              //                 //     title: const Text(
                              //                 //         "Account Holder Name",
                              //                 //         style: TextStyle(
                              //                 //             color: Colors.grey,
                              //                 //             fontSize: 15,
                              //                 //             fontFamily:
                              //                 //                 'Rubik Regular')),
                              //                 //     subtitle: Text(
                              //                 //         item.name.toString(),
                              //                 //         style: const TextStyle(
                              //                 //             color: Colors.black,
                              //                 //             fontSize: 18,
                              //                 //             fontFamily:
                              //                 //                 'Rubik Regular')),
                              //                 //   ),
                              //                 // ),
                              //
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.start,
                              //                   children: [
                              //                     Text("Account Holder Name",
                              //                         style: TextStyle(
                              //                             color: Colors.grey,
                              //                             fontSize: 15,
                              //                             fontFamily:
                              //                                 'Rubik Regular')),
                              //                   ],
                              //                 ),
                              //                 SizedBox(
                              //                   height: 5,
                              //                 ),
                              //                 Container(
                              //                   padding: EdgeInsets.symmetric(
                              //                       vertical: 10,
                              //                       horizontal: 10),
                              //                   width: MediaQuery.of(context)
                              //                       .size
                              //                       .width,
                              //                   decoration: BoxDecoration(
                              //                       border: Border.all(
                              //                         color: Colors.black,
                              //                       ),
                              //                       borderRadius:
                              //                           BorderRadius.all(
                              //                               Radius.circular(
                              //                                   10))),
                              //                   child: Text(
                              //                     item.bankAccountHolderName
                              //                         .toString(),
                              //                     style: const TextStyle(
                              //                         color: Colors.black,
                              //                         fontSize: 18,
                              //                         fontFamily:
                              //                             'Rubik Regular'),
                              //                   ),
                              //                 ),
                              //
                              //                 SizedBox(
                              //                   height: 10,
                              //                 ),
                              //                 // Card(
                              //                 //   elevation: 10,
                              //                 //   shape: RoundedRectangleBorder(
                              //                 //       borderRadius:
                              //                 //           BorderRadius.circular(20)),
                              //                 //   child: Padding(
                              //                 //     padding:
                              //                 //         const EdgeInsets.symmetric(
                              //                 //             vertical: 10),
                              //                 //     child: ListTile(
                              //                 //       title: const Text(
                              //                 //           "Bank Address",
                              //                 //           style: TextStyle(
                              //                 //               color: Colors.grey,
                              //                 //               fontSize: 15,
                              //                 //               fontFamily:
                              //                 //                   'Rubik Regular')),
                              //                 //       subtitle: Text(
                              //                 //           item.bankBranchAddress
                              //                 //               .toString(),
                              //                 //           style: const TextStyle(
                              //                 //               color: Colors.black,
                              //                 //               fontSize: 18,
                              //                 //               fontFamily:
                              //                 //                   'Rubik Regular')),
                              //                 //     ),
                              //                 //   ),
                              //                 // ),
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.start,
                              //                   children: [
                              //                     Text("Bank Address",
                              //                         style: TextStyle(
                              //                             color: Colors.grey,
                              //                             fontSize: 15,
                              //                             fontFamily:
                              //                                 'Rubik Regular')),
                              //                   ],
                              //                 ),
                              //                 SizedBox(
                              //                   height: 5,
                              //                 ),
                              //                 Container(
                              //                   padding: EdgeInsets.symmetric(
                              //                       vertical: 10,
                              //                       horizontal: 10),
                              //                   width: MediaQuery.of(context)
                              //                       .size
                              //                       .width,
                              //                   decoration: BoxDecoration(
                              //                       border: Border.all(
                              //                         color: Colors.black,
                              //                       ),
                              //                       borderRadius:
                              //                           BorderRadius.all(
                              //                               Radius.circular(
                              //                                   10))),
                              //                   child: Text(
                              //                     item.bankBranchAddress
                              //                         .toString(),
                              //                     style: const TextStyle(
                              //                         color: Colors.black,
                              //                         fontSize: 18,
                              //                         fontFamily:
                              //                             'Rubik Regular'),
                              //                   ),
                              //                 ),
                              //
                              //                 SizedBox(
                              //                   height: 10,
                              //                 ),
                              //               ],
                              //             ),
                              //           ],
                              //         ),
                              //       )
                              //     : SizedBox()
                            ],
                          ),
                        ),
                      ],
                    )),
                  );
                }
                return const Center(child: Text("no data"));
              }),
    );
  }

  Future<UserEditInfo?> getUserInfo() async {
    // Base URL
    var baseurl = EnvConfigs.appBaseUrl+"user/edit";

    Dio dio = Dio();

    // final prefs = await SharedPreferences.getInstance();

    // var id = prefs.getString("_id");
    // final userId = id;

    // print("userId");
    // print(userId);

    var formData = FormData.fromMap({
      'user_id': user_id,
    });

    try {
      Response response = await dio.post(
        baseurl,
        options: Options(headers: {'x-access-token': userToken}),
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

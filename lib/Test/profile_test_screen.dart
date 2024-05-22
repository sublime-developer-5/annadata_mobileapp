import 'package:annadata/Model/user_edit_info_model.dart';
import 'package:annadata/Test/profile_edit_page.dart';
import 'package:annadata/screens/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../env.dart';

class ProfileTestScreen extends StatefulWidget {
  const ProfileTestScreen({Key? key}) : super(key: key);

  @override
  State<ProfileTestScreen> createState() => _ProfileTestScreenState();
}

class _ProfileTestScreenState extends State<ProfileTestScreen> {
  var user_id;

  getID() async {
    final prefs = await SharedPreferences.getInstance();

    var id = prefs.getString("_id");

    setState(() {
      user_id = id;
    });
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

    Future.delayed(const Duration(seconds: 2),
        () => user_id == null ? navigation() : null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user_id == null
          ? LoginPage()
          // ? const Center(
          //     child: const Text(
          //       "No user found",
          //       style: TextStyle(fontFamily: 'Rubik Regular', fontSize: 25),
          //     ),
          //   )
          : FutureBuilder<UserEditInfo?>(
              future: getUserInfo(),
              builder: (context, snapshot) {
                print("snapshot1");
                // print(snapshot.data!.success);
                var item = snapshot.data?.data![0];
                if (!snapshot.hasData) {
                  return const Scaffold(
                      body: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error"));
                }
                if (snapshot.hasData) {
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      centerTitle: true,
                      leading: BackButton(
                        color: Colors.orange,
                        onPressed: (() {
                          Navigator.pop(context);
                        }),
                      ),
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
                                      item!.profilePhoto.toString(),
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
                            children: [
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                  title: const Text("Name",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontFamily: 'Rubik Regular')),
                                  subtitle: Text(
                                    item.name.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Rubik Regular'),
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                  title: const Text("Email ID",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontFamily: 'Rubik Regular')),
                                  subtitle: Text(item.emailId.toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontFamily: 'Rubik Regular')),
                                ),
                              ),
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                  title: const Text("Mobile Number",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontFamily: 'Rubik Regular')),
                                  subtitle: Text(item.mobileNo.toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontFamily: 'Rubik Regular')),
                                ),
                              ),
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                  title: const Text("Date of Birth",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontFamily: 'Rubik Regular')),
                                  subtitle: const Text("userDOB",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontFamily: 'Rubik Regular')),
                                ),
                              ),
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                  title: const Text("Gender",
                                      // ignore: unnecessary_const
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontFamily: 'Rubik Regular')),
                                  subtitle: Text(item.gender.toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontFamily: 'Rubik Regular')),
                                ),
                              ),
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  // ignore: unnecessary_const
                                  child: ListTile(
                                    title: const Text("Address",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontFamily: 'Rubik Regular')),
                                    subtitle: Text(
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
                                            fontFamily: 'Rubik Regular')),
                                  ),
                                ),
                              ),
                              Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: ExpansionTile(
                                      leading: const Icon(Icons.badge),
                                      childrenPadding: const EdgeInsets.all(10),
                                      title: const Text(
                                        "ID Proof's",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontFamily: 'Rubik Regular'),
                                      ),
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: Image.network(
                                                  item.documentOne.toString()),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: Image.network(
                                                  item.documentTwo.toString()),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ExpansionTile(
                                  leading: const Icon(Icons.account_balance),
                                  childrenPadding: const EdgeInsets.all(8.0),
                                  title: const Text("Bank Details",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontFamily: 'Rubik Regular')),
                                  children: [
                                    Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ListTile(
                                        title: const Text("Account Number",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15,
                                                fontFamily: 'Rubik Regular')),
                                        subtitle: Text(
                                            item.bankAccountNumber.toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontFamily: 'Rubik Regular')),
                                      ),
                                    ),
                                    Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ListTile(
                                        title: const Text("IFSC Code",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15,
                                                fontFamily: 'Rubik Regular')),
                                        subtitle: Text(item.bankIfsc.toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontFamily: 'Rubik Regular')),
                                      ),
                                    ),
                                    Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ListTile(
                                        title: const Text("Branch",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15,
                                                fontFamily: 'Rubik Regular')),
                                        subtitle: Text(
                                            item.bankBranchName.toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontFamily: 'Rubik Regular')),
                                      ),
                                    ),
                                    Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ListTile(
                                        title: const Text("Account Holder Name",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15,
                                                fontFamily: 'Rubik Regular')),
                                        subtitle: Text(item.name.toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontFamily: 'Rubik Regular')),
                                      ),
                                    ),
                                    Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: ListTile(
                                          title: const Text("Bank Address",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontFamily: 'Rubik Regular')),
                                          subtitle: Text(
                                              item.bankBranchAddress.toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontFamily: 'Rubik Regular')),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
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
        data: formData,
      );

      // Data res = Data.fromJson(response.data);
      UserEditInfo res = UserEditInfo.fromJson(response.data);

      // var res = jsonDecode(response.data);

      // print(res.success);

      return res;
    } on DioError catch (e) {
      print(e);
    }
    return UserEditInfo();
  }
}

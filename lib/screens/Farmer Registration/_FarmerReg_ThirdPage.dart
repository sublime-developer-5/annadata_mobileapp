import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:annadata/Model/registerRes.dart';
import 'package:annadata/widgets/TextInputFormater/forFirstLetterUppercaseOfEachWord.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../env.dart';

class FarmerRegThirdPage extends StatefulWidget {
  const FarmerRegThirdPage({Key? key}) : super(key: key);

  @override
  State<FarmerRegThirdPage> createState() => _FarmerRegThirdPageState();
}

class _FarmerRegThirdPageState extends State<FarmerRegThirdPage> {
  final _formKey = GlobalKey<FormState>(); // declare a GlobalKey

  TextEditingController accountController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController bankAccountholderNameController =
      TextEditingController();
  TextEditingController bankAddController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();

  String? profileImg;
  String? fname;
  String? email;
  String? countryCode;
  String? mobileNo;
  String? password;
  String? dob;
  String? gender;
  String? addressFarmer;
  String? stateId;
  String? districtId;
  String? cityId;
  String? pincode;
  String? doc1;
  String? doc2;
  String? message;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList('registerItem1');
    final List<String>? items2 = prefs.getStringList('registerItem2');
    log("Saved Item List");
    setState(() {
      fname = items![1];
      profileImg = items[0];
      email = items[2];
      countryCode = items[3];
      mobileNo = items[4];
      password = items[5];
      dob = items[6];
      gender = items[7];
      addressFarmer = items[8];
      stateId = items2![0];
      districtId = items2[1];
      cityId = items2[2];
      pincode = items2[3];
      doc1 = items2[4];
      doc2 = items2[5];
    });
    log(items![0]);
    log(items[1]);
    log(items[2]);
    log(items[3]);
    log(items[4]);
    log(items[5]);
    log(items[6]);
    log(items[7]);
    log(items[8]);
    log(items2![0]);
    log(items2[1]);
    log(items2[2]);
    log(items2[3]);
    log(items2[4]);
    log(items2[5]);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Farmer Registration'),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.verified_user,
                        color: Colors.green,
                      ),
                    ),
                    Container(
                      height: 2,
                      width: 40,
                      color: Colors.green,
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.home_sharp,
                        color: Colors.green,
                      ),
                    ),
                    Container(
                      height: 2,
                      width: 40,
                      color: Colors.green,
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.account_balance_sharp,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange),
                  borderRadius: const BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20)),
                ),
              ),
              const SizedBox(height: 15),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Bank details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),

                      const SizedBox(height: 10),

                      TextFormField(
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                        controller: bankNameController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
                        ],

                        // style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            hintText: 'Bank Name',
                            // hintStyle: TextStyle(fontSize: 18),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.green))),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return '*Required';
                          } else
                            return null;
                        },
                      ), //Bank Name

                      const SizedBox(height: 10),

                      TextFormField(
                        maxLength: 25,
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                        controller: accountController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        // style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            hintText: 'Account Number',
                            // hintStyle: TextStyle(fontSize: 18),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.green))),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return '*Required';
                          } else
                            return null;
                        },
                      ), //Account Number

                      const SizedBox(height: 10),

                      TextFormField(
                        onChanged: (value) {
                          ifscController.value = TextEditingValue(
                              text: value.toUpperCase(),
                              selection: ifscController.selection);
                          _formKey.currentState!.validate();
                        },
                        controller: ifscController,
                        maxLength: 15,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
                        ],
                        // style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            hintText: 'IFSC Code',
                            // hintStyle: TextStyle(fontSize: 18),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.green))),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return '*Required';
                          } else if (text.length < 11) {
                            return 'Enter Valid IFSC Code';
                          } else
                            return null;
                        },
                      ), //IFSC code

                      const SizedBox(height: 10),
                      TextFormField(
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                        controller: branchController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
                        ],
                        //  style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            hintText: 'Branch Name',
                            // hintStyle: TextStyle(fontSize: 18),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.green))),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return '*Required';
                          } else
                            return null;
                        },
                      ), //Branch

                      const SizedBox(height: 10),

                      TextFormField(
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                        controller: bankAccountholderNameController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
                          UpperCaseTextFormatter()
                        ],
                        // style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            hintText: 'Account Holder Name',
                            //  hintStyle: TextStyle(fontSize: 18),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.green))),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return '*Required';
                          } else if (text.length < 4) {
                            return 'Too short';
                          } else
                            return null;
                        },
                      ), //Account Holder name

                      const SizedBox(height: 10),

                      TextFormField(
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                        controller: bankAddController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
                        ],
                        // style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            hintText: 'Bank Address',
                            // hintStyle: TextStyle(fontSize: 18),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.green))),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return '*Required';
                          } else if (text.length < 4) {
                            return 'Too short';
                          } else
                            return null;
                        },
                      ), //Bank Address

                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 45,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    uploadData();

                                    // Navigator.pushNamed(context,
                                    //     'registrationFarmer_SecondPage');
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.orange),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)))),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 21),
                                )),
                          ), //Proceed Button

                          SizedBox(
                            width: 150,
                            height: 45,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, 'registrationFarmer_SecondPage');
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.grey),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)))),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 21),
                                )),
                          ), //Cancel Button
                        ],
                      ) //Buttons
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Register API
  Future<void> uploadData() async {
    var formData = FormData.fromMap({
      'profile_photo': profileImg == ""
          ? ""
          : await MultipartFile.fromFile(profileImg.toString()),
      'name': fname,
      'email_id': email,
      'password': password,
      'mobile_no': mobileNo,
      'gender': gender,
      'address': addressFarmer,
      'role': 'farmer',
      'bank_name': bankNameController.text,
      'bank_ifsc': ifscController.text,
      'bank_account_number': accountController.text,
      'account_holder_name': bankAccountholderNameController.text,
      'bank_branch_name': branchController.text,
      'bank_branch_address': bankAddController.text,
      'document_one': await MultipartFile.fromFile(doc1.toString()),
      'document_two': await MultipartFile.fromFile(doc2.toString()),
      'state_id': stateId,
      'district_id': districtId,
      'city_id': cityId,
      'pincode': pincode
    });

    try {
      final Map<String, String> headers = {};
      Dio dio = Dio();
      final response = await dio
          .post(EnvConfigs.appBaseReg+"register/farmer", data: formData);
      String strTemp = response.toString();
      final res = response;

      final String? resMessage = RegisterRes.fromJson(response.data).message;
      final bool? success = RegisterRes.fromJson(response.data).success;

      // Showing message response

      final snackBar = SnackBar(
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        content: Text(
          resMessage.toString(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if (success == true) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamedAndRemoveUntil(
              context, 'loginPage', (Route route) => false);
        });
      }

      log("Message");
      log(resMessage.toString());

      debugPrint("strTemp");
      debugPrint(strTemp);
      debugPrint("res");
      debugPrint(res.toString());
    } catch (e) {
      print('e');
      print(e);
    }
  }
}

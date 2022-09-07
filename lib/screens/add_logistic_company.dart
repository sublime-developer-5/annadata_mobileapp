import 'dart:developer';

import 'package:annadata/Model/logistics_MyCompanyModel.dart';
import 'package:annadata/widgets/HomeScreen/homeBottumNavBar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/registerRes.dart';

class AddLogisticCompany extends StatefulWidget {
  const AddLogisticCompany({Key? key}) : super(key: key);

  @override
  State<AddLogisticCompany> createState() => _AddLogisticCompanyState();
}

class _AddLogisticCompanyState extends State<AddLogisticCompany> {
  final _formKey = GlobalKey<FormState>(); // declare a GlobalKey

  String _countryCode = "+91";
  String? userId;
  String? userRole;
  String? logisticId;

  TextEditingController companyNameController = TextEditingController();
  TextEditingController spocNameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController pincodController = TextEditingController();

  getUserID() async {
    final prefs = await SharedPreferences.getInstance();

    var getuserId = prefs.getString("_id");
    var role = prefs.getString("userRole");

    setState(() {
      userId = getuserId;
      userRole = role;
    });

    log("getData");

    log(userRole.toString());
    log(userId.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserID();
    Future.delayed(Duration(milliseconds: 500), () => getMyCompanyInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottumNavBar(pageIndex: 0),
                    ));
              },
            ),
            title: Text("My Company")),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Company Name",
                style: TextStyle(
                  fontFamily: 'Rubik Regular',
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                // maxLength: 200,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
                ],
                controller: companyNameController,
                //style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Colors.orange)),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                    hintText: 'Company Name',
                    // hintStyle: TextStyle(fontSize: 18),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Colors.orange)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Colors.green))),
                onChanged: (value) {
                  _formKey.currentState!.validate();
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return '*Required';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Spoc Name",
                style: TextStyle(
                  fontFamily: 'Rubik Regular',
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                // maxLength: 200,
                controller: spocNameController,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
                ],
                //style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Colors.orange)),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                    hintText: 'Spoc Name',
                    // hintStyle: TextStyle(fontSize: 18),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Colors.orange)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Colors.green))),
                onChanged: (value) {
                  _formKey.currentState!.validate();
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return '*Required';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Mobile Number",
                style: TextStyle(
                  fontFamily: 'Rubik Regular',
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 48,
                    width: 80,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25)),
                    ),
                    child: DropdownButtonFormField(
                        elevation: 0,
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          enabledBorder: InputBorder.none,
                        ),
                        isExpanded: true,
                        value: _countryCode,
                        items: _countryCodeList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _countryCode = newValue!;
                          });
                        }),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: TextFormField(
                        onChanged: (text) {
                          _formKey.currentState!.validate();
                        },
                        controller: contactNoController,
                        maxLength: 15,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp("^[0-5]{1}")),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        //  style: TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25),
                                    bottomRight: Radius.circular(25)),
                                borderSide: BorderSide(color: Colors.orange)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            hintText: 'Mobile Number',
                            // hintStyle: TextStyle(fontSize: 20),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25),
                                    bottomRight: Radius.circular(25)),
                                borderSide: BorderSide(color: Colors.orange)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25),
                                    bottomRight: Radius.circular(25)),
                                borderSide: BorderSide(color: Colors.green))),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return '*Required\n*Mobile number should be start from 6-9';
                          } else if (text.length < 10) {
                            return 'Enter valid mobile number';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ), //Mobile Number
              SizedBox(
                height: 20,
              ),
              Text(
                "Pincode",
                style: TextStyle(
                  fontFamily: 'Rubik Regular',
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: pincodController,
                maxLength: 6,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                //style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Colors.orange)),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                    hintText: 'Enter Pincode',
                    // hintStyle: TextStyle(fontSize: 18),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Colors.orange)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Colors.green))),
                onChanged: (text) {
                  _formKey.currentState!.validate();
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return '*Required';
                  } else if (text.length != 6) {
                    return 'Pincode is not valid';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logisticId == null
                      ? ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              addNewLogisticCompanyData();
                            }
                          },
                          child: Text("Submit"))
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              uploadLogisticCompanyData();
                            }
                          },
                          child: Text("Save Changes"))
                ],
              ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width / 2,
              //   child: ElevatedButton(
              //       onPressed: () {
              //         showDialog(
              //             context: context,
              //             builder: (context) {
              //               return Dialog(
              //                 child: Container(
              //                   padding: const EdgeInsets.all(20),
              //                   child: SingleChildScrollView(
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.center,
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       children: [],
              //                     ),
              //                   ),
              //                 ),
              //               );
              //             });
              //       },
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [Text("ADD Company"), Icon(Icons.add)],
              //       )),
              // ),
            ],
          ),
        )),
      ),
    );
  }

  List<DropdownMenuItem<String>> _countryCodeList() {
    List<String> regList = ["+91", "+62", "+870", "+800", "+93", "+54"];
    return regList
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  // Register API Add Product

  //Add

  Future<void> addNewLogisticCompanyData() async {
    var formData = FormData.fromMap({
      'user_id': userId,
      'logistics_name': companyNameController.text,
      'logistics_spoc': spocNameController.text,
      'logistics_contact': contactNoController.text,
      'logistics_from_pincode': pincodController.text
    });

    try {
      final Map<String, String> headers = {};
      Dio dio = Dio();
      final response = await dio.post(
          "http://161.97.138.56:3021/mobile/logistic/add",
          data: formData);

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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddLogisticCompany(),
              ));
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

  //Update Logistic data

  Future<void> uploadLogisticCompanyData() async {
    var formData = FormData.fromMap({
      'logistics_id': logisticId,
      'user_id': userId,
      'logistics_name': companyNameController.text,
      'logistics_spoc': spocNameController.text,
      'logistics_contact': contactNoController.text,
      'logistics_from_pincode': pincodController.text
    });

    try {
      final Map<String, String> headers = {};
      Dio dio = Dio();
      final response = await dio.post(
          "http://161.97.138.56:3021/mobile/logistic/update",
          data: formData);

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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddLogisticCompany(),
              ));
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

  Future<List<MyCompanyData>?> getMyCompanyInfo() async {
    // Base URL
    var user_id_val = userId.toString();
    debugPrint(user_id_val);
    var baseurl =
        "http://161.97.138.56:3021/mobile/logistic/list?user_id=$user_id_val";

    Dio dio = Dio();

    try {
      Response response = await dio.get(baseurl);
      LogisticsMyCompanyGetInfoModel res =
          LogisticsMyCompanyGetInfoModel.fromJson(response.data);

      setState(() {
        companyNameController.text = res.data![0].logisticsName.toString();
        spocNameController.text = res.data![0].logisticsSpoc.toString();
        contactNoController.text = res.data![0].logisticsContact.toString();
        pincodController.text = res.data![0].logisticsFromPincode.toString();
        logisticId = res.data![0].logisticsId.toString();
      });

      // var resData = jsonDecode(res.toString());
      // debugPrint(resData);

      debugPrint("*******productId*****");
      debugPrint(res.data.toString());
      debugPrint("*******LogisticId*****");
      debugPrint(logisticId);

      print(res.data);

      return res.data;
    } on DioError catch (e) {
      print(e);
    }
    return null;
  }
}

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/modelCityList.dart';
import '../../Model/modelDistrictList.dart';
import '../../Model/modelStateList.dart';
import '../../Model/registerRes.dart';
import '../../env.dart';

class TraderRegSecondPage extends StatefulWidget {
  const TraderRegSecondPage({Key? key}) : super(key: key);

  @override
  State<TraderRegSecondPage> createState() => _TraderRegSecondPageState();
}

class _TraderRegSecondPageState extends State<TraderRegSecondPage> {
  List<Data>? resStateList = [];
  List<DistrictData>? resDistList = [];
  List<CityData>? resCity = [];
  String? profileImg;
  String? fname;
  String? email;
  String? countryCode;
  String? mobileNo;
  String? password;
  String? dob;
  String? gender;
  String? address;
  String? _Select_State;
  String? _Select_District;
  String? _Select_City;

  String? _fileName = "UPLOAD DOCUMENT";
  String? _fileName2 = "UPLOAD DOCUMENT";
  String? filepath1;
  String? filepath2;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _statekey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _districtkey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _citykey = GlobalKey<FormFieldState>();

  TextEditingController pincode = TextEditingController();

  @override
  void initState() {
    getStateList();
    super.initState();
    getData();
  }

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList('registerItemTrader1');
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
      address = items[8];
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
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Trader Registration'),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
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
                      child: Icon(
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
                      child: Icon(
                        Icons.home_sharp,
                        color: Colors.orange,
                      ),
                    ),
                    // Container(
                    //   height: 2,
                    //   width: 40,
                    //   color: Colors.orange,
                    // ),
                    // Container(
                    //   width: 40,
                    //   height: 40,
                    //   decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.orange, width: 2),
                    //       shape: BoxShape.circle),
                    //   child: Icon(
                    //     Icons.account_balance_sharp,
                    //     color: Colors.orange,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Address',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),

                      SizedBox(height: 10),

                      DropdownButtonFormField2(
                        buttonStyleData: ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 45,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 350,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                        ),
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.green)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                                borderRadius: BorderRadius.circular(25))),
                        isExpanded: true,
                        key: _statekey,
                        hint: Text('Select State'),
                        items: resStateList!
                            .map((lable) => DropdownMenuItem(
                                  child: Text(lable.stateName.toString()),
                                  value: lable.stateId,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _citykey.currentState!.reset();
                            _districtkey.currentState!.reset();
                            resDistList = [];
                            resCity = [];
                            _Select_State = value.toString();
                          });
                          _formKey.currentState!.validate();
                          getDistrictList();
                          print("State ID");
                          print(_Select_State);
                          print("district_id ID");
                          print(_Select_District);
                        },
                        validator: (value) =>
                            value == null ? 'Select state required' : null,
                      ), //Select State

                      SizedBox(height: 10),

                      DropdownButtonFormField2(
                        buttonStyleData: ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 45,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 350,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                        ),
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.green)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                                borderRadius: BorderRadius.circular(25))),
                        isExpanded: true,
                        key: _districtkey,
                        hint: Text('Select District'),
                        items: resDistList!
                            .map((lable) => DropdownMenuItem(
                                  child: Text(lable.districtName.toString()),
                                  value: lable.districtId,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            resCity = [];
                            _Select_District = value.toString();
                          });
                          _citykey.currentState!.reset();
                          _formKey.currentState!.validate();
                          print("district_id");
                          print(_Select_District);

                          getCitytList();
                        },
                        validator: (value) =>
                            value == null ? '*Select district required' : null,
                      ), //Select District

                      SizedBox(height: 10),

                      DropdownButtonFormField2(
                        buttonStyleData: ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 45,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 350,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                        ),
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.green)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                                borderRadius: BorderRadius.circular(25))),
                        isExpanded: true,
                        key: _citykey,
                        hint: Text('Select City / Village'),
                        items: resCity!
                            .map((lable) => DropdownMenuItem(
                                  child: Text(lable.cityName.toString()),
                                  value: lable.cityId,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _Select_City = value.toString();
                          });
                          _formKey.currentState!.validate();
                          log(_Select_City.toString());
                        },
                        validator: (value) =>
                            value == null ? '*Select city required' : null,
                      ), //Select City

                      SizedBox(height: 10),

                      TextFormField(
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        // style: TextStyle(fontSize: 18),
                        controller: pincode,
                        decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.orange)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            hintText: 'Pincode',
                            // hintStyle: TextStyle(fontSize: 18),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.orange)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.green))),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return '*Required';
                          } else if (text.length != 6) {
                            return 'Pincode is Not Valid';
                          } else
                            return null;
                        },
                      ), //Pincode

                      SizedBox(height: 10),

                      Text(
                        'Upload Passbook Front Page / Cancelled Cheque',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),

                      SizedBox(height: 10),

                      TextFormField(
                        readOnly: true,
                        // style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.orange)),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.folder),
                              onPressed: () async {
                                print(
                                    '++++++++++++++++++++++++++++++++++++++++onpress+++++++++++++++++++++');
                                final result =
                                    await FilePicker.platform.pickFiles();
                                if (result == null) return;

                                final file = result.files.first;

                                //openFile(file);

                                // print('*************************************************************************');

                                print('${file.path}');
                                print(file.name);
                                setState(() {
                                  _fileName = file.name;
                                  filepath1 = file.path;
                                });
                              },
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            hintText: _fileName.toString(),
                            // hintStyle: TextStyle(fontSize: 18),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.orange)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.green))),
                        validator: (_filename) {
                          if (_fileName == "UPLOAD DOCUMENT") {
                            return '*Upload document required';
                          } else
                            return null;
                        },
                      ), //Document 1

                      SizedBox(height: 10),

                      Text(
                        'Upload Identity Proof (Adhaar card / Pan card / Voting card',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),

                      SizedBox(height: 10),

                      TextFormField(
                        readOnly: true,
                        // style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.orange)),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.folder),
                              onPressed: () async {
                                print(
                                    '++++++++++++++++++++++++++++++++++++++++onpress+++++++++++++++++++++');
                                final result =
                                    await FilePicker.platform.pickFiles();
                                if (result == null) return;

                                final file = result.files.first;

                                //openFile(file);

                                // print('*************************************************************************');

                                print('${file.path}');
                                print(file.name);
                                setState(() {
                                  _fileName2 = file.name;
                                  filepath2 = file.path;
                                });
                              },
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            hintText: _fileName2.toString(),
                            // hintStyle: TextStyle(fontSize: 18),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.orange)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.green))),
                        validator: (_filename) {
                          if (_fileName2 == "UPLOAD DOCUMENT") {
                            return '*Upload document required';
                          } else
                            return null;
                        },
                      ), //Document 2

                      SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 45,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    uploadTraderData();
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
                                  Navigator.pop(context);
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
                      ), //Buttons
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

  Future<void> getStateList() async {
    try {
      final Map<String, String> headers = {};
      Dio dio = Dio(BaseOptions(
          headers: headers, connectTimeout: 8000, receiveTimeout: 8000));
      final response =
          await dio.get("EnvConfigs.appBaseUrlstate/list");
      String strTemp = response.toString();
      final StateList stateList = StateList.fromJson(response.data);
      setState(() {
        resStateList = stateList.data!;
      });

      debugPrint(response.toString());
    } catch (e, s) {
      print(e);
    }
  }

  Future<void> getCitytList() async {
    try {
      final Map<String, String> headers = {};
      Dio dio = Dio(BaseOptions(
          headers: headers, connectTimeout: 8000, receiveTimeout: 8000));
      final response = await dio
          .post("EnvConfigs.appBaseUrlcity/list_by_district_id",
              //data: {"state_id": state_id});
              data: {"district_id": _Select_District.toString()});
      String strTemp = response.toString();
      final CityList citytList = CityList.fromJson(response.data);
      setState(() {
        resCity = citytList.data!;
      });

      print(response.toString());
    } catch (e, s) {
      print(e);
    }
  }

  Future<void> getDistrictList() async {
    try {
      final Map<String, String> headers = {};
      Dio dio = Dio(BaseOptions(headers: headers));
      final response = await dio.get(
          "EnvConfigs.appBaseUrldistrict/list_by_state_id?state_id=$_Select_State");
      String strTemp = response.toString();
      final DistrictList distList = DistrictList.fromJson(response.data);
      setState(() {
        resDistList = distList.data!;
      });

      log(strTemp);
    } catch (e) {
      log(e.toString());
    }
  }

  // Register API

  Future<void> uploadTraderData() async {
    log("filepath1");
    log(filepath1.toString());
    var formData = FormData.fromMap({
      'profile_photo': profileImg == ""
          ? ""
          : await MultipartFile.fromFile(profileImg.toString()),
      'name': fname,
      'email_id': email,
      'password': password,
      'mobile_no': mobileNo,
      'gender': gender,
      'address': address,
      'role': 'buyer',
      'document_one': await MultipartFile.fromFile(filepath1.toString(),
          filename: filepath1),
      'document_two': await MultipartFile.fromFile(filepath2.toString(),
          filename: filepath2),
      // 'document_two': await MultipartFile.fromFile(profileImg.toString()),

      'state_id': _Select_State,
      'district_id': _Select_District,
      'city_id': _Select_City,
      'pincode': pincode.text,
    });

    try {
      Dio dio = Dio();
      final response = await dio
          .post(EnvConfigs.appBaseReg+"register/buyer", data: formData);
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

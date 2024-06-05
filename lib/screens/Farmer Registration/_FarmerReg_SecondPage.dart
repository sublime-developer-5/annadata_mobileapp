import 'dart:developer';

import 'package:annadata/Model/modelCityList.dart';
import 'package:annadata/Model/modelDistrictList.dart';
import 'package:annadata/Model/modelStateList.dart';
import 'package:annadata/screens/Farmer%20Registration/_FarmerReg_ThirdPage.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/modelCityList.dart';
import '../../Model/registerRes.dart';
import '../../env.dart';

class FarmerRegSecondPage extends StatefulWidget {
  const FarmerRegSecondPage({Key? key}) : super(key: key);

  @override
  State<FarmerRegSecondPage> createState() => _FarmerRegSecondPageState();
}

class _FarmerRegSecondPageState extends State<FarmerRegSecondPage> {
  List<Data>? resStateList = [];
  List<DistrictData>? resDistList = [];
  List<CityData>? resCity = [];
  String? _Select_District;
  String? _Select_City;
  String? _Select_Village;
  String? _Select_Pincode;

  String? state_id;
  String? district_id = "";
  String? city_id;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _statekey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _districtkey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _citykey = GlobalKey<FormFieldState>();

  //String variable for selected File Name
  String? _fileName;
  String? _fileName2;

  //String variable for selected File Path
  String? filepath1;
  String? filepath2;

  // text Controller
  TextEditingController controllerDocument1 = TextEditingController();
  TextEditingController controllerDocument2 = TextEditingController();
  TextEditingController picodeController = TextEditingController();
  TextEditingController stateDropdownController = TextEditingController();

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
  String? doc1="";
  String? doc2="";
  String? message;

// Store Data
  void setData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      "registerItem2",
      [
        state_id.toString(),
        district_id.toString(),
        city_id.toString(),
        picodeController.text.toString(),
        filepath1.toString(),
        filepath2.toString(),
      ],
    );

    log(state_id.toString());
    log(district_id.toString());
    log(city_id.toString());
    log(picodeController.text.toString());
    log(filepath1.toString());
    log(filepath2.toString());
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
  void initState() {
    getData();
    getStateList();
    // getCitytList();
    super.initState();
    // getData();
    // setState(() {
    //   controllerDocument1.text = "Upload Document";
    //   controllerDocument2.text = "Upload Document";
    // });
    debugPrint("state_id*****");
    debugPrint(state_id.toString());
  }

  // void getData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final List<String>? items = prefs.getStringList('registerItem1');
  //   log("Saved Item List");
  //   log(items![0]);
  //   log(items[1]);
  //   log(items[2]);
  //   log(items[3]);
  //   log(items[4]);
  //   log(items[5]);
  //   log(items[6]);
  //   log(items[7]);
  // }

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
                    //   child: const Icon(
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
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Address',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),

                      const SizedBox(height: 10),

                      // State Dropdown

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
                        hint: const Text('Select State'),
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
                            state_id = value.toString();
                          });

                          _formKey.currentState!.validate();

                          getDistrictList();
                          print("State ID");
                          print(state_id);
                          print("district_id ID");
                          print(district_id);
                        },
                        validator: (value) =>
                            value == null ? '*Select state required' : null,
                      ), //Select State

                      const SizedBox(height: 10),

                      // District Dropdown

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
                        hint: const Text('Select District'),
                        items: resDistList!
                            .map((lable) => DropdownMenuItem(
                                  child: Text(lable.districtName.toString()),
                                  value: lable.districtId,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            resCity = [];
                            district_id = value.toString();
                          });
                          _citykey.currentState!.reset();
                          _formKey.currentState!.validate();
                          print("district_id");
                          print(district_id);
                          getCitytList();
                        },
                        validator: (value) =>
                            value == null ? '*Select district required' : null,
                      ),
                      const SizedBox(height: 10),

                      // City DropDown

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
                        // dropdownWidth: MediaQuery.of(context).size.width / 1.2,
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
                        hint: const Text('Select City / Village'),
                        items: resCity!
                            .map((lable) => DropdownMenuItem(
                                  child: Text(lable.cityName.toString()),
                                  value: lable.cityId,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            city_id = value.toString();
                          });

                          _formKey.currentState!.validate();
                        },
                        validator: (value) =>
                            value == null ? '*Select city required' : null,
                      ), //Select City
                      const SizedBox(height: 10),

                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: picodeController,
                        maxLength: 6,

                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        //style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            hintText: 'Enter Pincode',
                            // hintStyle: TextStyle(fontSize: 18),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.green))),
                        onChanged: (text) {
                          if (text != null) {
                            _formKey.currentState!.validate();
                          } else {
                            return null;
                          }
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

                      const SizedBox(height: 10),

                      const Text(
                        'Upload (Aadhar Card) (Optional)',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),

                      const SizedBox(height: 10),

                      TextFormField(
                        controller: controllerDocument1,
                        readOnly: true,
                        // style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.folder),
                              onPressed: () async {
                                final result =
                                    await FilePicker.platform.pickFiles();
                                if (result == null) return;

                                final file = result.files.first;

                                print('${file.path}');
                                print(file.name);
                                setState(() {
                                  _fileName = file.name;
                                  filepath1 = file.path;
                                  controllerDocument1.text =
                                      _fileName.toString();
                                });
                              },
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            hintText: "Upload document",
                            // hintStyle: TextStyle(fontSize: 18),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.green))),

                        onChanged: (text) {
                          _formKey.currentState!.validate();
                        },
                        validator: (text) {
                          // if (text == null || text.isEmpty) {
                          //   return '*Required';
                          // } else {
                          //   return null;
                          // }
                        },
                      ), //Document 1

                      const SizedBox(height: 10),

                      const Text(
                        'Upload (PAN Card) (Optional)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),

                      const SizedBox(height: 10),

                      TextFormField(
                        controller: controllerDocument2,
                        readOnly: true,
                        // style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.folder),
                              onPressed: () async {
                                print(
                                    '++++++++++++++++++++++++++++++++++++++++onpress+++++++++++++++++++++');
                                final result =
                                    await FilePicker.platform.pickFiles();
                                if (result == null) {
                                  return;
                                }
                                final file = result.files.first;

                                //openFile(file);

                                // print('*************************************************************************');

                                print('${file.path}');
                                print(file.name);
                                setState(() {
                                  _fileName2 = file.name;
                                  filepath2 = file.path;
                                  controllerDocument2.text =
                                      _fileName2.toString();
                                });
                                debugPrint(
                                    "********controllerDocument2.text*****");
                                debugPrint(controllerDocument2.text);
                              },
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            hintText: "Upload document",
                            // hintStyle: TextStyle(fontSize: 18),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.green))),
                        onChanged: (text) {
                          _formKey.currentState!.validate();
                        },
                        validator: (text) {
                          // if (text == null || text.isEmpty) {
                          //   return '*Required';
                          // } else {
                          //   return null;
                          // }
                        },
                      ), //Document 2

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
                                    setData();
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
                          ),
                          // SizedBox(
                          //   width: 150,
                          //   height: 45,
                          //   child: ElevatedButton(
                          //       onPressed: () {
                          //         if (_formKey.currentState!.validate()) {
                          //           setData();
                          //           Navigator.of(context).push(
                          //             MaterialPageRoute(
                          //               builder: (_) =>
                          //                   const FarmerRegThirdPage(),
                          //             ),
                          //           );
                          //         }
                          //       },
                          //       style: ButtonStyle(
                          //           shape: MaterialStateProperty.all<
                          //                   RoundedRectangleBorder>(
                          //               RoundedRectangleBorder(
                          //                   borderRadius:
                          //                       BorderRadius.circular(25)))),
                          //       child: const Text(
                          //         'Proceed',
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 21),
                          //       )),
                          // ), //Proceed Button

                          SizedBox(
                            width: 150,
                            height: 45,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, 'registrationFarmer_FirstPage');
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

                      //Image(height: 100,width: 100,image: AssetImage(_filepath.toString()))
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
      final response = await dio.get(EnvConfigs.appBaseUrl + "state/list");
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
      final response =
          await dio.post(EnvConfigs.appBaseUrl + "city/list_by_district_id",
              //data: {"state_id": state_id});
              data: {"district_id": district_id.toString()});
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
      final response = await dio.get(EnvConfigs.appBaseUrl +
          "district/list_by_state_id?state_id=$state_id");
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

  Future<void> uploadData() async {
    getData();
    var formData = FormData.fromMap({
      'name': fname,
      'email_id': email,
      'password': password,
      'mobile_no': mobileNo,
      'gender': gender,
      'address': addressFarmer,
      'role': 'farmer',
      // 'bank_name': bankNameController.text,
      // 'bank_ifsc': ifscController.text,
      // 'bank_account_number': accountController.text,
      // 'account_holder_name': bankAccountholderNameController.text,
      // 'bank_branch_name': branchController.text,
      // 'bank_branch_address': bankAddController.text,

      'state_id': stateId,
      'district_id': districtId,
      'city_id': cityId,
      'pincode': pincode,
      'profile_photo': ((profileImg == null || profileImg == "")
          ? ""
          : await MultipartFile.fromFile(profileImg.toString())),
      'document_one': ((doc1 == null || doc1 == "" || doc1.toString() == "null")
          ? ""
          : await MultipartFile.fromFile(doc1.toString())),
      'document_two': ((doc2 == null || doc2 == "" || doc2.toString() == "null")
          ? ""
          : await MultipartFile.fromFile(doc2.toString())),
    });
    print(formData.fields);
    print(formData.files);
    try {
      final Map<String, String> headers = {};
      Dio dio = Dio();
      final response = await dio.post(EnvConfigs.appBaseReg + "register/farmer",
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
  // fileName(){
  //    print(${file.name})
  // }

//void openFile(PlatformFile file) {
// OpenFile.open(file.path!);}
}

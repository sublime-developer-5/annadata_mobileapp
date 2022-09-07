import 'dart:developer';
import 'dart:io';
import 'package:annadata/Model/modelStateList.dart';
import 'package:annadata/Model/updateUser.dart';
import 'package:annadata/Model/user_edit_info_model.dart';
import 'package:annadata/widgets/HomeScreen/homeBottumNavBar.dart';
import 'package:annadata/widgets/TextInputFormater/forFirstLetterUppercaseOfEachWord.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/modelCityList.dart';
import '../Model/modelDistrictList.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPage();
}

class _ProfileEditPage extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState> _statekey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _districtkey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _citykey = GlobalKey<FormFieldState>();

  String? userState;

  String? _Select_State;

  String _countryCode = "+91";

  String? gender;

  String? state_id_val;
  String? district_id_val;
  String? city_id_val;

  String? DocOneController;
  String? DocTwoController;
  String? ProfileImg;
  String? filepath1;
  String? filepath1Hint;
  String? filepath2;

  String? userRole;

  final String? _fileName = 'Upload Document';

  TextEditingController dateinput = TextEditingController();
  TextEditingController uName = TextEditingController();
  TextEditingController uEmail = TextEditingController();
  TextEditingController uPhone = TextEditingController();
  TextEditingController userAddress = TextEditingController();
  TextEditingController doc1 = TextEditingController();
  TextEditingController doc2 = TextEditingController();
  TextEditingController userBankName = TextEditingController();
  TextEditingController userAccountNo = TextEditingController();
  TextEditingController bankIFSC = TextEditingController();
  TextEditingController bankBranch = TextEditingController();
  TextEditingController userBankAccHolderName = TextEditingController();
  TextEditingController bankAddress = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  List<Data>? resStateList = [];
  List<DistrictData>? resDistList = [];
  List<CityData>? resCity = [];

  String? state_id;
  String? district_id = "";
  String? city_id;

  File? pickedFile;
  File? croppedImage;

  @override
  void initState() {
    // TODO: implement initState
    getStateList();
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (ProfileImg == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
              title: Text("Edit Profile"),
              leading: IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                new ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        uploadData();
                      }

                      // Navigator.pushNamed(context,
                      //     'registrationFarmer_SecondPage');
                    },
                    child: new Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    )),
              ]),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                  // height: MediaQuery.of(context).size.height,
                  // width: MediaQuery.of(context).size.width,
                  //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
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
                          Text('Personal Information',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
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

                      SizedBox(
                        height: 15,
                      ),

                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.orange,
                              radius: 58,
                              child: CircleAvatar(
                                  radius: 55,
                                  backgroundImage: croppedImage == null
                                      ? NetworkImage(ProfileImg.toString())
                                      : FileImage(File(croppedImage!.path))
                                          as ImageProvider),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(color: Colors.green)),
                                  child: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: ((builder) => bottomSheet()),
                                      );
                                    },
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                        controller: uName,
                        //style: TextStyle(fontSize: 18),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
                          UpperCaseTextFormatter()
                        ],
                        decoration: InputDecoration(
                            labelText: "Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.orange)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            // hintText: 'Name',
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
                          } else if (text.length < 4) {
                            return 'To short';
                          } else
                            return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                        controller: uEmail,

                        // style: TextStyle(fontSize: 20),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp("^[ ]{1}"))
                        ],
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "Email ID",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.orange)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            // hintText: 'Email ID',
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
                          } else if (!RegExp(
                                  "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(text)) {
                            return 'Enter Valid Email Address';
                          } else
                            return null;
                        },
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 48,
                            width: 80,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomLeft: Radius.circular(25)),
                            ),
                            child: DropdownButtonFormField(
                                elevation: 0,
                                decoration: InputDecoration(
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
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: TextFormField(
                                onChanged: (value) {
                                  _formKey.currentState!.validate();
                                },
                                controller: uPhone,
                                maxLength: 15,
                                keyboardType: TextInputType.phone,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.deny(
                                      RegExp("^[0-5]{1}")),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                // inputFormatters: <TextInputFormatter>[
                                //   FilteringTextInputFormatter.digitsOnly
                                // ],
                                // style: TextStyle(fontSize: 20),
                                // ignore: prefer_const_constructors
                                decoration: const InputDecoration(
                                    labelText: "Mobile Number",
                                    counterText: "",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(25),
                                            bottomRight: Radius.circular(25)),
                                        borderSide:
                                            BorderSide(color: Colors.orange)),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    // hintText: 'Mobile Number',
                                    //  hintStyle: TextStyle(fontSize: 20),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(25),
                                            bottomRight: Radius.circular(25)),
                                        borderSide:
                                            BorderSide(color: Colors.orange)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(25),
                                            bottomRight: Radius.circular(25)),
                                        borderSide:
                                            BorderSide(color: Colors.green))),

                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return '*Required';
                                  } else if (text.length < 10) {
                                    return 'Enter Valid Mobile Number';
                                  } else
                                    return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      // TextFormField(
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Select Date Of Birth';
                      //     } else
                      //       return null;
                      //   },
                      //   //style: TextStyle(fontSize: 20),
                      //   controller: dateinput,
                      //   readOnly: true,
                      //   onTap: () async {
                      //     DateTime? pickedDate = await showDatePicker(
                      //         context: context,
                      //         initialDate: DateTime.now(),
                      //         firstDate: DateTime(
                      //             1960), //DateTime.now() - not to allow to choose before today.
                      //         lastDate: DateTime.now());
                      //     if (pickedDate != null) {
                      //       print(
                      //           pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      //       String formattedDate =
                      //           DateFormat('dd-MM-yyyy').format(pickedDate);
                      //       print(
                      //           formattedDate); //formatted date output using intl package =>  2021-03-16
                      //       //you can implement different kind of Date Format here according to your requirement

                      //       setState(() {
                      //         dateinput.text =
                      //             formattedDate; //set output date to TextField value.
                      //       });
                      //     } else {
                      //       print("Date is not selected");
                      //     }
                      //   },
                      //   decoration: InputDecoration(
                      //       border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(25),
                      //           borderSide: BorderSide(color: Colors.orange)),
                      //       suffixIcon: IconButton(
                      //         icon: Icon(Icons.calendar_today),
                      //         onPressed: () {},
                      //       ),
                      //       contentPadding: EdgeInsets.symmetric(
                      //           vertical: 5, horizontal: 15),
                      //       hintText: 'Date Of Birth',
                      //       // hintStyle: TextStyle(fontSize: 20),
                      //       enabledBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(25),
                      //           borderSide: BorderSide(color: Colors.orange)),
                      //       focusedBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(25),
                      //           borderSide: BorderSide(color: Colors.green))),
                      // ),

                      // SizedBox(height: 10),

                      Text('    Gender',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),

                      Row(
                        children: [
                          SizedBox(
                            child: Row(
                              children: [
                                Radio(
                                    value: "male",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    }),
                                Text(
                                  "Male",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            child: Row(
                              children: [
                                Radio(
                                    value: "female",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    }),
                                Text(
                                  "Female",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            child: Row(
                              children: [
                                Radio(
                                    value: "other",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    }),
                                Text(
                                  "Others",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          ),

                          // ListTile(
                          //   title: const Text(
                          //     "Female",
                          //     style:
                          //         TextStyle(fontSize: 15, color: Colors.black),
                          //   ),
                          //   leading: Radio(
                          //       value: "Female",
                          //       groupValue: gender,
                          //       onChanged: (value) {
                          //         setState(() {
                          //           gender = value.toString();
                          //         });
                          //       }),
                          // ),
                          // ListTile(
                          //   title: const Text(
                          //     "Others",
                          //     style:
                          //         TextStyle(fontSize: 15, color: Colors.black),
                          //   ),
                          //   leading: Radio(
                          //       value: "Others",
                          //       groupValue: gender,
                          //       onChanged: (value) {
                          //         setState(() {
                          //           gender = value.toString();
                          //         });
                          //       }),
                          // ),
                        ],
                      ), //Gender RadioButton

                      SizedBox(
                        height: 10,
                      ),

                      Row(
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
                          Text('Address',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
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

                      const SizedBox(height: 10),

                      TextFormField(
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                        controller: userAddress,
                        //style: TextStyle(fontSize: 18),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
                        ],
                        decoration: InputDecoration(
                            labelText: "Address",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            // hintText: 'Address',
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
                          } else {
                            return null;
                          }
                        },
                      ), //Address

                      SizedBox(height: 10),

                      DropdownButtonFormField2(
                        buttonPadding: EdgeInsets.symmetric(horizontal: 20),
                        buttonHeight: 45,
                        dropdownMaxHeight: 250,
                        dropdownPadding: EdgeInsets.symmetric(horizontal: 15),
                        dropdownDecoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        decoration: InputDecoration(
                            labelText: "State",
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
                        // value: state_id,
                        key: _statekey,
                        hint: Text(state_id_val.toString()),
                        items: resStateList!
                            .map((lable) => DropdownMenuItem(
                                  child: Text(lable.stateName.toString()),
                                  value: lable.stateId,
                                ))
                            .toList(),
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            _citykey.currentState!.reset();
                            _districtkey.currentState!.reset();
                            resDistList = [];
                            resCity = [];
                            state_id = value.toString();
                          });

                          getDistrictList();
                          // print("State ID");
                          // print(state_id);
                          // print("district_id ID");
                          // print(district_id);
                        },
                        // value: state_id_val,

                        // validator: (value) =>
                        //     value == null ? '*select state required' : null,
                      ), //Select State

                      SizedBox(height: 10),

                      DropdownButtonFormField2(
                        buttonPadding: EdgeInsets.symmetric(horizontal: 20),
                        buttonHeight: 45,
                        dropdownMaxHeight: 250,
                        dropdownPadding: EdgeInsets.symmetric(horizontal: 15),
                        dropdownDecoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        decoration: InputDecoration(
                            labelText: "District",
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
                        key: _districtkey,
                        hint: Text(district_id_val.toString()),
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
                          print("district_id");
                          print(district_id);
                          _citykey.currentState!.reset();
                          getCitytList();
                        },
                        // validator: (value) =>
                        //     value == null ? '*select state required' : null,
                      ),

                      SizedBox(height: 10),

                      DropdownButtonFormField2(
                        buttonPadding: EdgeInsets.symmetric(horizontal: 20),
                        buttonHeight: 45,
                        dropdownMaxHeight: 250,
                        dropdownPadding: EdgeInsets.symmetric(horizontal: 15),
                        dropdownDecoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        decoration: InputDecoration(
                            // label: Text("City/Village"),
                            labelText: "City/Village",
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
                        key: _citykey,
                        hint: Text(city_id_val.toString()),
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
                          log(city_id.toString());
                        },
                        // validator: (value) =>
                        //     value == null ? '*select state required' : null,
                      ),

                      SizedBox(height: 10),

                      TextFormField(
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                        keyboardType: TextInputType.number,
                        controller: pincodeController,
                        maxLength: 6,
                        //style: TextStyle(fontSize: 18),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            labelText: "Pincode",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            // hintText: 'Enter Pincode',
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
                          } else if (text.length != 6) {
                            return 'Pincode is not valid';
                          } else {
                            return null;
                          }
                        },
                      ),

                      SizedBox(height: 25),

                      Text(
                        'Aadhar Card',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),

                      SizedBox(height: 10),

                      TextFormField(
                        controller: doc1,
                        readOnly: true,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            // labelText: "Document one",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.orange)),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.folder),
                              onPressed: () async {
                                final result =
                                    await FilePicker.platform.pickFiles();
                                if (result == null) return;

                                final file = result.files.first;

                                setState(() {
                                  filepath1 = file.path;
                                  doc1.text = file.name;
                                });
                              },
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            hintStyle: TextStyle(fontSize: 18),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.orange)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.green))),
                      ),

                      SizedBox(height: 25),

                      Text(
                        'PAN Card',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),

                      SizedBox(height: 10),

                      TextFormField(
                        controller: doc2,
                        readOnly: true,
                        style: TextStyle(fontSize: 18),

                        decoration: InputDecoration(
                            // labelText: "Document two",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.orange)),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.folder),
                              onPressed: () async {
                                final result =
                                    await FilePicker.platform.pickFiles();
                                if (result == null) return;

                                final file = result.files.first;

                                setState(() {
                                  filepath2 = file.path;
                                  doc2.text = file.name;
                                });
                              },
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            hintStyle: TextStyle(fontSize: 18),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.orange)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.green))),
                        // validator: (_filename) {
                        //   if (_fileName == "Upload Document") {
                        //     return '*Upload document required';
                        //   } else
                        //     return null;
                        // },
                      ),
                      SizedBox(height: 25),
                      userRole == "farmer" ? bankDetails() : SizedBox()
                    ],
                  ),
                ),
              )),
            ),
          ),
        ),
      );
    }
    // });
  }

  bankDetails() {
    return Column(
      children: [
        Row(
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
            Text('Bank Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
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
        SizedBox(height: 15),

        TextFormField(
          onChanged: (value) {
            _formKey.currentState!.validate();
          },
          controller: userBankName,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
          ],
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
              labelText: "Bank Name",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.orange)),
              contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
              // hintText: 'Bank Name',
              hintStyle: TextStyle(fontSize: 18),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.orange)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.green))),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return '*Required';
            } else
              return null;
          },
        ), //Bank name

        SizedBox(height: 10),

        TextFormField(
          maxLength: 25,
          onChanged: (value) {
            _formKey.currentState!.validate();
          },
          controller: userAccountNo,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
            FilteringTextInputFormatter.digitsOnly
          ],
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
              labelText: "Account Number",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.orange)),
              contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
              // hintText: 'Account Number',
              hintStyle: TextStyle(fontSize: 18),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.orange)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.green))),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return '*Required';
            } else
              return null;
          },
        ), //Account Number

        SizedBox(height: 10),

        TextFormField(
          onChanged: (value) {
            bankIFSC.value = TextEditingValue(
                text: value.toUpperCase(), selection: bankIFSC.selection);
            _formKey.currentState!.validate();
          },
          controller: bankIFSC,
          maxLength: 15,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.deny(RegExp("[ ]")),
          ],
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
              labelText: "IFSC Code",
              counterText: "",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.orange)),
              contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
              // hintText: 'IFSC Code',
              hintStyle: TextStyle(fontSize: 18),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.orange)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.green))),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return '*Required';
            } else if (text.length < 11) {
              return 'Enter valid IFSC code';
            } else
              return null;
          },
        ), //IFSC code

        SizedBox(height: 10),

        TextFormField(
          onChanged: (value) {
            _formKey.currentState!.validate();
          },
          controller: bankBranch,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
          ],
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
              labelText: "Branch name",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.orange)),
              contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
              // hintText: 'Branch Name',
              hintStyle: TextStyle(fontSize: 18),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.orange)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.green))),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return '*Required';
            } else
              return null;
          },
        ), //Branch

        SizedBox(height: 10),

        TextFormField(
          onChanged: (value) {
            _formKey.currentState!.validate();
          },
          controller: userBankAccHolderName,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
            UpperCaseTextFormatter()
          ],
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
              labelText: "Account Holder Name",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.orange)),
              contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
              // hintText: 'Account Holder Name',
              hintStyle: TextStyle(fontSize: 18),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.orange)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.green))),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return '*Required';
            } else if (text.length < 4) {
              return 'Too short';
            } else
              return null;
          },
        ), //Account Holder name

        SizedBox(height: 10),

        TextFormField(
          onChanged: (value) {
            _formKey.currentState!.validate();
          },
          controller: bankAddress,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
          ],
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
              labelText: "Bank Address",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.orange)),
              contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
              // hintText: 'Bank Address',
              hintStyle: TextStyle(fontSize: 18),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.orange)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.green))),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return '*Required';
            } else if (text.length < 4) {
              return 'Too short';
            } else
              return null;
          },
        ),
      ],
    );
  }

  bottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Choose Profile Photo'),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        // takePhoto(ImageSource.gallery);
                        getImagefromGal();
                      },
                      icon: Icon(Icons.photo)),
                  Text('Gallery'),
                ],
              ),
              const SizedBox(width: 50),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        getImagefromCam();
                      },
                      icon: Icon(Icons.camera_alt)),
                  Text('Camera'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  //image from gallery

  Future<File> getImagefromGal() async {
    final ImagePicker _picker = ImagePicker();
// Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//TO convert Xfile into file
    File file = File(image!.path);
    log("Image picked from camera");
    log(file.uri.toString());
    setState(() {
      pickedFile = file;
    });
    log("widget.imageFile");
    log(pickedFile.toString());

    _cropImage();

    Navigator.pop(context);

    return file;
  }

  // Image From Camera

  Future<File> getImagefromCam() async {
    final ImagePicker _picker = ImagePicker();
// Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//TO convert Xfile into file
    File file = File(image!.path);
    log("Image picked from camera");
    log(file.uri.toString());
    setState(() {
      pickedFile = file;
    });
    log("widget.imageFile");
    log(pickedFile.toString());

    _cropImage();

    Navigator.pop(context);

    return file;
  }

  // Crop Image
  Future _cropImage() async {
    CroppedFile? file = await ImageCropper()
        .cropImage(sourcePath: pickedFile!.path, aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9,
    ], uiSettings: [
      AndroidUiSettings(lockAspectRatio: false)
    ]);

    if (file != null) {
      setState(() {
        croppedImage = File(file.path);
      });
    }
  }

  // Country Code Dropdown List

  List<DropdownMenuItem<String>> _countryCodeList() {
    List<String> regList = ["+91", "+62", "+870", "+800", "+93", "+54"];
    return regList
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  Future<UserEditInfo?> getUserInfo() async {
    // Base URL
    var baseurl = "http://161.97.138.56:3021/mobile/user/edit";

    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('_id');
    var userToken = prefs.getString('auth_token');

    var formData = FormData.fromMap({
      'user_id': userId,
    });
    print("*****userId*****");
    print(userId);

    try {
      Response response = await dio.post(
        baseurl,
        options: Options(headers: {'x-access-token': userToken}),
        data: formData,
      );

      // Data res = Data.fromJson(response.data);
      UserEditInfo res = UserEditInfo.fromJson(response.data);

      // var res = jsonDecode(response.data);

      print("Edit Responce");
      print(res.message);

      var item = res.data![0];

      print(item.profilePhoto.toString());

      setState(() {
        ProfileImg = item.profilePhoto.toString();
        uName.text = item.name.toString();
        uEmail.text = item.emailId.toString();
        uPhone.text = item.mobileNo.toString();
        // dateinput.text = item.name.toString();
        gender = item.gender.toString();
        userAddress.text = item.address.toString();
        state_id_val = item.stateName.toString();
        district_id_val = item.districtName.toString();
        city_id_val = item.cityName.toString();
        pincodeController.text = item.pincode.toString();
        doc1.text = item.documentOne.toString();
        //DocOneController = item.documentOne.toString();
        doc2.text = item.documentTwo.toString();
        userBankName.text = item.bankName.toString();
        userAccountNo.text = item.bankAccountNumber.toString();
        bankIFSC.text = item.bankIfsc.toString();
        bankBranch.text = item.bankBranchName.toString();
        userBankAccHolderName.text = item.bankAccountHolderName.toString();
        bankAddress.text = item.bankBranchAddress.toString();
        userRole = item.role.toString();
      });

      return res;
    } on DioError catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> getStateList() async {
    try {
      final Map<String, String> headers = {};
      Dio dio = Dio(BaseOptions(
          headers: headers, connectTimeout: 8000, receiveTimeout: 8000));
      final response =
          await dio.get("http://161.97.138.56:3021/mobile/state/list");
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
          .post("http://161.97.138.56:3021/mobile/city/list_by_district_id",
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
      final response = await dio.get(
          "http://161.97.138.56:3021/mobile/district/list_by_state_id?state_id=$state_id");
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
  Future<void> uploadData() async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('_id');
    var userToken = prefs.getString('auth_token');

    print("---------***userId***-----");
    print(userId);
    print("---------***token***-----");
    print(userToken);
    var formData = FormData.fromMap({
      'user_id': userId,
      'profile_photo': croppedImage == null
          ? ProfileImg
          : await MultipartFile.fromFile(croppedImage!.path),
      'name': uName.text,
      'email_id': uEmail.text,
      'mobile_no': uPhone.text,
      'gender': gender,
      'address': userAddress.text,
      // 'role': 'Farmer',
      'bank_name': userBankName.text,
      'bank_ifsc': bankIFSC.text,
      'bank_account_number': userAccountNo.text,
      'account_holder_name': userBankAccHolderName.text,
      'bank_branch_name': bankBranch.text,
      'bank_branch_address': bankAddress.text,
      'document_one': filepath1 == null
          ? doc1.text
          : await MultipartFile.fromFile(filepath1.toString()),
      'document_two': filepath2 == null
          ? doc2.text
          : await MultipartFile.fromFile(filepath2.toString()),
      'state_id': state_id,
      'district_id': district_id,
      'city_id': city_id,
      'pincode': pincodeController.text
    });

    log("formData.fields.toString()********");
    log(formData.fields.toString());
    log("imageFile.toString()********");
    log(croppedImage.toString());
    try {
      final Map<String, String> headers = {};
      Dio dio = Dio(BaseOptions(
          headers: headers, connectTimeout: 8000, receiveTimeout: 8000));
      final response = await dio.post(
          "http://161.97.138.56:3021/mobile/user/update",
          options: Options(headers: {'x-access-token': userToken}),
          data: formData);
      String strTemp = response.toString();
      final res = response;

      final String? resMessage = UpdateUser.fromJson(response.data).message;
      final bool? success = UpdateUser.fromJson(response.data).success;

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
          // Navigator.pushNamedAndRemoveUntil(
          //     context, 'bottumNavBar', (Route route) => false);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => BottumNavBar(
                        pageIndex: 1,
                      )),
              (route) => false);
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

    // const url = "http://161.97.138.56:3021/register/farmer";

    // Response response;
    // var dio = Dio();

    // var formData = FormData.fromMap({
    //   'name': fname,
    //   'email_id': email,
    //   'password': password,
    //   'mobile_no': mobileNo,
    //   'gender': gender,
    //   'address': '205, gangsta vihar, tirupati colony, new delhi - 4000001',
    //   'role': 'Farmer',
    //   'bank_name': 'SBI',
    //   'bank_ifsc': ifscController.text,
    //   'bank_account_number': accountController.text,
    //   'bank_branch_name': branchController.text,
    //   'bank_branch_address': bankAddController.text,
    //   'document_one': await MultipartFile.fromFile(doc1.toString()),
    //   'document_two': await MultipartFile.fromFile(doc2.toString()),
    //   'state_id': stateId,
    //   'district_id': districtId,
    //   'city_id': cityId,
    //   'pincode': pincode
    // });

    // response = await dio.post(url, data: formData);
    // var resData = response.data;
    // print();
  }
}

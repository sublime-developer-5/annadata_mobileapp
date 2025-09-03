import 'dart:developer';
import 'dart:io';

import 'package:annadata/screens/Trader%20Registration/_TraderReg_SecondPage.dart';
import 'package:annadata/widgets/TextInputFormater/forFirstLetterUppercaseOfEachWord.dart';
import 'package:dio/dio.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/registerRes.dart';
import '../../env.dart';

class TraderRegFirstPage extends StatefulWidget {
  const TraderRegFirstPage({Key? key}) : super(key: key);

  @override
  State<TraderRegFirstPage> createState() => _TraderRegFirstPageState();
}

class _TraderRegFirstPageState extends State<TraderRegFirstPage> {
  String _countryCode = "+91";
  int _value = 1;
  String? gender;
  bool _isVisible = true;
  bool _isVisible1 = true;

  // Controllers

  TextEditingController firstNameTrader = TextEditingController();
  TextEditingController dateinputTrader = TextEditingController();
  TextEditingController _newPasswordTrader = TextEditingController();
  TextEditingController _confirmPasswordTrader = TextEditingController();
  TextEditingController email_Id_Trader = TextEditingController();
  TextEditingController phone_number_Trader = TextEditingController();
  TextEditingController addressController_Trader = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // declare a GlobalKey

  // regular expression to check if string
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  //A function that validate user entered password
  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (pass_valid.hasMatch(_password)) {
      return true;
    } else {
      return false;
    }
  }

  File? pickedFile;
  File? croppedImage;

  @override
  void initState() {
    dateinputTrader.text = ""; //set the initial value of text field
    super.initState();
  }

  void setData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      "registerItemTrader1",
      [
        croppedImage == null ? "" : croppedImage!.path,
        firstNameTrader.text,
        email_Id_Trader.text,
        _countryCode,
        phone_number_Trader.text,
        _newPasswordTrader.text,
        dateinputTrader.text,
        gender.toString(),
        addressController_Trader.text,
      ],
    );
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
                        color: Colors.orange,
                      ),
                    ),
                    Container(
                      height: 2,
                      width: 40,
                      color: Colors.orange,
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange, width: 2),
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
                height: 1.5,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.orange)),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Information',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),

                      SizedBox(height: 10),
                      // TestImagePicker(),

                      Center(
                        child: Stack(
                          children: <Widget>[
                            CircleAvatar(
                                radius: 80.0,
                                backgroundImage: croppedImage == null
                                    ? AssetImage("assets/user_icon.png")
                                    : FileImage(File(croppedImage!.path))
                                        as ImageProvider),
                            Positioned(
                              bottom: 0.0,
                              right: 0.0,
                              child: IconButton(
                                  iconSize: 40,
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: ((builder) => bottomSheet()),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.orange,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),

                      TextFormField(
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                        // style: TextStyle(fontSize: 18),
                        controller: firstNameTrader,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
                          UpperCaseTextFormatter()
                        ],
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.orange)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            hintText: 'Full Name',
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
                            return '*Too short';
                          } else
                            return null;
                        },
                      ), //Full Name

                      SizedBox(height: 10),

                      TextFormField(
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                        // style: TextStyle(fontSize: 20),
                        controller: email_Id_Trader,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
                        ],
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.orange)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            hintText: 'Email ID',
                            //   hintStyle: TextStyle(fontSize: 18),
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
                            return 'Enter valid email address';
                          } else
                            return null;
                        },
                      ), //Email Id

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
                                controller: phone_number_Trader,
                                maxLength: 15,
                                keyboardType: TextInputType.phone,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.deny(
                                      RegExp("^[0-5]{1}")),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                // style: TextStyle(fontSize: 20),
                                // ignore: prefer_const_constructors
                                decoration: const InputDecoration(
                                    counterText: "",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(25),
                                            bottomRight: Radius.circular(25)),
                                        borderSide:
                                            BorderSide(color: Colors.orange)),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    hintText: 'Mobile Number',
                                    // hintStyle: TextStyle(fontSize: 20),
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
                                    return '*Required\n*Mobile number should be start from 6-9';
                                  } else if (text.length < 10) {
                                    return 'Enter valid mobile number';
                                  } else
                                    return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ), //Mobile Number

                      SizedBox(height: 10),

                      TextFormField(
                        enableInteractiveSelection: false,
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                        controller: _newPasswordTrader,
                        obscureText: _isVisible,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
                        ],

                        // style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.orange)),
                            suffixIcon: IconButton(
                              icon: Icon(_isVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isVisible = !_isVisible;
                                });
                              },
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            hintText: 'New Password',
                            // hintStyle: TextStyle(fontSize: 20),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.orange)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.green))),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return '*Required';
                          } else if (text.length < 8) {
                            return 'At least 8 characters';
                          } else {
                            bool result = validatePassword(text);
                            if (result) {
                              return null;
                            } else {
                              return " Password should contain \n*Capital letter \n*Small letter \n*Number \n*Special character";
                            }
                          }
                        },
                      ), //New Password

                      SizedBox(height: 10),

                      TextFormField(
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                        controller: _confirmPasswordTrader,
                        obscureText: _isVisible1,
                        enableInteractiveSelection: false,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
                        ],
                        // style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.orange)),
                            suffixIcon: IconButton(
                              icon: Icon(_isVisible1
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isVisible1 = !_isVisible1;
                                });
                              },
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            hintText: 'Confirm Password',
                            // hintStyle: TextStyle(fontSize: 20),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.orange)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.green))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*Required';
                          }
                          print(_newPasswordTrader.text);
                          print(_confirmPasswordTrader.text);

                          if (_newPasswordTrader.text !=
                              _confirmPasswordTrader.text) {
                            return "Password does not match";
                          } else
                            return null;
                        },
                      ), //Confirm Password

                      // SizedBox(height: 10),

                      // TextFormField(
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Select Date Of Birth';
                      //     } else
                      //       return null;
                      //   },
                      //   //  style: TextStyle(fontSize: 20),
                      //   controller: dateinputTrader,
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
                      //         dateinputTrader.text =
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
                      // ), //Date of Birth

                      SizedBox(height: 10),

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

                      const SizedBox(height: 10),

                      TextFormField(
                        onChanged: (value) {
                          _formKey.currentState!.validate();
                        },
                        controller: addressController_Trader,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp("^[ ]{1}")),
                        ],
                        //style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.orange)),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            hintText: 'Address',
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 45,
                            child: ElevatedButton(
                                onPressed: () {
                                  debugPrint("before firstNameTrader");
                                  debugPrint(firstNameTrader.text);
                                  firstNameTrader.text.trim();
                                  debugPrint("Aftre firstNameTrader");
                                  debugPrint(firstNameTrader.text);

                                  if (gender == null) {
                                    final snackBar = SnackBar(
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                        "*Select gender",
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else if (_formKey.currentState!
                                      .validate()) {
                                    setData();
                                    checkMobileNo();
                                  }
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)))),
                                child: const Text(
                                  'Proceed',
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
                      ) //Buttons
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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

  bottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height / 5.5,
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
                        // takePhoto(ImageSource.camera);
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

  // image from gallery

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

// image from Camera

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
        .cropImage(sourcePath: pickedFile!.path, uiSettings: [
      AndroidUiSettings(lockAspectRatio: false)
    ]);

    if (file != null) {
      setState(() {
        croppedImage = File(file.path);
      });

      log(croppedImage!.path);
    }
  }

  // Register API
  Future<void> checkMobileNo() async {
    var formData = FormData.fromMap({
      'email_id': email_Id_Trader.text,
      'mobile_no': phone_number_Trader.text,
    });

    try {
      final Map<String, String> headers = {};
      Dio dio = Dio();
      final response = await dio
          .post(EnvConfigs.appBaseReg+"register/check", data: formData);
      String strTemp = response.toString();
      final res = response;

      final String? resMessage = RegisterRes.fromJson(response.data).message;
      final bool? success = RegisterRes.fromJson(response.data).success;

      // Showing message response

      if (success == false) {
        final snackBar = SnackBar(
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          content: Text(
            resMessage.toString(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      if (success == true) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TraderRegSecondPage()));
        });
      }
    } catch (e) {
      print('e');
      print(e);
    }
  }
}

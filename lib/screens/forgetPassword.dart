import 'dart:async';
import 'dart:developer';

import 'package:annadata/screens/updatePassword.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/updateUser.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController controllerEmailId = TextEditingController();
  TextEditingController controllerOTP = TextEditingController();

  String? otpText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Forgot Password?",
                  style: TextStyle(fontSize: 30, fontFamily: 'Rubik Regular'),
                ),

                SizedBox(
                  height: 50,
                ),

                TextFormField(
                  controller: controllerEmailId,
                  //style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.orange)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      hintText: 'Email ID',
                      //  hintStyle: TextStyle(fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.orange)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.green))),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return '*Required';
                    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(text)) {
                      return 'Enter Valid Email Address';
                    } else {
                      return null;
                    }
                  },
                ), //Email Id

                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 45,
                      child: ElevatedButton(
                          onPressed: () {
                            sendEmailforPass(0);
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25)))),
                          child: const Text(
                            'Send',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 21),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Register API

  Future<void> sendEmailforPass(int param) async {
    try {
      Dio dio = Dio();
      final response = await dio.post(
          "http://161.97.138.56:3021/forgotpassword",
          data: ({'user_id_or_mobile_no': controllerEmailId.text}));
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

      if (success == true && param == 0) {
        Timer(
          Duration(seconds: 1),
          () {
            otpPopUpBox();
          },
        );
      }

      debugPrint(res.toString());
    } catch (e) {
      print('e');
      print(e);
    }
  }

  //sendOTP Api

  Future<void> sendOTP() async {
    try {
      Dio dio = Dio();

      final response = await dio.post(
          "http://161.97.138.56:3021/forgotpassword/check_otp",
          data: ({
            'user_id_or_mobile_no': controllerEmailId.text,
            'otp': otpText
          }));
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
        Timer(
          Duration(seconds: 1),
          () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      UpdateUserPassword(userEmailID: controllerEmailId.text),
                ));
          },
        );
      }

      debugPrint(res.toString());
    } catch (e) {
      print('e');
      print(e);
    }
  }

  otpPopUpBox() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Dialog(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      IconButton(
                          padding: EdgeInsets.only(
                              top: 5, right: 5, bottom: 5, left: 5),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.cancel))
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, bottom: 20, right: 20),
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "Enter the OTP sent to \n",
                                children: [
                                  TextSpan(
                                      text: controllerEmailId.text,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                ],
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 15)),
                            textAlign: TextAlign.center,
                          ),
                          PinCodeTextField(
                            keyboardType: TextInputType.number,
                            appContext: context,
                            length: 4,
                            onChanged: (value) {
                              setState(() {
                                otpText = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: 150,
                            height: 45,
                            child: ElevatedButton(
                                onPressed: () {
                                  sendOTP();
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)))),
                                child: const Text(
                                  'Verify',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 21),
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "Didn't receive the code? ",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 15),
                                children: [
                                  TextSpan(
                                      text: " RESEND",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          sendEmailforPass(1);
                                        },
                                      style: TextStyle(
                                          color: Color(0xFF91D3B3),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16))
                                ]),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ));
  }
}

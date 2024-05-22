import 'dart:developer';

import 'package:annadata/screens/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/updateUser.dart';
import '../Model/user_edit_info_model.dart';
import '../env.dart';
import '../widgets/HomeScreen/homeBottumNavBar.dart';

class UpdateUserPassword extends StatefulWidget {
  UpdateUserPassword({Key? key, required this.userEmailID}) : super(key: key);

  String userEmailID;

  @override
  State<UpdateUserPassword> createState() => _UpdateUserPasswordState();
}

class _UpdateUserPasswordState extends State<UpdateUserPassword> {
  final _formKey = GlobalKey<FormState>();

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

  TextEditingController _confirmPassword = TextEditingController();
  TextEditingController _newPassword = TextEditingController();

  bool _isVisibleold = true;
  bool _isVisible = true;
  bool _isVisible1 = true;

  String? userEmailId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      userEmailId = widget.userEmailID.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.orange,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Set New Password",
                        style: TextStyle(fontSize: 25, color: Colors.green),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  Divider(color: Colors.green, thickness: 2),

                  SizedBox(
                    height: 30,
                  ),

                  const SizedBox(height: 10),

                  TextFormField(
                    onChanged: (value) {
                      _formKey.currentState!.validate();
                    },
                    obscureText: _isVisible,
                    enableInteractiveSelection: false,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.deny(RegExp("^[ ]{1}"))
                    ],
                    //style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.orange)),
                        suffixIcon: IconButton(
                          icon: Icon(_isVisible == true
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        hintText: 'New Password',
                        // hintStyle: TextStyle(fontSize: 20),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.orange)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.green))),
                    controller: _newPassword,
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

                  const SizedBox(height: 10),

                  TextFormField(
                    onChanged: (value) {
                      _formKey.currentState!.validate();
                    },
                    obscureText: _isVisible1,
                    enableInteractiveSelection: false,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.deny(RegExp("^[ ]{1}"))
                    ],
                    // style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.orange)),
                        suffixIcon: IconButton(
                          icon: Icon(_isVisible1 == true
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isVisible1 = !_isVisible1;
                            });
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        hintText: 'Confirm Password',
                        // hintStyle: TextStyle(fontSize: 20),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.orange)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.green))),
                    controller: _confirmPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      print(_newPassword.text);
                      print(_confirmPassword.text);

                      if (_newPassword.text != _confirmPassword.text) {
                        return "Password does not match";
                      } else {
                        return null;
                      }
                    },
                  ), //Confirm Password

                  SizedBox(
                    height: 25,
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 45,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            updateForgotPassword();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        // style: ButtonStyle( backgroundColor: MaterialStateProperty.all<Color>(Color(Colors.orange)),
                        //     shape: MaterialStateProperty.all<
                        //             RoundedRectangleBorder>(
                        //         RoundedRectangleBorder(
                        //             borderRadius:
                        //                 BorderRadius.circular(25)))),
                        child: const Text(
                          'Submit',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21),
                        )),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  // Register API
  Future<void> updateForgotPassword() async {
    var formData = FormData.fromMap({
      'email_id': userEmailId,
      'new_password': _newPassword.text,
    });

    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('_id');
    var token = prefs.getString("auth_token");

    log("formData.fields.toString()********");
    log(formData.fields.toString());

    try {
      Dio dio = Dio();
      final response = await dio.post(
          EnvConfigs.appBaseReg+"forgotpassword/update_password",
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
                  builder: (BuildContext context) => LoginPage()),
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
  }
}

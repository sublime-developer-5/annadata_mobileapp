import 'package:annadata/Model/loginRes.dart';
import 'package:annadata/screens/Logistic%20Registration/_LogisticReg_FirstPage.dart';
import 'package:annadata/screens/Trader%20Registration/_TraderReg_FirstPage.dart';
import 'package:annadata/screens/farmer%20registration/far_regi_FirstPage.dart';
import 'package:annadata/screens/forgetPassword.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../env.dart';
import '../widgets/HomeScreen/homeBottumNavBar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String? registerItems;
  String? resMassege;
  bool _remCheckBox = false;
  bool _hidePass = true;

  TextEditingController userName = TextEditingController();
  TextEditingController userPass = TextEditingController();
  TextEditingController regDropdownController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   icon: Icon(
          //     Icons.arrow_back,
          //     color: Colors.orange,
          //   ),
          //   onPressed: () {
          //    // Navigator.pop(context);
          //   },
          // ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  const SizedBox(
                      width: 170,
                      height: 170,
                      child: Image(
                        image: AssetImage('assets/Logo-modified.png'),
                      )), //Logo

                  const SizedBox(height: 40),

                  TextFormField(
                    // style: TextStyle(fontSize: 20),
                    controller: userName,
                    onChanged: (text) {
                      if (text != null) {
                        _formKey.currentState!.validate();
                      } else {
                        return null;
                      }
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp("^[ ]{1}"))
                    ],
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.orange)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        hintText: 'Email ID / Mobile Number',
                        hintStyle: TextStyle(fontFamily: 'Rubik Regular'),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.orange)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.green))),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return '*Required';
                      } else {
                        return null;
                      }
                    },
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  TextFormField(
                    onChanged: (text) {
                      if (text != null) {
                        _formKey.currentState!.validate();
                      } else {
                        return null;
                      }
                    },
                    controller: userPass,
                    obscureText: _hidePass,
                    // style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _hidePass = !_hidePass;
                            });
                          },
                          child: Icon(_hidePass
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.orange)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        hintText: 'Password',
                        hintStyle: TextStyle(fontFamily: 'Rubik Regular'),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.orange)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.green))),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return '*Required';
                      } else {
                        return null;
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Row(
                      //   children: [
                      //     Checkbox(
                      //       value: _remCheckBox,
                      //       onChanged: (bool? value) {
                      //         setState(() {
                      //           _remCheckBox = value!;
                      //         });
                      //       },
                      //     ),
                      //     const Text(
                      //       'Remember Me',
                      //       style: TextStyle(fontFamily: 'Rubik Regular'),
                      //     )
                      //   ],
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: GestureDetector(
                          child: Text("Forgot Password?",
                              style: TextStyle(
                                  fontFamily: 'Rubik Regular',
                                  color: Colors.green)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgetPassword()));
                          },
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 2,
                    height: 45,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            uploadLoginData();
                            // login(userName.text, userPass.text);
                            // Navigator.pushNamed(context, 'homePage');
                          }
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)))),
                        child: const Text(
                          'LOGIN',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Rubik Regular',
                              fontWeight: FontWeight.bold,
                              fontSize: 21),
                        )),
                  ),

                  const SizedBox(height: 50),

                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: const Divider(
                        color: Colors.orange, height: 1, thickness: 1),
                  ),

                  /* Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                  ),*/

                  const SizedBox(height: 30),

                  const Text(
                    "Don't Have Any Account?",
                    style: TextStyle(fontFamily: 'Rubik Regular'),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField2(
                          buttonPadding: EdgeInsets.symmetric(horizontal: 20),
                          buttonHeight: 45,
                          dropdownMaxHeight: 350,
                          dropdownPadding: EdgeInsets.symmetric(horizontal: 15),
                          dropdownDecoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none),
                          onMenuStateChange: (isOpen) {
                            if (!isOpen) {
                              regDropdownController.clear();
                            }
                          },
                          isExpanded: false,
                          value: registerItems,
                          icon: const Icon(Icons.arrow_drop_down),
                          items: _registerItems(),
                          hint: const Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.green,
                                fontFamily: 'Rubik Regular'),
                          ),
                          onChanged: (String? newValue) {
                            registerItems = newValue!;
                            switch (newValue) {
                              case "Farmer":
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FarmerRegistrationFirstpage()),
                                );
                                break;
                              case "Trader":
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TraderRegFirstPage()),
                                );
                                break;
                              case "Logistic":
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LogisticRegFirstPage()),
                                );
                                break;
                            }
                          }),
                    ),
                  ), //Register DropDown

                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.copyright,
                        size: 15,
                        color: Colors.black,
                      ),
                      RichText(
                          text: const TextSpan(
                              text: ' Copyright by ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Rubik Regular'),
                              children: <TextSpan>[
                            TextSpan(
                                text: 'Annadata',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: 'Rubik Regular'))
                          ]))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _registerItems() {
    List<String> regList = ["Farmer", "Trader", "Logistic"];
    return regList
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

// Login API
  Future uploadLoginData() async {
    //final baseUrl = EnvConfigs.appBaseReg+"login";
    const baseUrl = EnvConfigs.appBaseReg+"login";
    // log("My Data");
    // log(userName.text);
    // log(userPass.text);
    var formData = FormData.fromMap({
      'user_id': userName.text,
      'password': userPass.text,
    });
    try {
      Dio dio = Dio();
      final response = await dio.post(baseUrl, data: formData);

      LoginRes resData = LoginRes.fromJson(response.data);

      // Showing message response

      final snackBar = SnackBar(
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        content: Text(resData.message.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      final bool? success = resData.success;
      final String? token = resData.token;
      final String? userId = resData.data![0].id.toString();
      final String? role = resData.role;

      // Storing Login Data

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString("auth_token", token.toString());
      await prefs.setString("_id", resData.data![0].id.toString());
      await prefs.setString("userRole", role.toString());

      // Success Navigation
      if (success == true) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => BottumNavBar(
                        pageIndex: 0,
                      )),
              (route) => false);
        });
      }

      return response.data;
    } catch (e) {
      debugPrint('e');
      debugPrint(e.toString());
      return e;
    }
  }

  // getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString("auth_token");
  //   final userId = prefs.getString("user_id");
  //   final role = prefs.getString("userRole");

  //   log("*****User Id*****");
  //   log(userId.toString());

  //   log("token");
  //   log(token.toString());

  //   log("Role");
  //   log(role.toString());
  // }
}

import 'dart:convert';

import 'package:flutter/material.dart';

class RecieveDataSecondScreen extends StatefulWidget {
  final String fname, email, phone, password, dob, contry_code;

  RecieveDataSecondScreen(
      {Key? key,
      required this.fname,
      required this.email,
      required this.phone,
      required this.password,
      required this.dob,
      required this.contry_code})
      : super(key: key);

  // String? rdioParam = "";
  @override
  State<RecieveDataSecondScreen> createState() =>
      _RecieveDataSecondScreenState();
}

class _RecieveDataSecondScreenState extends State<RecieveDataSecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.fname),
            Text(widget.email),
            Text(widget.phone),
            Text(widget.password),
            Text(widget.dob),
            //Text(widget.rdioParam.toString())
          ],
        ),
      ),
    );
  }

  // register() async {
  //   Map data = {
  //     'F_name': widget.fname,
  //     'Email': widget.email,
  //     'PhoneNumber': widget.phone,
  //     'NewPassword': widget.password,
  //     'DateOfBirth': widget.dob
  //   };
  //   print(data);

  //   String body = json.encoder(data);

  //   var url = "http://161.97.138.56:3021/register/farmer";

  // }
}

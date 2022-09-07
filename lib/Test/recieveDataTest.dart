import 'package:annadata/Test/recieveDataTest2.dart';
import 'package:flutter/material.dart';

class RetriveDataTest extends StatefulWidget {
  final String fname, email, phone, password, dob, contry_code, addressFarmer;
  final profImage;
  //final gender;

  RetriveDataTest(
      {Key? key,
      required this.fname,
      required this.email,
      required this.phone,
      required this.password,
      required this.dob,
      required this.contry_code,
      required this.addressFarmer,
      this.radioParam,
      this.profImage

      // required this.gender
      })
      : super(key: key);

  String? radioParam = "";

  @override
  State<RetriveDataTest> createState() => _RetriveDataTestState();
}

class _RetriveDataTestState extends State<RetriveDataTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.fname),
            Text(widget.email),
            Text(widget.contry_code + ' ' + widget.phone),
            Text(widget.password),
            Text(widget.dob),
            Text(widget.addressFarmer),
            Text(widget.radioParam.toString()),

            Container(
              width: 150,
              height: 150,
              child: Image.asset(widget.profImage),
            ),
            //Text(widget.gender),

            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecieveDataSecondScreen(
                              fname: widget.fname,
                              email: widget.email,
                              phone: widget.phone,
                              password: widget.password,
                              dob: widget.dob,
                              contry_code: widget.contry_code)));
                },
                child: Text('send Data'))
          ],
        ),
      ),
    );
  }
}

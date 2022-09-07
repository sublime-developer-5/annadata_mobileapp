import 'package:annadata/screens/login.dart';
import 'package:annadata/screens/profilePageFarmer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomLogin extends StatefulWidget {
  const BottomLogin({Key? key}) : super(key: key);

  @override
  State<BottomLogin> createState() => _BottomLoginState();
}

class _BottomLoginState extends State<BottomLogin> {
  String? storedToken;

  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth_token");
    setState(() {
      storedToken = token;
    });
    debugPrint(storedToken);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return storedToken != null ? ProfilePageFarmer() : LoginPage();
  }
}

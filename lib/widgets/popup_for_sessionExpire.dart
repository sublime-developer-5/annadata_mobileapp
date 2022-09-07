import 'package:flutter/material.dart';

class SessionExpire extends StatelessWidget {
  const SessionExpire({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Text("Session Expire"),
      ),
      // insetPadding: EdgeInsets.all(10),
    );
  }
}

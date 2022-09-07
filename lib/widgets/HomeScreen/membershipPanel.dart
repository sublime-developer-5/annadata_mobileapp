import 'package:annadata/screens/MemberShip/membership_plan_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MembershipPanelHome extends StatefulWidget {
  const MembershipPanelHome({Key? key}) : super(key: key);

  @override
  State<MembershipPanelHome> createState() => _MembershipPanelHomeState();
}

class _MembershipPanelHomeState extends State<MembershipPanelHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromARGB(255, 1, 48, 87), Colors.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      padding: EdgeInsets.only(left: 35, top: 40, right: 35, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Get Free Membership On Register",
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: MembershipDetails(),
                      type: PageTransitionType.fade));
            },
            child: Text("Membership Plans"),
          )

          // Text(
          //   "Minimum Validity of 3 Months",
          //   style: TextStyle(color: Colors.white, fontSize: 18),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // TextFormField(
          //   decoration: InputDecoration(
          //       isDense: true,
          //       fillColor: Colors.white,
          //       filled: true,
          //       contentPadding: EdgeInsets.symmetric(horizontal: 10),
          //       hintText: "Enter Your Email Address",
          //       suffix: ElevatedButton(
          //         onPressed: () {},
          //         child: Text("@ SUBSCRIBE"),
          //       )),
          // )
        ],
      ),
    );
  }
}

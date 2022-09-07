import 'package:annadata/screens/homepage.dart';
import 'package:annadata/screens/product_addByFarmer.dart';
import 'package:annadata/screens/profilePageFarmer.dart';
import 'package:annadata/widgets/bottumLogin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottumNavBar extends StatefulWidget {
  BottumNavBar({Key? key, required this.pageIndex}) : super(key: key);

  int pageIndex = 0;

  @override
  State<BottumNavBar> createState() => _BottumNavBarState();
}

class _BottumNavBarState extends State<BottumNavBar> {
  int _selectedIndex = 0;

  String? userId;
  String? userRole;
  // String? userName;

  // getUserFunction() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString("user_id", userId.toString());
  //   await prefs.setString("role", role.toString());
  // }

  pleaseLogin() {
    return Dialog(
      child: Text("Please Login"),
    );
  }

  getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('_id');
    var token = prefs.getString('auth_token');
    var role = prefs.getString('role');

    setState(() {
      userId = id;
      userRole = role;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getUserDetails();
  }

  final pages = [
    HomePage(),
    // AddProductByFarmer(),
    // const ProfilePageFarmer(),
    BottomLogin()
  ];

  _onItemTapped(int index) {
    setState(() {
      widget.pageIndex = index;
    });
    print("********** index **********");
    print(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepOrange,
        iconSize: 25,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange),
        unselectedLabelStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'HOME'),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.add),
          //   label: 'Add Post',
          // ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_outlined), label: 'PROFILE'),
        ],
        currentIndex: widget.pageIndex,
        onTap: _onItemTapped,
      ),
      body: pages.elementAt(widget.pageIndex),
    );
  }

  // customNavigationBar() {
  //   return Container(
  //     height: 80,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       //crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         InkWell(
  //           onTap: () {},
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [Icon(Icons.home_filled), Text("HOME")],
  //           ),
  //         ),
  //         userRole == null && userRole != 'farmer'
  //             ? SizedBox()
  //             : InkWell(
  //                 onTap: () {},
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [Icon(Icons.home_filled), Text("HOME")],
  //                 ),
  //               ),
  //         InkWell(
  //           onTap: () {},
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [Icon(Icons.home_filled), Text("HOME")],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}

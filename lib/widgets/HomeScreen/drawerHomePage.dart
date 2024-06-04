import 'dart:developer';

import 'package:annadata/Model/categoryCopy.dart';
import 'package:annadata/screens/MemberShip/membership_plan_page.dart';
import 'package:annadata/screens/MemberShip/user_membership_details.dart';
import 'package:annadata/screens/add_logistic_company.dart';
import 'package:annadata/screens/commodityListPage.dart';
import 'package:annadata/screens/product_addByFarmer.dart';
import 'package:annadata/widgets/HomeScreen/homeBottumNavBar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Model/user_edit_info_model.dart';
import '../../env.dart';
import '../../screens/categoryFilterPage.dart';
import '../../screens/change_user_password.dart';

class DrawerHomePage extends StatefulWidget {
  DrawerHomePage({Key? key}) : super(key: key);

  @override
  State<DrawerHomePage> createState() => _DrawerHomePageState();
}

class _DrawerHomePageState extends State<DrawerHomePage> {
  String? userId;
  String? userRole;
  String? userName;
  String userProfileImage ="http://192.168.0.117:4000/uploads/user/profile_photo/default.jpg";
  var proDefaultImg = "assets/Logo-modified.png";
  String contactUsPhone = "(+880) 183 8288 389";
  String contactUsEmail = "hello@annadatabharat.com";
  String contactUsAddress =
      "#S6, J C Pearl Appartments, Jayalakshmamma Layout, Annapoorneshwar Nagar, Nagarabhavi 2nd Stage, Bangalore North, Bengaluru, Karnataka - 5600072";

  Future<List<CategoryListData>?> getCategoryList() async {
    // Base URL
    var baseurl = EnvConfigs.appBaseUrl+"category/list";

    Dio dio = Dio();

    try {
      Response response = await dio.get(baseurl);
      CategoryList res = CategoryList.fromJson(response.data);

      return res.data;
    } on DioError catch (e) {
      print(e);
    }
  }

  Future clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('_id');
    await prefs.remove('auth_token');
    await prefs.remove('userRole');
  }

  preLogin() {
    // return ListTile(
    //   leading: Icon(Icons.account_box_rounded),
    //   title: const Text(
    //     'My Account',
    //     style: TextStyle(color: Colors.green),
    //   ),
    //   onTap: () {
    //     Navigator.pushNamed(context, 'profilePageFarmer');
    //   },
    // );
    return SizedBox();
  }

  postLogin() {
    return ListTile(
      leading: Icon(Icons.account_box_rounded),
      title: const Text(
        'Login / Register',
        style: TextStyle(
            color: Colors.green, fontSize: 15, fontFamily: 'Rubik Regular'),
      ),
      onTap: () {
        Navigator.pushNamed(context, 'loginPage');
      },
    );
  }

  logOut() {
    return ListTile(
      leading: Icon(Icons.logout),
      title: const Text(
        'Logout',
        style: TextStyle(
            color: Colors.green, fontSize: 15, fontFamily: 'Rubik Regular'),
      ),
      onTap: () {
        clearUserData();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BottumNavBar(pageIndex: 0)));
      },
    );
  }

  getUserID() async {
    final prefs = await SharedPreferences.getInstance();

    var getuserId = prefs.getString("_id");
    var role = prefs.getString("userRole");

    setState(() {
      userId = getuserId;
      userRole = role;
    });

    log(userRole.toString());
    log(userId.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserID();

    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              // duration: Duration(seconds: 2),

              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/farm_image.jpeg"))),
              child: Container(
                // alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.0, 0.6],
                      colors: [Colors.black, Colors.transparent]),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(userProfileImage.toString(),
                            // loadingBuilder: (c,w,i){
                            // return CircularProgressIndicator();
                            // },
                            errorBuilder: (c,o,s){
                            return Icon(Icons.close);

                            },
                          ),
                        ),
                      ),
                      // CircleAvatar(
                      //   backgroundColor: Colors.orange,
                      //   radius: 47,
                      //   child: CircleAvatar(
                      //     radius: 45,
                      //     foregroundImage: NetworkImage(
                      //       userProfileImage.toString(),
                      //     ),
                      //     backgroundImage: AssetImage(proDefaultImg),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        userName == null ? "" : "Hello, " + userName.toString(),
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
              )),
          userId == null ? postLogin() : preLogin(),

          //Browse By Category DropDown in drawer
          ExpansionTile(
            childrenPadding: EdgeInsets.symmetric(horizontal: 20),
            leading: Icon(Icons.add_business_rounded),
            title: Text(
              "List of categories",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 15,
                  fontFamily: 'Rubik Regular'),
            ),
            children: [
              FutureBuilder<List<CategoryListData>?>(
                  future: getCategoryList(),
                  builder: (context, snapShot) {
                    if (!snapShot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapShot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            snapShot.data![index].categoryName.toString(),
                            style: const TextStyle(fontSize: 15),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryFilterPage(
                                        passSubCatId: "",
                                        category_id_param: snapShot
                                            .data![index].categoryId
                                            .toString(),
                                        index: index,
                                      )),
                            );
                          },
                        );
                      },
                    );
                  }),
              // ListTile(
              //   title: const Text(
              //     'View All',
              //     style: TextStyle(fontSize: 15),
              //   ),
              //   onTap: () {
              //     Navigator.pushNamed(context, '');
              //   },
              // ),
            ],
          ),

          ListTile(
            textColor: Colors.green,
            leading: Icon(Icons.list),
            //contentPadding: EdgeInsets.only(left: 20),
            title: const Text(
              'List of commodities',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 15,
                  fontFamily: 'Rubik Regular'),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommodityListPge()),
              );
            },
          ),

          // Add Product

          userRole == "farmer"
              ? ListTile(
                  textColor: Colors.green,
                  leading: Icon(Icons.add_comment),
                  //contentPadding: EdgeInsets.only(left: 20),
                  title: const Text(
                    'My ads',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontFamily: 'Rubik Regular'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProductByFarmer()),
                    );
                  },
                )
              : SizedBox(),

          // Add Logistics Company

          userRole == "logistics"
              ? ListTile(
                  textColor: Colors.green,
                  leading: Icon(Icons.add_comment),
                  //contentPadding: EdgeInsets.only(left: 20),
                  title: const Text(
                    'My company',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontFamily: 'Rubik Regular'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddLogisticCompany()),
                    );
                  },
                )
              : SizedBox(),

          // Know more Dropdown in drwaer
          ExpansionTile(
            childrenPadding: EdgeInsets.symmetric(horizontal: 20),
            leading: Icon(Icons.auto_stories),
            title: Text(
              "Know more",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 15,
                  fontFamily: 'Rubik Regular'),
            ),
            children: [
              // ListTile(
              //   title: const Text(
              //     'Privacy policy',
              //     style: TextStyle(fontSize: 15),
              //   ),
              //   onTap: () {
              //     Navigator.pushNamed(context, '');
              //   },
              // ),
              ListTile(
                title: const Text(
                  'Coverage details',
                  style: TextStyle(fontSize: 15),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'coverageDetails');
                },
              ),
              ListTile(
                title: const Text(
                  'Corporate governance',
                  style: TextStyle(fontSize: 15),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'corporateGovernance');
                },
              ),
              // ListTile(
              //   title: const Text(
              //     'Social responsibility',
              //     style: TextStyle(fontSize: 15),
              //   ),
              //   onTap: () {
              //     Navigator.pushNamed(context, '');
              //   },
              // ),
            ],
          ),

          userId == null
              ? SizedBox()
              : ListTile(
                  leading: Icon(Icons.perm_identity),
                  title: const Text(
                    'Membership details',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontFamily: 'Rubik Regular'),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const MembershipDetails(),
                    //   ),
                    // );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserMembershipDetails(),
                      ),
                    );
                  },
                ),

          ListTile(
            leading: Icon(Icons.perm_identity),
            title: const Text(
              'Buy membership plans',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 15,
                  fontFamily: 'Rubik Regular'),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MembershipDetails(),
                ),
              );

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const UserMembershipDetails(),
              //   ),
              // );
            },
          ),

          userId == null
              ? SizedBox()
              : ListTile(
                  leading: Icon(Icons.password),
                  title: const Text(
                    'Change password',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontFamily: 'Rubik Regular'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangeUserPassword(),
                      ),
                    );
                  },
                ),

          ListTile(
            leading: Icon(Icons.article),
            title: const Text(
              'Blogs',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 15,
                  fontFamily: 'Rubik Regular'),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'blogsPages');
            },
          ),

          ListTile(
            leading: Icon(Icons.info_outline),
            title: const Text(
              'About us',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 15,
                  fontFamily: 'Rubik Regular'),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'aboutUs');
            },
          ),

          // Contact Us Dropdown in drawer
          ExpansionTile(
            childrenPadding: EdgeInsets.symmetric(horizontal: 20),
            leading: Icon(Icons.contact_support),
            title: Text(
              "Contact us",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 15,
                  fontFamily: 'Rubik Regular'),
            ),
            children: [
              // ListTile(
              //   title: const Text(
              //     'Call us',
              //     style: TextStyle(fontSize: 15),
              //   ),
              //   subtitle: Text(contactUsPhone),
              //   leading: Icon(Icons.phone),
              //   onTap: () async {
              //     final url = 'tel:$contactUsPhone';

              //     // ignore: deprecated_member_use
              //     if (await canLaunch(url)) {
              //       // ignore: deprecated_member_use
              //       await launch(url);
              //     }
              //     //Navigator.pushNamed(context, '');
              //   },
              // ),
              ListTile(
                title: const Text(
                  'Email us',
                  style: TextStyle(fontSize: 15),
                ),
                subtitle: Text(contactUsEmail),
                leading: Icon(Icons.email),
                onTap: () async {
                  final url = 'mailto:$contactUsEmail';

                  // ignore: deprecated_member_use
                  if (await canLaunch(url)) {
                    // ignore: deprecated_member_use
                    await launch(url);
                  }
                  //   Navigator.pushNamed(context, '');
                },
              ),

              ListTile(
                title: const Text(
                  'Address',
                  style: TextStyle(fontSize: 15),
                ),
                subtitle: Text(contactUsAddress),
                leading: Icon(Icons.location_pin),
                onTap: () async {
                  //   Navigator.pushNamed(context, '');
                },
              ),
            ],
          ),

          // Login from drawer
          userId == null ? SizedBox() : logOut(),

          //logOut()

          // Register DropDown in Drawer
          // ExpansionTile(
          //   title: Text(
          //     "REGISTER",
          //     style: TextStyle(color: Colors.green),
          //   ),
          //   children: [
          //     ListTile(
          //       title: const Text(
          //         'Farmer',
          //         style: TextStyle(fontSize: 15),
          //       ),
          //       onTap: () {
          //         Navigator.pushNamed(context, 'registrationFarmer_FirstPage');
          //       },
          //     ),
          //     ListTile(
          //       title: const Text(
          //         'Buyer / Trader',
          //         style: TextStyle(fontSize: 15),
          //       ),
          //       onTap: () {
          //         Navigator.pushNamed(context, 'registrationTrader_FirstPage');
          //       },
          //     ),
          //     ListTile(
          //       title: const Text(
          //         'Logistic',
          //         style: TextStyle(fontSize: 15),
          //       ),
          //       onTap: () {
          //         Navigator.pushNamed(
          //             context, 'registrationLogistics_FirstPage');
          //       },
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Future<UserEditInfo?> getUserInfo() async {
    // Base URL
    var baseurl = EnvConfigs.appBaseUrl+"user/edit";

    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('_id');
    var userToken = prefs.getString('auth_token');

    var formData = FormData.fromMap({
      'user_id': userId,
    });
    print("*****userId*****");
    print(userId);

    try {
      Response response = await dio.post(
        baseurl,
        options: Options(headers: {'x-access-token': userToken}),
        data: formData,
      );

      // Data res = Data.fromJson(response.data);
      UserEditInfo res = UserEditInfo.fromJson(response.data);

      // var res = jsonDecode(response.data);

      print("Edit Responce");
      print(res.message);

      var item = res.data![0];

      print(item.profilePhoto.toString());

      setState(() {
        userProfileImage = item.profilePhoto.toString();
        userName = item.name.toString();
      });
      setState(() {

      });

      print("******userProfileImage*****");
      print(userProfileImage);

      return res;
    } on DioError catch (e) {
      print(e);
    }
    return null;
  }
}

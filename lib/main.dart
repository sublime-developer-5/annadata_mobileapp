import 'package:annadata/Test/no_data_found.dart';
import 'package:annadata/Test/profile_test_screen.dart';
import 'package:annadata/screens/allCategories.dart';
import 'package:annadata/screens/Logistic%20Registration/_LogisticReg_FirstPage.dart';
import 'package:annadata/screens/Logistic%20Registration/_LogisticReg_SecondPage.dart';
import 'package:annadata/screens/Trader%20Registration/_TraderReg_ThirdPage.dart';
import 'package:annadata/screens/aboutUs.dart';
import 'package:annadata/screens/blogs.dart';
import 'package:annadata/screens/corporateGovrnace.dart';
import 'package:annadata/screens/coverageDetails.dart';
import 'package:annadata/screens/forgetPassword.dart';
import 'package:annadata/screens/profilePageFarmer.dart';
import 'package:annadata/screens/updatePassword.dart';
import 'package:annadata/widgets/HomeScreen/homeBottumNavBar.dart';
import 'package:annadata/widgets/test_image_picker.dart';
import 'package:annadata/screens/Farmer%20Registration/_FarmerReg_SecondPage.dart';
import 'package:annadata/screens/Farmer%20Registration/_FarmerReg_ThirdPage.dart';
import 'package:annadata/screens/Trader%20Registration/_TraderReg_FirstPage.dart';
import 'package:annadata/screens/Trader%20Registration/_TraderReg_SecondPage.dart';
import 'package:annadata/screens/farmer%20registration/far_regi_FirstPage.dart';
import 'package:annadata/screens/homepage.dart';
import 'package:annadata/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? storedToken;

  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth_token");
    setState(() {
      storedToken = token;
    });
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomePage(),
        initialRoute: 'bottumNavBar',
        // initialRoute: 'test_page',
        //initialRoute: storedToken == null ? "loginPage" : "homePage",
        routes: {
          //Login Section
          'loginPage': (context) => const LoginPage(),
          // Farmer Section
          'registrationFarmer_FirstPage': (context) =>
              const FarmerRegistrationFirstpage(),
          'registrationFarmer_SecondPage': (context) =>
              const FarmerRegSecondPage(),
          'registrationFarmer_ThirdPage': (context) =>
              const FarmerRegThirdPage(),

          // Profile Page
          'profilePageFarmer': (context) => const ProfilePageFarmer(),
          'ProfileTestScreen': (context) => const ProfileTestScreen(),

          // Trader Section
          'registrationTrader_FirstPage': (context) =>
              const TraderRegFirstPage(),
          'registrationTrader_SecondPage': (context) =>
              const TraderRegSecondPage(),
          'registrationTrader_ThirdPage': (context) =>
              const TraderRegThirdPage(),

          //Logistic Section
          'registrationLogistics_FirstPage': (context) =>
              const LogisticRegFirstPage(),
          'registrationLogistic_SecondPage': (context) =>
              const LogisticRegSecondPage(),

          // 'logisticList': (context) => const LogisticsListPage(),

          //Home Section
          'homePage': (context) => HomePage(),
          'bottumNavBar': (context) => BottumNavBar(pageIndex: 0),

          //Category Section
          // 'categoryFilterPage': (context) => const CategoryFilterPage(),
          'test_page': (context) => UpdateUserPassword(userEmailID: ""),

          //Product Page
          // 'productPage': (context) => ProductPage(
          //       product_id: ,
          //     ),

          //About Us
          'aboutUs': (context) => const AboutUs(),
          // Blogs
          'blogsPages': (context) => const BlogsPage(),

          //Corporate Governance
          'corporateGovernance': (context) => const CorporateGovernance(),

          //Coverage Details
          'coverageDetails': (context) => const CoverageDetails(),

          //Test Pages

          'noDataFound': (context) => const NoDataFound(),

          // Categories

          'allCategories': (context) => const AllCategories(),

          'forgetPassword': (context) => const ForgetPassword(),
        });
  }
}

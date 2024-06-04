import 'dart:developer';

import 'package:annadata/Model/categoryCopy.dart';
import 'package:annadata/Test/search_page_test.dart';
import 'package:annadata/screens/categoryFilterPage.dart';
import 'package:annadata/screens/commodityListPage.dart';
import 'package:annadata/widgets/HomeScreen/bannerSlider.dart';
import 'package:annadata/widgets/HomeScreen/blogsSliderHome.dart';
import 'package:annadata/widgets/HomeScreen/drawerHomePage.dart';
import 'package:annadata/widgets/HomeScreen/facilityPanel.dart';
import 'package:annadata/widgets/HomeScreen/membershipPanel.dart';
import 'package:annadata/widgets/HomeScreen/shopByCatHome.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:search_page/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../env.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryListData> categoryList = [];
  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth_token");
    final userId = prefs.getString("_id");
    final role = prefs.getString("userRole");

    log("User Id*****");
    log(userId.toString());

    log("token");
    log(token.toString());
    log("Role******");
    log(role.toString());
  }

  @override
  void initState() {
    getToken();
    super.initState();
     getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerHomePage(),
      // bottomNavigationBar: BottumNavBar(),
      appBar: AppBar(
        leadingWidth: 25,
        actions: [
          IconButton(
              onPressed: () => showSearch(
                  context: context,
                  delegate: SearchPage<CategoryListData>(
                      barTheme: ThemeData(
                          inputDecorationTheme: InputDecorationTheme(
                              hintStyle: TextStyle(color: Colors.white)),
                          textSelectionTheme: TextSelectionThemeData(
                            cursorColor: Colors.white,
                          ),
                          textTheme: TextTheme(
                              headlineSmall: TextStyle(color: Colors.white)),
                          appBarTheme:
                              AppBarTheme(backgroundColor: Colors.green)),
                      searchLabel: "Search categories",
                      builder: (category) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CommodityListPge(
                                    cat_id_param:
                                        category.categoryId.toString(),
                                  ),
                                ));
                          },
                          child: ListTile(
                            leading: SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.network(
                                    category.categoryImg.toString())),
                            title: Text(category.categoryName.toString()),
                          )),
                      filter: (category) => [category.categoryName.toString()],
                      items: categoryList.toList())),
              // () {
              //   Navigator.push(
              //       context,
              //       PageTransition(
              //           child: TestSearchPage(),
              //           type: PageTransitionType.rightToLeft));
              // },
              icon: Icon(Icons.search))
        ],
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  height: 45,
                  child: const Image(
                    image: const AssetImage(
                      'assets/Logo-modified.png',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "ANNADATA",
              style: TextStyle(fontFamily: 'Rubik Regular'),
            ),
          ],
        ),
        //actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
      ),
      // body: NestedScrollView(
      //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      //     return [
      //       SliverAppBar(
      //         expandedHeight: 60,
      //         title: SizedBox(
      //           height: 40,
      //           child: TextFormField(
      //             //textAlign: TextAlign.center,
      //             decoration: InputDecoration(
      //                 alignLabelWithHint: true,
      //                 suffixIcon: IconButton(
      //                   icon: Icon(Icons.search),
      //                   onPressed: () {},
      //                 ),
      //                 fillColor: Colors.white,
      //                 filled: true,
      //                 border: OutlineInputBorder(
      //                     borderRadius: BorderRadius.circular(8),
      //                     borderSide: const BorderSide(color: Colors.orange)),
      //                 contentPadding: const EdgeInsets.symmetric(
      //                     horizontal: 15, vertical: 1),
      //                 hintText: "Search Category / Commodity",
      //                 hintStyle:
      //                     TextStyle(fontSize: 14, fontFamily: 'Rubik Regular'),
      //                 enabledBorder: OutlineInputBorder(
      //                     borderRadius: BorderRadius.circular(8),
      //                     borderSide: const BorderSide(color: Colors.orange)),
      //                 focusedBorder: OutlineInputBorder(
      //                     borderRadius: BorderRadius.circular(8),
      //                     borderSide: const BorderSide(color: Colors.green))),
      //           ),
      //         ),
      //         floating: true,
      //         elevation: 0,
      //         snap: true,
      //         automaticallyImplyLeading: false,
      //       ),
      //     ];
      //   },
      body: SingleChildScrollView(
        child: Column(
          children: [
            const BannerSlider(),
        
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              height: 2,
              color: Color.fromARGB(255, 223, 221, 221),
            ),
        
            FacilityPanel(),
        
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              height: 2,
              color: Color.fromARGB(255, 223, 221, 221),
            ),
        
            SizedBox(
              height: 10,
            ),
        
            ShopByCatHome(),
        
            SizedBox(
              height: 10,
            ),
        
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              height: 2,
              color: Color.fromARGB(255, 223, 221, 221),
            ),
        
            MembershipPanelHome(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              height: 2,
              color: Color.fromARGB(255, 223, 221, 221),
            ),
        
            BlogsSliderHome(),
        
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              height: 2,
              color: Color.fromARGB(255, 223, 221, 221),
            ),
        
            // const CategorySliderHorizontal(),
        
            // const CategoryPanle(),
            //const SubCardCategory(),
          ],
        ),
      ),
    );
  }

  Future<List<CategoryListData>?> getCategoryList() async {
    // Base URL
    var baseurl = EnvConfigs.appBaseUrl+"category/list";

    Dio dio = Dio();

    try {
      Response response = await dio.get(baseurl);
      CategoryList res = CategoryList.fromJson(response.data);

      setState(() {
        categoryList = res.data!;
      });

      log(categoryList.toString());

      return res.data;
    } on DioError catch (e) {
      print(e);
    }
  }
}

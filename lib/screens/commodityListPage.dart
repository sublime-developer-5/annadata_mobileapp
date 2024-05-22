import 'package:annadata/Model/categoryCopy.dart';
import 'package:annadata/Model/subCatModel.dart';
import 'package:annadata/screens/categoryFilterPage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../env.dart';

class CommodityListPge extends StatefulWidget {
  CommodityListPge({Key? key, this.cat_id_param}) : super(key: key);

  String? cat_id_param;

  @override
  State<CommodityListPge> createState() => _CommodityListPgeState();
}

class _CommodityListPgeState extends State<CommodityListPge> {
  final scrollControllerSubCat = ScrollController();

  final scrollController = ScrollController();

  int? scrollIndex;

  String? categoryId = "";
  String all = "?";
  String? subCatId;
  Color activeColor = Colors.green;
  Color inactiveColor = Color.fromARGB(255, 204, 202, 202);
  Color inactiveColorText = Colors.black;
  Color activeColorText = Colors.white;

  scrollToIndexSubCat(index) async {
    await scrollControllerSubCat.animateTo(100.0 * index,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  scrollToIndex(index) async {
    await scrollController.animateTo(100.0 * index,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var subParam_id = "=" + widget.cat_id_param.toString();
    setState(() {
      categoryId = subParam_id == "=null" ? "" : subParam_id;
    });

    debugPrint("***---***categoryId***---***");
    debugPrint(widget.cat_id_param.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Commodities"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 15),
            child: Row(
              children: [
                Text(
                  "Categories",
                  style: TextStyle(fontFamily: 'Rubik Regular'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            //margin: EdgeInsets.only(top: 20),
            height: 40,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: categoryId == ""
                            ? activeColorText
                            : inactiveColorText, backgroundColor:
                            categoryId == "" ? activeColor : inactiveColor,
                      ),
                      onPressed: () {
                        setState(() {
                          categoryId = "";
                        });
                      },
                      child: const Text("All")),
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FutureBuilder<List<CategoryListData>?>(
                        future: getCategoryList(),
                        builder: (context, snapShot) {
                          if (!snapShot.hasData) {
                            return Shimmer.fromColors(
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 10,
                                    itemBuilder: (_, __) {
                                      return SizedBox(
                                        height: 40,
                                        width: 80,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          elevation: 5,
                                        ),
                                      );
                                    }),
                                baseColor: Colors.white,
                                highlightColor: Colors.grey.shade300);
                          }
                          return ListView.builder(
                              controller: scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapShot.data!.length,
                              itemBuilder: (BuildContext context, index) {
                                print(snapShot.data![index].categoryImg);
                                print(
                                    "************************ snapShot.data **********************");
                                final catId =
                                    snapShot.data![index].categoryId.toString();

                                return SizedBox(
                                  height: 40,
                                  child: Card(
                                    color: categoryId == "=" + catId
                                        ? activeColor
                                        : inactiveColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    elevation: 2,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 3),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(5),
                                      highlightColor: Colors.green,
                                      focusColor: Colors.green,
                                      onTap: () {
                                        scrollToIndex(index);

                                        setState(() {
                                          //all = "";
                                          categoryId = "=" + catId;
                                          subCatId = "";
                                        });

                                        debugPrint("all****");
                                        debugPrint(all);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              snapShot.data![index].categoryName
                                                  .toString(),
                                              style: TextStyle(
                                                  color:
                                                      categoryId == "=" + catId
                                                          ? activeColorText
                                                          : inactiveColorText),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 15),
            child: Row(
              children: [
                Text(
                  "Commodities",
                  style: TextStyle(fontFamily: 'Rubik Regular'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 2,
            child: FutureBuilder<List<SubCatData>?>(
                future: getSubCategoryList(),
                builder: (context, snapShot) {
                  if (!snapShot.hasData) {
                    return Shimmer.fromColors(
                        child: GridView.builder(
                            padding: EdgeInsets.all(20),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 150,
                                    childAspectRatio: 3 / 3.8,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5),
                            itemCount: 10,
                            itemBuilder: (_, __) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 5,
                              );
                            }),
                        baseColor: Colors.white,
                        highlightColor: Colors.grey.shade300);
                  } else if (snapShot.data!.length == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset(
                            "assets/no_products_found.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "No Commodities Found",
                          style: TextStyle(
                              fontFamily: 'Rubik Regular', fontSize: 18),
                        ),
                      ],
                    );
                  }
                  return GridView.builder(
                      padding: EdgeInsets.all(20),
                      scrollDirection: Axis.vertical,
                      itemCount: snapShot.data?.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          childAspectRatio: 3 / 3.8,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String subCategoryId =
                            snapShot.data![index].subCategoryId.toString();
                        return InkWell(
                          enableFeedback: true,
                          autofocus: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryFilterPage(
                                          passSubCatId:
                                              subCategoryId.toString(),
                                          category_id_param: snapShot
                                              .data![index].categoryId
                                              .toString(),
                                          index: index,
                                        )));
                            print("********* subCategoryId ********");
                            print(subCategoryId);
                          },
                          child: Card(
                            // margin: EdgeInsets.symmetric(vertical: 5),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Image.network(snapShot
                                            .data![index].subCategoryImg
                                            .toString()),
                                      ),
                                    ),
                                    // CircleAvatar(
                                    //   backgroundImage: NetworkImage(
                                    //     snapShot.data![index].categoryImg
                                    //         .toString(),
                                    //   ),
                                    //   backgroundColor: Colors.grey,
                                    //   radius: 30,
                                    // ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      snapShot.data![index].subCategoryName
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ]),
                            ),
                          ),
                        );
                      });
                }),
          )
        ],
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

      return res.data;
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<List<SubCatData>?> getSubCategoryList() async {
    // Base URL
    var baseurl =
        EnvConfigs.appBaseUrl+"sub_category/list?category_id$categoryId";

    Dio dio = Dio();

    try {
      Response response = await dio.get(baseurl);
      SubCategoryList res = SubCategoryList.fromJson(response.data);

      debugPrint("baseurl***");
      debugPrint(baseurl);

      return res.data;
    } on DioError catch (e) {
      print(e);
    }
  }
}

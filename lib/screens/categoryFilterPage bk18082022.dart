import 'dart:async';
import 'package:annadata/Model/categoryCopy.dart';
import 'package:annadata/Model/subCatModel.dart';
import 'package:annadata/widgets/filterListCard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryFilterPage extends StatefulWidget {
  CategoryFilterPage(
      {Key? key, this.category_id_param, this.index, this.passSubCatId})
      : super(key: key);

  String? category_id_param = "";
  String? passSubCatId = "";
  int? index;

  @override
  State<CategoryFilterPage> createState() => _CategoryFilterPageState();
}

class _CategoryFilterPageState extends State<CategoryFilterPage> {
  bool filtercheckBox = true;

  String cate_Item = "Category";

  String categoryId = "";
  String? subCatId;
  String? select_Cat;

  Color activeColor = Colors.green;
  Color inactiveColor = Colors.white;
  Color inactiveColorText = Colors.black;
  Color activeColorText = Colors.white;

  final scrollController = ScrollController();
  final scrollControllerSubCat = ScrollController();

  @override
  void initState() {
    super.initState();

    print("********* subCategoryId ********");
    print(widget.passSubCatId.toString());

    setState(() {
      categoryId = widget.category_id_param.toString();
      subCatId = subCatId == null ? "" : widget.passSubCatId.toString();
    });
    Timer(Duration(seconds: 1),
        () => {scrollToIndex(widget.index), scrollToIndexSubCat(widget.index)});
  }

  scrollToIndex(index) async {
    await scrollController.animateTo(45.0 * index,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  scrollToIndexSubCat(index) async {
    await scrollControllerSubCat.animateTo(
        MediaQuery.of(context).size.width / 5 * index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 218, 216, 216),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Category"),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 60,
              floating: true,
              automaticallyImplyLeading: false,
              title: SizedBox(
                height: 40,
                child: TextFormField(
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.orange)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Search Category / Commodity",
                      // hintStyle: TextStyle(fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.orange)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.green))),
                ),
              ),
            ),
          ];
        },
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
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
                                            BorderRadius.circular(10)),
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
                              color: categoryId == catId
                                  ? activeColor
                                  : inactiveColor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5),
                                highlightColor: Colors.green,
                                focusColor: Colors.green,
                                onTap: () {
                                  scrollToIndex(index);

                                  print(catId);
                                  setState(() {
                                    categoryId = catId;
                                    subCatId = "";
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        snapShot.data![index].categoryName
                                            .toString(),
                                        style: TextStyle(
                                            color: categoryId == catId
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
            // Container(
            //   margin: const EdgeInsets.symmetric(
            //     vertical: 5,
            //   ),
            //   height: 2,
            //   color: const Color.fromARGB(255, 223, 221, 221),
            // ),

            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextButton(
                        style: TextButton.styleFrom(
                          primary: subCatId == ""
                              ? activeColorText
                              : inactiveColorText,
                          backgroundColor:
                              subCatId == "" ? activeColor : inactiveColor,
                        ),
                        onPressed: () {
                          setState(() {
                            subCatId = "";
                          });
                        },
                        child: const Text("All")),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FutureBuilder<List<SubCatData>?>(
                          future: getSubCategoryList(),
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
                                                    BorderRadius.circular(25)),
                                            elevation: 5,
                                          ),
                                        );
                                      }),
                                  baseColor: Colors.white,
                                  highlightColor: Colors.grey.shade300);
                            }
                            return ListView.builder(
                                controller: scrollControllerSubCat,
                                shrinkWrap: true,
                                addSemanticIndexes: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapShot.data!.length,
                                itemBuilder: (BuildContext context, index) {
                                  // Color activeColor = Colors.green;
                                  // Color inactiveColor = Colors.white;
                                  // Color inactiveColorText = Colors.black;
                                  // Color activeColorText = Colors.white;
                                  final subCategoryId = snapShot
                                      .data![index].subCategoryId
                                      .toString();
                                  return SizedBox(
                                    height: 40,
                                    child: Card(
                                      color: subCatId == subCategoryId
                                          ? activeColor
                                          : inactiveColor,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25))),
                                      elevation: 2,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 3),
                                      child: InkWell(
                                        hoverColor: Colors.green,
                                        onTap: () {
                                          scrollToIndexSubCat(index);
                                          print("subCategoryId");
                                          print(subCategoryId);
                                          setState(() {
                                            subCatId = subCategoryId;
                                          });
                                          print("subCatId");
                                          print(subCatId);
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
                                                snapShot.data![index]
                                                    .subCategoryName
                                                    .toString(),
                                                style: TextStyle(
                                                    color: subCatId ==
                                                            subCategoryId
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
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              height: 2,
              color: const Color.fromARGB(255, 223, 221, 221),
            ),
            ProductListCard(
              cat_id: categoryId,
              sub_id: subCatId,
            )
          ],
        ),
      ),
    );
  }

  sort_bottomSheet() {
    int sortValue = 1;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: double.infinity),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(border: Border.all(width: 0.5)),
            child: const Text(
              'SORT BY',
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          RadioListTile(
              title: const Text('Popularity'),
              value: 1,
              groupValue: sortValue,
              onChanged: (Value) {
                setState(() {
                  sortValue = Value as int;
                });
              }),
          RadioListTile(
              title: const Text('Newest First'),
              value: 2,
              groupValue: sortValue,
              onChanged: (Value) {
                setState(() {
                  sortValue = Value as int;
                });
              }),
          RadioListTile(
              title: const Text('Quantity -- Low to High'),
              value: 3,
              groupValue: sortValue,
              onChanged: (Value) {
                setState(() {
                  sortValue = Value as int;
                });
              }),
          RadioListTile(
              title: const Text('Quantity -- High to Low'),
              value: 4,
              groupValue: sortValue,
              onChanged: (Value) {
                setState(() {
                  sortValue = Value as int;
                });
              })
        ],
      ),
    );
  }

  filter_BottomSheet() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "    Filter By",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 1,
            color: Colors.orange,
            thickness: 1,
          ),
          Row(
            children: [
              Container(
                width: 120,
                child: Column(
                  children: [
                    InkWell(
                      // focusColor: Color.fromRGBO(229, 229, 229, 100),
                      onTap: () {},
                      child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(196, 196, 196, 100)),
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text("Categories")),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    InkWell(
                      // focusColor: Color.fromRGBO(229, 229, 229, 100),
                      onTap: () {},
                      child: Container(
                          decoration: const BoxDecoration(
                              color: const Color.fromRGBO(196, 196, 196, 100)),
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text("Categories")),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    InkWell(
                      // focusColor: Color.fromRGBO(229, 229, 229, 100),
                      onTap: () {},
                      child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(196, 196, 196, 100)),
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text("Categories")),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Checkbox(
                  value: this.filtercheckBox,
                  onChanged: (bool? value) {
                    setState(() {
                      this.filtercheckBox = value!;
                    });
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<List<CategoryListData>?> getCategoryList() async {
    // Base URL
    var baseurl = "http://161.97.138.56:3021/mobile/category/list";

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
        "http://161.97.138.56:3021/mobile/sub_category/list?category_id=$categoryId";

    Dio dio = Dio();

    try {
      Response response = await dio.get(baseurl);
      SubCategoryList res = SubCategoryList.fromJson(response.data);

      return res.data;
    } on DioError catch (e) {
      print(e);
    }
  }
}

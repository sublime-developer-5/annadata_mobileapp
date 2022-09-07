import 'package:annadata/Model/categoryCopy.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../screens/categoryFilterPage.dart';

class ShopByCatHome extends StatefulWidget {
  const ShopByCatHome({Key? key}) : super(key: key);

  @override
  State<ShopByCatHome> createState() => _ShopByCatHomeState();
}

class _ShopByCatHomeState extends State<ShopByCatHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Browse By Categories",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Rubik Regular'),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: SizedBox(
            // height: 500,
            child: FutureBuilder<List<CategoryListData>?>(
                future: getCategoryList(),
                builder: (context, snapShot) {
                  if (!snapShot.hasData) {
                    return Shimmer.fromColors(
                        child: GridView.builder(
                            padding: EdgeInsets.all(20),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 150,
                                    childAspectRatio: 3 / 4,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 9,
                            itemBuilder: (_, __) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 5,
                              );
                            }),
                        baseColor: Colors.white,
                        highlightColor: Colors.grey.shade300);
                  }
                  return Container(
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          childAspectRatio: 3 / 4,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      itemCount: snapShot.data!.length,
                      itemBuilder: (BuildContext context, index) {
                        var cat_id = snapShot.data![index].categoryId;
                        return InkWell(
                          enableFeedback: true,
                          autofocus: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryFilterPage(
                                          passSubCatId: "",
                                          category_id_param: cat_id.toString(),
                                          index: index,
                                        )));
                            //  Navigator.pushNamed(context, 'categoryFilterPage');
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

                                        // child: Image.network(snapShot
                                        //     .data![index].categoryImg
                                        //     .toString()),
                                        child: CachedNetworkImage(
                                            imageUrl: snapShot
                                                .data![index].categoryImg
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
                                      snapShot.data![index].categoryName
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ]),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
          ),
        ),
      ]),
    );
  }

  Future<List<CategoryListData>?> getCategoryList() async {
    // Base URL
    const baseurl = "http://161.97.138.56:3021/mobile/category/list";

    Dio dio = Dio();

    try {
      Response response = await dio.get(baseurl);
      CategoryList res = CategoryList.fromJson(response.data);
      return res.data;
    } on DioError catch (e) {
      print(e);
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../Model/categoryCopy.dart';
import '../env.dart';

class ShopByCatHome2 extends StatefulWidget {
  const ShopByCatHome2({Key? key}) : super(key: key);

  @override
  State<ShopByCatHome2> createState() => _ShopByCatHome2State();
}

class _ShopByCatHome2State extends State<ShopByCatHome2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Shop By Categories",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    return Center(child: const CircularProgressIndicator());
                  }
                  return Container(
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 4,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      itemCount: snapShot.data!.length,
                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          enableFeedback: true,
                          autofocus: true,
                          onTap: () {
                            Navigator.pushNamed(context, 'categoryFilterPage');
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
                                      height: 150,
                                      width: 150,
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Image.network(snapShot
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
    const baseurl = EnvConfigs.appBaseUrl+"category/list";

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

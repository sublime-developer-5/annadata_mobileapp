import 'package:annadata/Model/categoryCopy.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../env.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  final catlist = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryListData>?>(
      future: getCategoryList(),
      builder: (context, snapShot) {
        if (!snapShot.hasData) {
          return Center(child: const CircularProgressIndicator());
        }
        return SizedBox(
          // height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            //itemCount: snapShot.data!.length,
            itemCount: 5,
            itemBuilder: (context, index) {
              return InkWell(
                enableFeedback: true,
                autofocus: true,
                onTap: () {
                  Navigator.pushNamed(context, "testSubCatApi");
                },
                child: Card(
                  // margin: EdgeInsets.symmetric(vertical: 5),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            snapShot.data![index].categoryImg.toString(),
                          ),
                          backgroundColor: Colors.grey,
                          radius: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        snapShot.data![index].categoryName.toString(),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ]),
                  ),
                ),
              );
            },
          ),
        );
      },
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

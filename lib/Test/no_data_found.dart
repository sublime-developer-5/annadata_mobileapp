import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../Model/productModel.dart';
import '../Model/subCatModel.dart';
import '../env.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<SubCatData>?>(
          future: getSubCategoryList(),
          builder: (context, snapShot) {
            print(snapShot.data!.length);
            if (!snapShot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else if (snapShot.data!.length == 0) {
              return Center(child: Text("no data"));
            }
            return ListView.builder(
                itemCount: snapShot.data!.length,
                itemBuilder: (BuildContext context, index) {
                  return Column(
                    children: [
                      Text(snapShot.data![index].categoryName.toString()),
                      Text("Data"),
                    ],
                  );
                });
          }),
    );
  }

  Future<List<SubCatData>?> getSubCategoryList() async {
    // Base URL
    var baseurl =
        EnvConfigs.appBaseUrl+"sub_category/list?category_id=111";

    Dio dio = Dio();

    try {
      Response response = await dio.get(baseurl);
      SubCategoryList res = SubCategoryList.fromJson(response.data);

      // print(res.success);
      // print(res.data);

      return res.data;
    } on DioError catch (e) {
      print(e);
    }
  }
}

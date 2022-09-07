import 'dart:developer';

import 'package:annadata/screens/categoryFilterPage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';

import '../Model/categoryCopy.dart';

class TestSearchPage extends StatefulWidget {
  const TestSearchPage({Key? key}) : super(key: key);

  @override
  State<TestSearchPage> createState() => _TestSearchPageState();
}

class _TestSearchPageState extends State<TestSearchPage> {
  List<CategoryListData> categoryList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () => showSearch(
                context: context,
                delegate: SearchPage<CategoryListData>(
                    builder: (category) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryFilterPage(
                                  category_id_param:
                                      category.categoryId.toString(),
                                ),
                              ));
                        },
                        child: Text(category.categoryName.toString())),
                    filter: (category) => [category.categoryName.toString()],
                    items: categoryList.toList())),
            icon: Icon(Icons.search))
      ]),
      body: FutureBuilder<List<CategoryListData>?>(
        future: getCategoryList(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Text(snapshot.data![index].categoryName.toString());
            },
          );
        },
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

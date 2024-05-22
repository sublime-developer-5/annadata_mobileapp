import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:annadata/Model/categoryCopy.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("All Categories"),
        ),
        body: FutureBuilder<List<CategoryListData>?>(
          future: getCategoryList(),
          builder: (context, snapShot) {
            if (!snapShot.hasData) {
              return Center(child: const CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: snapShot.data!.length,
                itemBuilder: (BuildContext context, index) {
                  return InkWell(
                    enableFeedback: true,
                    autofocus: true,
                    onTap: () {},
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
                            backgroundImage: NetworkImage(
                              snapShot.data![index].categoryImg.toString(),
                            ),
                            backgroundColor: Colors.grey,
                            radius: 30,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            snapShot.data![index].categoryName.toString(),
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
        ));
  }

  Future<List<CategoryListData>?> getCategoryList() async {
    // Base URL
    const baseurl = "EnvConfigs.appBaseUrlcategory/list";

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

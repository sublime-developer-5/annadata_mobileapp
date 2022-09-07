import 'package:annadata/Model/blogsListModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'blogIndusvalPage.dart';

class BlogsPage extends StatelessWidget {
  const BlogsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Blogs")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder<List<Data>?>(
            future: getBlogData(),
            builder: (context, snapShot) {
              if (!snapShot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 190,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5),
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),

                itemCount: snapShot.data!.length,
                //itemCount: 2,
                itemBuilder: (context, index) {
                  var blogImg = snapShot.data![index].blogImage.toString();
                  return Card(
                    // margin: EdgeInsets.symmetric(vertical: 5),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, right: 10, left: 10, bottom: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 150,
                              // decoration: BoxDecoration(
                              //     color: Colors.red,
                              //     borderRadius: BorderRadius.only(
                              //         topLeft: Radius.circular(50),
                              //         topRight: Radius.circular(50))),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.network(
                                    blogImg,
                                    fit: BoxFit.fill,
                                    errorBuilder:
                                        (context, error, stacktrace) =>
                                            Image.asset(
                                      "assets/Logo-modified.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                      left: 0,
                                      top: 10,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(2),
                                        //color: Colors.orange,
                                        //height: 20,
                                        // width: 35,
                                        decoration: const BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius: const BorderRadius
                                                    .only(
                                                topRight:
                                                    const Radius.circular(5),
                                                bottomRight:
                                                    const Radius.circular(5))),
                                        child: Text(
                                          snapShot.data![index].addDate
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              snapShot.data![index].title.toString(),
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Rubik Regular'),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              snapShot.data![index].description.toString(),
                              style:
                                  const TextStyle(fontFamily: 'Rubik Regular'),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  child: const Text(
                                    "Read More",
                                    style: TextStyle(
                                        fontFamily: 'Rubik Regular',
                                        color: Colors.green),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BlogsIndusval(
                                                get_BlogName: snapShot
                                                    .data![index].title
                                                    .toString(),
                                                get_blog_Id: snapShot
                                                    .data![index].blogId
                                                    .toString(),
                                              )),
                                    );
                                  },
                                )
                                // TextButton(
                                //     onPressed: () {},
                                //     child: Text("Know More"))
                              ],
                            )
                          ]),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }

  Future<List<Data>?> getBlogData() async {
    // Base URL
    var baseurl = "http://161.97.138.56:3021/mobile/blog/list";

    Dio dio = Dio();

    try {
      Response response = await dio.get(baseurl);
      BlogsListModel res = BlogsListModel.fromJson(response.data);

      return res.data;
    } on DioError catch (e) {
      print(e);
    }
  }
}

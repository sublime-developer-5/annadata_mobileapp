import 'package:annadata/Model/blogsListModel.dart';
import 'package:annadata/screens/blogIndusvalPage.dart';
import 'package:annadata/screens/blogs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../env.dart';

class BlogsSliderHome extends StatefulWidget {
  const BlogsSliderHome({Key? key}) : super(key: key);

  @override
  State<BlogsSliderHome> createState() => _BlogsSliderHomeState();
}

class _BlogsSliderHomeState extends State<BlogsSliderHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          "Our Blogs Post",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Rubik Regular'),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: FutureBuilder<List<Data>?>(
              future: getBlogData(),
              builder: (context, snapShot) {
                if (!snapShot.hasData) {
                  return Shimmer.fromColors(
                      child: GridView.builder(
                          padding: EdgeInsets.all(20),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 190,
                                  childAspectRatio: 3 / 4,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4,
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

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 190,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // itemCount: snapShot.data!.length,
                  itemCount: 4,
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
                                    CachedNetworkImage(
                                      imageUrl: blogImg,
                                      fit: BoxFit.fill,
                                    ),
                                    // Image.network(
                                    //   blogImg,
                                    //   fit: BoxFit.fill,
                                    //   errorBuilder:
                                    //       (context, error, stacktrace) =>
                                    //           Image.asset(
                                    //     "assets/Logo-modified.png",
                                    //     fit: BoxFit.cover,
                                    //   ),
                                    // ),
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
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          const Radius.circular(
                                                              5),
                                                      bottomRight:
                                                          const Radius.circular(
                                                              5))),
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
                                style: const TextStyle(
                                    fontFamily: 'Rubik Regular'),
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
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BlogsPage()),
                  );
                },
                child: const Text("View More"))
          ],
        ),
      ]),
    );
  }

  Future<List<Data>?> getBlogData() async {
    // Base URL
    const baseurl = EnvConfigs.appBaseUrl+"blog/list";

    Dio dio = Dio();

    try {
      Response response = await dio.get(
        baseurl,
      );
      BlogsListModel res = BlogsListModel.fromJson(response.data);
      return res.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    }
  }
}

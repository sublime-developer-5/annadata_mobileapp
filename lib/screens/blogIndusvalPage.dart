import 'package:annadata/Model/blog_Info_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../env.dart';

class BlogsIndusval extends StatefulWidget {
  BlogsIndusval(
      {Key? key, required this.get_blog_Id, required this.get_BlogName})
      : super(key: key);

  String get_blog_Id = "";
  String get_BlogName;

  @override
  State<BlogsIndusval> createState() => _BlogsIndusvalState();
}

class _BlogsIndusvalState extends State<BlogsIndusval> {
  Future<List<Data>?> getBlogInfo() async {
    // Base URL
    var baseurl = EnvConfigs.appBaseUrl+"blog/getinfo";

    Dio dio = Dio();

    try {
      Response response =
          await dio.post(baseurl, data: {"blog_id": widget.get_blog_Id});
      BlogInfoModel res = BlogInfoModel.fromJson(response.data);
      print(res.toJson());

      // var resData = jsonDecode(res.toString());
      // debugPrint(resData);

      return res.data;
    } on DioError catch (e) {
      print(e);
    }
    return null;
  }

  @override
  void initState() {
    print(widget.get_BlogName.toString());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.get_BlogName.toString()),
      ),
      body: FutureBuilder<List<Data>?>(
          future: getBlogInfo(),
          builder: (context, snapShot) {
            var item = snapShot.data;
            if (!snapShot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Image.network(
                      item![0].blogImage.toString(),
                      // fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.calendar_month),
                      Text(
                        "  " + item[0].addDate.toString(),
                        style: TextStyle(fontFamily: 'Rubik Regular'),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    item[0].title.toString(),
                    style: TextStyle(
                        fontFamily: 'Rubik Regular',
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Text(
                    item[0].description.toString(),
                    style: TextStyle(fontFamily: 'Rubik Regular'),
                  )
                ],
              ),
            );
          }),
    );
  }
}

import 'package:annadata/Model/logistic_list_by_product_id_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../env.dart';

class LogisticsListCard extends StatefulWidget {
  LogisticsListCard({Key? key, this.productId}) : super(key: key);

  String? productId;

  @override
  State<LogisticsListCard> createState() => _LogisticsListCardState();
}

class _LogisticsListCardState extends State<LogisticsListCard> {
  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Data>?>(
        future: getLogisticList(),
        builder: (context, snapShot) {
          if (!snapShot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapShot.data!.length == 0) {
            return Center(
              child: Text(
                "No Logistics Found",
                style: TextStyle(fontFamily: 'Rubik Regular', fontSize: 18),
              ),
            );
          }

          return ListView.builder(
              itemCount: snapShot.data!.length,
              itemBuilder: (context, index) {
                String logisticByProductId = widget.productId.toString();
                final logisticPhone =
                    snapShot.data![index].logisticsContact.toString();
                // if (!snapShot.hasData) {
                //   return const Center(child: CircularProgressIndicator());
                // }
                return InkWell(
                  onTap: () {
                    // Navigator.pushNamed(context, 'productPage');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    //height: MediaQuery.of(context).size.height,
                    //padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(border: Border.all(width: 0.1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Container(
                        //   height: 80,
                        //   width: 80,
                        //   padding: EdgeInsets.symmetric(horizontal: 10),
                        //   child: Image.network(
                        //       "https://www.freeiconspng.com/uploads/logistics-icon-png-3.png"
                        //       ),
                        // ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      snapShot.data![index].logisticsName
                                          .toString(),
                                      maxLines: 3,
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(snapShot
                                      .data![index].logisticsFromPincode
                                      .toString())
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    final url = 'tel:$logisticPhone';

                                    //ignore: deprecated_member_use
                                    if (await canLaunch(url)) {
                                      // ignore: deprecated_member_use
                                      await launch(url);
                                    }
                                  },
                                  //  {
                                  //   showDialog(
                                  //       useSafeArea: true,
                                  //       context: context,
                                  //       builder: (
                                  //         context,
                                  //       ) {
                                  //         return Dialog(
                                  //           child: Text("data"),
                                  //         );
                                  //       });
                                  // },
                                  icon: Icon(Icons.call)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }

  Future<List<Data>?> getLogisticList() async {
    String logisticByProductId = widget.productId.toString();
    // Base URL
    String baseurl =
        EnvConfigs.appBaseUrl+"product//logistics_list?product_id=$logisticByProductId";

    Dio dio = Dio();

    try {
      Response response = await dio.get(baseurl);
      LogisticListByProductIdModel res =
          LogisticListByProductIdModel.fromJson(response.data);
      print(response);
      return res.data;
    } on DioError catch (e) {
      print(e);
    }
  }
}

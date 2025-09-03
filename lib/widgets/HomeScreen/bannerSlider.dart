import 'dart:developer';

import 'package:annadata/Model/bannerModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as car;
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../env.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({Key? key}) : super(key: key);

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final bannerController = PageController();

  List<Data> imagesSlider = [];

  final controller = car.CarouselSliderController();

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Data>?>(
        future: getBannerList(),
        builder: (context, snapShot) {
          if (!snapShot.hasData) {
            return Shimmer.fromColors(
                child: Container(height: 180),
                baseColor: Colors.white,
                highlightColor: Colors.grey.shade300);
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                car. CarouselSlider.builder(
                  carouselController: controller,
                  itemCount: snapShot.data!.length,
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              snapShot.data![index].bannerImg.toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
                      // child: CachedNetworkImage(
                      //   fit: BoxFit.fill,
                      //   imageUrl: snapShot.data![index].bannerImg.toString(),
                      //   progressIndicatorBuilder:
                      //       (context, url, downloadProgress) => Center(
                      //     child: CircularProgressIndicator(
                      //         value: downloadProgress.progress),
                      //   ),
                      // ),
                    );
                  },
                  // items: [
                  //   Container(
                  //     width: MediaQuery.of(context).size.width,
                  //     margin: const EdgeInsets.all(4.0),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //       image: DecorationImage(
                  //         image: NetworkImage(
                  //             snapShot.data![0].bannerImg.toString()),
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //   ),
                  // ],
                  options: car.CarouselOptions(
                    autoPlay: true,
                    pauseAutoPlayOnTouch: true,
                    autoPlayInterval: Duration(seconds: 3),
                    onPageChanged: (index, reason) {
                      log(current.toString());

                      setState(() {
                        current = index;
                      });
                      log(current.toString());
                    },
                    disableCenter: true,
                    aspectRatio: 2.0,
                    viewportFraction: 1.0,
                    // height: MediaQuery.of(context).size.height / 2,
                    // height: 200.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AnimatedSmoothIndicator(
                  // onDotClicked: (index) => current,
                  activeIndex: current,
                  count: snapShot.data!.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.green,
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                )
              ],
            ),
          );
        });
  }

  Future<List<Data>?> getBannerList() async {
    // Base URL
    const baseurl = EnvConfigs.appBaseUrl+"banner/list";

    Dio dio = Dio();

    try {
      Response response = await dio.get(baseurl);
      BannerModel res = BannerModel.fromJson(response.data);
      return res.data;
    } on DioError catch (e) {
      print(e);
    }
  }
}

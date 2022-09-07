import 'package:annadata/widgets/categoryCard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:annadata/Model/categoryCopy.dart';

class CategorySliderHorizontal extends StatefulWidget {
  const CategorySliderHorizontal({Key? key}) : super(key: key);

  @override
  State<CategorySliderHorizontal> createState() =>
      _CategorySliderHorizontalState();
}

class _CategorySliderHorizontalState extends State<CategorySliderHorizontal> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // InkWell(
          //   onTap: () {
          //     Navigator.pushNamed(context, 'allCategories');
          //   },
          //   child: Container(
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(shape: BoxShape.circle),
          //     child: SizedBox(
          //       height: 80,
          //       width: 70,
          //       child: Card(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text(
          //               'All Category',
          //               textAlign: TextAlign.center,
          //               style: TextStyle(color: Colors.black),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          InkWell(
            enableFeedback: true,
            autofocus: true,
            onTap: () {
              Navigator.pushNamed(context, 'allCategories');
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
                  Text("Categories"),
                  const SizedBox(
                    height: 5,
                  ),
                  CircleAvatar(
                    child: Text(
                      "View\nAll",
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: Colors.white,
                    radius: 30,
                  ),
                ]),
              ),
            ),
          ),
          CategoryCard(),
        ],
      ),
    );
  }
}

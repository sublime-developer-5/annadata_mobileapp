import 'dart:developer';
import 'dart:io';
import 'package:annadata/Model/product_added_by_farmer_list_model.dart';
import 'package:annadata/Model/unitList_model.dart';
import 'package:annadata/Model/user_edit_info_model.dart';
import 'package:annadata/screens/homepage.dart';
import 'package:annadata/screens/productAdd_secondPage.dart';
import 'package:annadata/widgets/HomeScreen/drawerHomePage.dart';
import 'package:annadata/widgets/HomeScreen/homeBottumNavBar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../Model/categoryCopy.dart';
import '../Model/registerRes.dart';
import '../Model/subCatModel.dart';

class AddProductByFarmer extends StatefulWidget {
  const AddProductByFarmer({Key? key}) : super(key: key);

  @override
  State<AddProductByFarmer> createState() => _AddProductByFarmerState();
}

class _AddProductByFarmerState extends State<AddProductByFarmer> {
  File? pickedFile;
  File? croppedImage;
  List<CategoryListData>? categoryList = [];
  List<SubCatData>? subCatList = [];
  List<UnitListData>? unitList = [];

  String? user_token;
  String? user_id;
  String? state_id_val;
  String? district_id_val;
  String? city_id_val;
  String? pincode_val;
  String? catId_val;
  String? commodityId_val;
  String? unitID_val;

  TextEditingController productTitleController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLisProductAddedByFarmer();
    getUserInfo();
    getCategoryList();
    getUnitList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: addProductButton(),
      appBar: AppBar(
        // leadingWidth: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    child: BottumNavBar(pageIndex: 0),
                    type: PageTransitionType.leftToRight));
          },
        ),
        title: Text("My Ads"),
      ),
      body: FutureBuilder<List<Data>?>(
          future: getLisProductAddedByFarmer(),
          builder: (context, snapShot) {
            if (!snapShot.hasData) {
              return Shimmer.fromColors(
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (_, __) {
                        return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 5,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: 18,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        height: 15,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        height: 40,
                                        color: Colors.white,
                                      ),
                                    ],
                                  )
                                ]),
                              ),
                            ));
                      }),
                  baseColor: Colors.white,
                  highlightColor: Colors.grey.shade300);
              // return Center(
              //   child: CircularProgressIndicator(),
              // );
            } else if (snapShot.data!.length == 0) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.asset(
                        "assets/no_products_found.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "No Ads Found",
                      style:
                          TextStyle(fontFamily: 'Rubik Regular', fontSize: 18),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapShot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: InkWell(
                        onTap: () {},
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.network(
                                            snapShot.data![index].productImg
                                                .toString(),
                                            errorBuilder:
                                                (context, error, stacktrace) =>
                                                    Image.asset(
                                              "assets/Logo-modified.png",
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Positioned(
                                              left: 0,
                                              top: 5,
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(2),
                                                //color: Colors.orange,
                                                //height: 20,
                                                // width: 35,
                                                decoration: const BoxDecoration(
                                                    color: Colors.orange,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topRight: const Radius
                                                                .circular(5),
                                                            bottomRight:
                                                                const Radius
                                                                        .circular(
                                                                    5))),
                                                child: Text(
                                                  snapShot.data![index].mdfDt
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ),
                                              ))
                                        ],
                                      )),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(
                                    //     width:
                                    //         MediaQuery.of(context).size.width / 2,
                                    //     child: const Text(
                                    //       "Post on: 14/06/2022",
                                    //       style: TextStyle(fontSize: 10),
                                    //       textAlign: TextAlign.end,
                                    //     )),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      // width: 250,
                                      child: Text(
                                        snapShot.data![index].productTitle
                                            .toString(),
                                        // maxLines: 3,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          "Quantity : ",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        Text(
                                            snapShot
                                                .data![index].productQuantity
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                        Text(
                                            snapShot.data![index].unitName
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11))
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }

  bottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Choose Profile Photo'),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        getImagefromGal();
                      },
                      icon: Icon(Icons.photo)),
                  Text('Gallery'),
                ],
              ),
              const SizedBox(width: 50),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        getImagefromCam();
                      },
                      icon: Icon(Icons.camera_alt)),
                  Text('Camera'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  //image from gallery

  Future<File> getImagefromGal() async {
    final ImagePicker _picker = ImagePicker();
// Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//TO convert Xfile into file
    File file = File(image!.path);
    log("Image picked from camera");
    log(file.uri.toString());
    setState(() {
      pickedFile = file;
    });
    log("widget.imageFile");
    log(pickedFile.toString());

    _cropImage();

    Navigator.pop(context);

    return file;
  }

  // Image From Camera

  Future<File> getImagefromCam() async {
    final ImagePicker _picker = ImagePicker();
// Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//TO convert Xfile into file
    File file = File(image!.path);
    log("Image picked from camera");
    log(file.uri.toString());
    setState(() {
      pickedFile = file;
    });
    log("widget.imageFile");
    log(pickedFile.toString());

    _cropImage();

    Navigator.pop(context);

    return file;
  }

  // Crop Image
  Future _cropImage() async {
    CroppedFile? file = await ImageCropper()
        .cropImage(sourcePath: pickedFile!.path, aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9,
    ], uiSettings: [
      AndroidUiSettings(lockAspectRatio: false)
    ]);

    if (file != null) {
      setState(() {
        croppedImage = File(file.path);
      });
      debugPrint("*****croppedImage.toString()*****");
      debugPrint(croppedImage.toString());
    }
  }

  Future<List<CategoryListData>?> getCategoryList() async {
    // Base URL
    var baseurl = "http://161.97.138.56:3021/mobile/category/list";

    Dio dio = Dio();

    try {
      Response response = await dio.get(baseurl);
      CategoryList res = CategoryList.fromJson(response.data);

      debugPrint("*****res.data.toString()*****");
      debugPrint(res.data.toString());

      setState(() {
        categoryList = res.data!;
      });

      return res.data;
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<List<SubCatData>?> getSubCategoryList() async {
    // Base URL
    var baseurl =
        "http://161.97.138.56:3021/mobile/sub_category/list?category_id=$catId_val";

    Dio dio = Dio();

    try {
      Response response = await dio.get(baseurl);
      SubCategoryList res = SubCategoryList.fromJson(response.data);

      setState(() {
        subCatList = res.data;
      });

      debugPrint(res.data.toString());

      return res.data;
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<List<UnitListData>?> getUnitList() async {
    // Base URL
    var baseurl = "http://161.97.138.56:3021/mobile/unit/list";

    Dio dio = Dio();

    try {
      Response response = await dio.get(baseurl);
      UnitListModel res = UnitListModel.fromJson(response.data);

      setState(() {
        unitList = res.data;
      });

      debugPrint(res.data.toString());

      return res.data;
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<UserEditInfo?> getUserInfo() async {
    // Base URL
    var baseurl = "http://161.97.138.56:3021/mobile/user/edit";

    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('_id');
    var userToken = prefs.getString('auth_token');

    var formData = FormData.fromMap({
      'user_id': userId,
    });
    print("*****userId*****");
    print(userId);

    try {
      Response response = await dio.post(
        baseurl,
        options: Options(headers: {'x-access-token': userToken}),
        data: formData,
      );

      // Data res = Data.fromJson(response.data);
      UserEditInfo res = UserEditInfo.fromJson(response.data);

      // var res = jsonDecode(response.data);

      print("Edit Responce");
      print(res.message);

      var item = res.data![0];

      setState(() {
        state_id_val = item.stateId.toString();
        district_id_val = item.districtId.toString();
        city_id_val = item.cityId.toString();
        pincode_val = item.pincode.toString();
        user_token = userToken.toString();
        user_id = userId.toString();
      });

      debugPrint("userData****---");
      debugPrint(user_id);
      debugPrint(user_token);
      debugPrint(pincode_val);
      debugPrint(state_id_val);
      debugPrint(district_id_val);
      debugPrint(city_id_val);

      return res;
    } on DioError catch (e) {
      print(e);
    }
    return null;
  }

  // Get Product List Added by Farmer

  Future<List<Data>?> getLisProductAddedByFarmer() async {
    // Base URL
    var baseurl = "http://161.97.138.56:3021/mobile/product/listbyuser_id";

    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();

    var userToken = prefs.getString('auth_token');

    try {
      Response response = await dio.get(
        baseurl,
        options: Options(headers: {'x-access-token': userToken}),
      );

      ProductAddedByFarmerListModel res =
          ProductAddedByFarmerListModel.fromJson(response.data);

      print("**************product List added by farmer*********");
      print(res.data);

      return res.data;
    } on DioError catch (e) {
      print(e);
    }
    return null;
  }

  // Register API Add Product
  Future<void> uploadProductData() async {
    var formData = FormData.fromMap({
      'product_title': productTitleController.text,
      'product_description': productDescriptionController.text,
      'product_category_id': catId_val,
      'product_sub_category_id': commodityId_val,
      'state_id': state_id_val,
      'district_id': district_id_val,
      'city_id': catId_val,
      'pincode': pincode_val,
      'user_id': user_id,
      'product_image': await MultipartFile.fromFile(croppedImage!.path),
      'unit_id': unitID_val,
      'product_quantity': productQuantityController.text
    });

    try {
      final Map<String, String> headers = {};
      Dio dio = Dio();
      final response = await dio.post(
          "http://161.97.138.56:3021/mobile/product/add",
          options: Options(headers: {'x-access-token': user_token}),
          data: formData);
      String strTemp = response.toString();
      final res = response;

      final String? resMessage = RegisterRes.fromJson(response.data).message;
      final bool? success = RegisterRes.fromJson(response.data).success;

      // Showing message response

      final snackBar = SnackBar(
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        content: Text(
          resMessage.toString(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if (success == true) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      }

      log("Message");
      log(resMessage.toString());

      debugPrint("strTemp");
      debugPrint(strTemp);
      debugPrint("res");
      debugPrint(res.toString());
    } catch (e) {
      print('e');
      print(e);
    }
  }

  addProductButton() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 45,
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: ElevatedButton(
        child: Text("Post New Ads"),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProductAdd_SecondPage()));
          // showDialog(
          //     context: context,
          //     builder: (context) {
          //       return Dialog(
          //         child: Container(
          //           padding: EdgeInsets.only(
          //               top: 0, bottom: 20, left: 20, right: 20),
          //           child: SingleChildScrollView(
          //             child: Column(
          //               children: [
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.end,
          //                   children: [
          //                     IconButton(
          //                         onPressed: () {
          //                           Navigator.pop(context);
          //                         },
          //                         icon: Icon(Icons.cancel_rounded))
          //                   ],
          //                 ),
          //                 DropdownButtonFormField(
          //                     menuMaxHeight: 300,
          //                     isExpanded: true,
          //                     decoration: InputDecoration(
          //                         border: OutlineInputBorder(
          //                             borderRadius: BorderRadius.circular(25),
          //                             borderSide: const BorderSide(
          //                                 color: Colors.orange)),
          //                         contentPadding: const EdgeInsets.symmetric(
          //                             vertical: 1, horizontal: 20),
          //                         enabledBorder: OutlineInputBorder(
          //                             borderRadius: BorderRadius.circular(25),
          //                             borderSide: const BorderSide(
          //                                 color: Colors.orange)),
          //                         focusedBorder: OutlineInputBorder(
          //                             borderRadius: BorderRadius.circular(25),
          //                             borderSide: const BorderSide(
          //                                 color: Colors.green))),
          //                     hint: const Text('Select Category'),
          //                     onChanged: (value) {
          //                       setState(() {
          //                         catId_val = value.toString();
          //                       });
          //                       debugPrint("*****catId_val****");
          //                       debugPrint(catId_val);
          //                       getSubCategoryList();
          //                     },
          //                     validator: (value) => value == null
          //                         ? '*select city required'
          //                         : null,
          //                     items: categoryList!
          //                         .map((label) => DropdownMenuItem(
          //                               child: Text(
          //                                   label.categoryName.toString()),
          //                               value: label.categoryId,
          //                             ))
          //                         .toList()),
          //                 SizedBox(height: 10),
          //                 DropdownButtonFormField(
          //                     menuMaxHeight: 300,
          //                     isExpanded: true,
          //                     decoration: InputDecoration(
          //                         border: OutlineInputBorder(
          //                             borderRadius: BorderRadius.circular(25),
          //                             borderSide: const BorderSide(
          //                                 color: Colors.orange)),
          //                         contentPadding: const EdgeInsets.symmetric(
          //                             vertical: 1, horizontal: 20),
          //                         enabledBorder: OutlineInputBorder(
          //                             borderRadius: BorderRadius.circular(25),
          //                             borderSide: const BorderSide(
          //                                 color: Colors.orange)),
          //                         focusedBorder: OutlineInputBorder(
          //                             borderRadius: BorderRadius.circular(25),
          //                             borderSide: const BorderSide(
          //                                 color: Colors.green))),
          //                     hint: const Text('Select Commodity'),
          //                     onChanged: (value) {
          //                       setState(() {
          //                         commodityId_val = value.toString();
          //                       });

          //                       debugPrint("*****commodityId_val****");
          //                       debugPrint(commodityId_val);
          //                     },
          //                     validator: (value) => value == null
          //                         ? '*select commodity required'
          //                         : null,
          //                     items: subCatList!
          //                         .map((label) => DropdownMenuItem(
          //                               child: Text(
          //                                   label.subCategoryName.toString()),
          //                               value: label.subCategoryId,
          //                             ))
          //                         .toList()),
          //                 SizedBox(
          //                   height: 10,
          //                 ),
          //                 TextFormField(
          //                   maxLength: 200,
          //                   controller: productTitleController,
          //                   //style: TextStyle(fontSize: 18),
          //                   decoration: InputDecoration(
          //                       border: OutlineInputBorder(
          //                           borderRadius: BorderRadius.circular(25),
          //                           borderSide: const BorderSide(
          //                               color: Colors.orange)),
          //                       contentPadding: const EdgeInsets.symmetric(
          //                           vertical: 1, horizontal: 15),
          //                       hintText: 'Product Name',
          //                       // hintStyle: TextStyle(fontSize: 18),
          //                       enabledBorder: OutlineInputBorder(
          //                           borderRadius: BorderRadius.circular(25),
          //                           borderSide: const BorderSide(
          //                               color: Colors.orange)),
          //                       focusedBorder: OutlineInputBorder(
          //                           borderRadius: BorderRadius.circular(25),
          //                           borderSide: const BorderSide(
          //                               color: Colors.green))),
          //                   validator: (text) {
          //                     if (text == null || text.isEmpty) {
          //                       return '*Required';
          //                     } else {
          //                       return null;
          //                     }
          //                   },
          //                 ),
          //                 // const SizedBox(height: 10),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Flexible(
          //                       flex: 1,
          //                       fit: FlexFit.tight,
          //                       child: SizedBox(
          //                         width:
          //                             MediaQuery.of(context).size.width / 1.3,
          //                         child: TextFormField(
          //                           controller: productQuantityController,
          //                           maxLength: 10,
          //                           keyboardType: TextInputType.number,
          //                           inputFormatters: <TextInputFormatter>[
          //                             FilteringTextInputFormatter.digitsOnly
          //                           ],
          //                           //  style: TextStyle(fontSize: 20),
          //                           decoration: const InputDecoration(
          //                               counterText: "",
          //                               border: OutlineInputBorder(
          //                                   borderRadius: BorderRadius.only(
          //                                       topLeft: Radius.circular(25),
          //                                       bottomLeft:
          //                                           Radius.circular(25)),
          //                                   borderSide: BorderSide(
          //                                       color: Colors.orange)),
          //                               contentPadding: EdgeInsets.symmetric(
          //                                   vertical: 5, horizontal: 15),
          //                               hintText: 'Quantity',
          //                               // hintStyle: TextStyle(fontSize: 20),
          //                               enabledBorder: OutlineInputBorder(
          //                                   borderRadius: BorderRadius.only(
          //                                       topLeft: Radius.circular(25),
          //                                       bottomLeft:
          //                                           Radius.circular(25)),
          //                                   borderSide: BorderSide(
          //                                       color: Colors.orange)),
          //                               focusedBorder: OutlineInputBorder(
          //                                   borderRadius: BorderRadius.only(
          //                                       topLeft: Radius.circular(25),
          //                                       bottomLeft:
          //                                           Radius.circular(25)),
          //                                   borderSide: BorderSide(
          //                                       color: Colors.green))),
          //                           validator: (text) {
          //                             if (text == null || text.isEmpty) {
          //                               return '*Required';
          //                             } else if (text.length < 10) {
          //                               return 'Enter Valid Mobile Number';
          //                             } else {
          //                               return null;
          //                             }
          //                           },
          //                         ),
          //                       ),
          //                     ),
          //                     const SizedBox(
          //                       width: 10,
          //                     ),
          //                     Container(
          //                       height: 48,
          //                       width: 80,
          //                       alignment: Alignment.center,
          //                       padding: const EdgeInsets.symmetric(
          //                           horizontal: 10),
          //                       decoration: BoxDecoration(
          //                         border: Border.all(color: Colors.orange),
          //                         borderRadius: const BorderRadius.only(
          //                             topRight: Radius.circular(25),
          //                             bottomRight: Radius.circular(25)),
          //                       ),
          //                       child: DropdownButtonFormField(
          //                           hint: const Text("Unit"),
          //                           elevation: 0,
          //                           decoration: const InputDecoration(
          //                             isCollapsed: true,
          //                             enabledBorder: InputBorder.none,
          //                           ),
          //                           isExpanded: true,
          //                           items: unitList!
          //                               .map((e) => DropdownMenuItem(
          //                                     child:
          //                                         Text(e.unitName.toString()),
          //                                     value: e.unitId.toString(),
          //                                   ))
          //                               .toList(),
          //                           onChanged: (value) {
          //                             setState(() {
          //                               unitID_val = value.toString();
          //                             });

          //                             debugPrint("*****unitID_val*****");
          //                             debugPrint(unitID_val);
          //                           }),
          //                     ),
          //                   ],
          //                 ),
          //                 const SizedBox(height: 10),
          //                 TextFormField(
          //                   controller: productDescriptionController,
          //                   keyboardType: TextInputType.multiline,
          //                   maxLines: null,

          //                   // controller: ,
          //                   //style: TextStyle(fontSize: 18),
          //                   decoration: InputDecoration(
          //                       border: OutlineInputBorder(
          //                           borderRadius: BorderRadius.circular(25),
          //                           borderSide: const BorderSide(
          //                               color: Colors.orange)),
          //                       contentPadding: const EdgeInsets.symmetric(
          //                           vertical: 15, horizontal: 15),
          //                       hintText: 'Description',
          //                       // hintStyle: TextStyle(fontSize: 18),
          //                       enabledBorder: OutlineInputBorder(
          //                           borderRadius: BorderRadius.circular(25),
          //                           borderSide: const BorderSide(
          //                               color: Colors.orange)),
          //                       focusedBorder: OutlineInputBorder(
          //                           borderRadius: BorderRadius.circular(25),
          //                           borderSide: const BorderSide(
          //                               color: Colors.green))),
          //                   validator: (text) {
          //                     if (text == null || text.isEmpty) {
          //                       return '*Required';
          //                     } else {
          //                       return null;
          //                     }
          //                   },
          //                 ),
          //                 SizedBox(height: 10),
          //                 Column(
          //                   // mainAxisAlignment: MainAxisAlignment.start,
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     ElevatedButton(
          //                         onPressed: () {
          //                           showModalBottomSheet(
          //                             context: context,
          //                             builder: ((builder) => bottomSheet()),
          //                           );
          //                         },
          //                         child: Text("Upload Product Image")),
          //                     Container(
          //                       height:
          //                           MediaQuery.of(context).size.height / 5,
          //                       width:
          //                           MediaQuery.of(context).size.width / 1.5,
          //                       decoration: BoxDecoration(
          //                           border: Border.all(
          //                               color: Colors.orange, width: 2),
          //                           borderRadius: BorderRadius.all(
          //                               Radius.circular(10))),
          //                       child: croppedImage == null
          //                           ? Center(
          //                               child: Padding(
          //                               padding: const EdgeInsets.all(8.0),
          //                               child: Text(
          //                                 "No Image Seleted",
          //                                 textAlign: TextAlign.center,
          //                               ),
          //                             ))
          //                           : ClipRRect(
          //                               borderRadius: BorderRadius.all(
          //                                   Radius.circular(10)),
          //                               child: Image.file(croppedImage!,
          //                                   fit: BoxFit.fill)),
          //                     ),
          //                   ],
          //                 ),
          //                 SizedBox(
          //                   height: 20,
          //                 ),
          //                 ElevatedButton(
          //                     onPressed: () {
          //                       uploadProductData();

          //                       Navigator.pop(context);
          //                     },
          //                     child: Text("Add Product")),
          //               ],
          //             ),
          //           ),
          //         ),
          //       );
          //     });
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)))),
      ),
    );
  }
}

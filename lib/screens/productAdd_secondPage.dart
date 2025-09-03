import 'dart:developer';
import 'dart:io';

import 'package:annadata/screens/product_addByFarmer.dart';
import 'package:annadata/widgets/TextInputFormater/forFirstLetterUppercaseOfEachWord.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/categoryCopy.dart';
import '../Model/registerRes.dart';
import '../Model/subCatModel.dart';
import '../Model/unitList_model.dart';
import '../Model/user_edit_info_model.dart';
import '../env.dart';

class ProductAdd_SecondPage extends StatefulWidget {
  const ProductAdd_SecondPage({Key? key}) : super(key: key);

  @override
  State<ProductAdd_SecondPage> createState() => _ProductAdd_SecondPageState();
}

class _ProductAdd_SecondPageState extends State<ProductAdd_SecondPage> {
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

  final _formKey = GlobalKey<FormState>(); // declare a GlobalKey

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserInfo();
    getCategoryList();
    getUnitList();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 40,
          width: MediaQuery.of(context).size.width / 1.2,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                uploadProductData();
              }
            },
            child: Text("Submit"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
          ),
        ),
        appBar: AppBar(
          title: Text("Add ads"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField(
                    menuMaxHeight: 300,
                    isExpanded: true,
                    decoration: InputDecoration(
                        labelText: "Category",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.orange)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.orange)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.green))),
                    hint: const Text('Select Category'),
                    onChanged: (value) {
                      setState(() {
                        catId_val = value.toString();
                      });
                      debugPrint("*****catId_val****");
                      debugPrint(catId_val);
                      getSubCategoryList();
                      _formKey.currentState!.validate();
                    },
                    validator: (value) =>
                        value == null ? '*Select Category required' : null,
                    items: categoryList!
                        .map((label) => DropdownMenuItem(
                              child: Text(label.categoryName.toString()),
                              value: label.categoryId,
                            ))
                        .toList()),
                SizedBox(height: 10),
                DropdownButtonFormField(
                    menuMaxHeight: 300,
                    isExpanded: true,
                    decoration: InputDecoration(
                        labelText: "Commodity",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.orange)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.orange)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.green))),
                    hint: const Text('Select Commodity'),
                    onChanged: (value) {
                      setState(() {
                        commodityId_val = value.toString();
                      });

                      debugPrint("*****commodityId_val****");
                      debugPrint(commodityId_val);
                      _formKey.currentState!.validate();
                    },
                    validator: (value) =>
                        value == null ? '*Select commodity required' : null,
                    items: subCatList!
                        .map((label) => DropdownMenuItem(
                              child: Text(label.subCategoryName.toString()),
                              value: label.subCategoryId,
                            ))
                        .toList()),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) {
                    _formKey.currentState!.validate();
                  },
                  maxLength: 200,
                  controller: productTitleController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(RegExp('^[ ]{1}')),
                    UpperCaseTextFormatter()
                  ],
                  //style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.orange)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 15),
                      // hintText: 'Title',
                      // hintStyle: TextStyle(fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.orange)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.green))),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return '*Required';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: TextFormField(
                          onChanged: (value) {
                            _formKey.currentState!.validate();
                          },
                          controller: productQuantityController,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          //  style: TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                              labelText: "Quantity",
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      bottomLeft: Radius.circular(25)),
                                  borderSide: BorderSide(color: Colors.orange)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              // hintText: 'Quantity',
                              // hintStyle: TextStyle(fontSize: 20),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      bottomLeft: Radius.circular(25)),
                                  borderSide: BorderSide(color: Colors.orange)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      bottomLeft: Radius.circular(25)),
                                  borderSide: BorderSide(color: Colors.green))),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return '*Required';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 48,
                      width: 80,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                      ),
                      child: DropdownButtonFormField(
                          hint: const Text("Unit"),
                          elevation: 0,
                          decoration: const InputDecoration(
                            isCollapsed: true,
                            enabledBorder: InputBorder.none,
                          ),
                          isExpanded: true,
                          // validator: (value) =>
                          //     value == null ? '*Required' : null,
                          items: unitList!
                              .map((e) => DropdownMenuItem(
                                    child: Text(e.unitName.toString()),
                                    value: e.unitId.toString(),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              unitID_val = value.toString();
                            });
                            // _formKey.currentState!.validate();

                            debugPrint("*****unitID_val*****");
                            debugPrint(unitID_val);
                          }),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onChanged: (value) {
                    _formKey.currentState!.validate();
                  },
                  inputFormatters: <TextInputFormatter>[
                    // FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z.-]")),
                    FilteringTextInputFormatter.deny(RegExp("[@#^<>+%]")),
                    FilteringTextInputFormatter.deny(RegExp('^[ ]{1}'))
                  ],
                  minLines: 4,
                  controller: productDescriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,

                  // controller: ,
                  //style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.orange)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      // hintText: 'Description',
                      // hintStyle: TextStyle(fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.orange)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.green))),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return '*Required';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomSheet()),
                          );
                        },
                        child: Text("Upload Product Image")),
                    Container(
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width / 1.5,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: croppedImage == null
                          ? Center(
                              child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "No Image Seleted",
                                textAlign: TextAlign.center,
                              ),
                            ))
                          : ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child:
                                  Image.file(croppedImage!, fit: BoxFit.fill)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
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
        .cropImage(sourcePath: pickedFile!.path, uiSettings: [
      //AndroidUiSettings(lockAspectRatio: false)
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
    var baseurl = EnvConfigs.appBaseUrl+"category/list";

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
        EnvConfigs.appBaseUrl+ "sub_category/list?category_id=$catId_val";

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
    var baseurl = EnvConfigs.appBaseUrl+"unit/list";

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
    var baseurl = EnvConfigs.appBaseUrl+"user/edit";

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
      'product_image': croppedImage == null
          ? "null"
          : await MultipartFile.fromFile(croppedImage!.path),
      'unit_id': unitID_val,
      'product_quantity': productQuantityController.text
    });

    try {
      final Map<String, String> headers = {};
      Dio dio = Dio();
      final response = await dio.post(
          EnvConfigs.appBaseUrl+"product/add",
          options: Options(headers: {'x-access-token': user_token}),
          data: formData);
      String strTemp = response.toString();
      final res = response;

      final String? resMessage = RegisterRes.fromJson(response.data).message;
      final bool? success = RegisterRes.fromJson(response.data).success;

      // Showing message response

      if (unitID_val == null) {
        final snackBar = SnackBar(
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          content: Text("Select Quantiity Unit"),
        );
      }

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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddProductByFarmer()));
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
}

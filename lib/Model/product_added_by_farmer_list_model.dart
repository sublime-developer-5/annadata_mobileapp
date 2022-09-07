class ProductAddedByFarmerListModel {
  bool? success;
  String? message;
  List<Data>? data;

  ProductAddedByFarmerListModel({this.success, this.message, this.data});

  ProductAddedByFarmerListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? productId;
  String? productTitle;
  String? productDescription;
  int? productCategoryId;
  String? categoryName;
  int? productSubCategoryId;
  String? subCategoryName;
  int? stateId;
  String? stateName;
  int? districtId;
  String? districtName;
  int? cityId;
  String? cityName;
  int? pincode;
  int? userId;
  String? unitName;
  int? productQuantity;
  String? mdfDt;
  String? productImg;

  Data(
      {this.productId,
      this.productTitle,
      this.productDescription,
      this.productCategoryId,
      this.categoryName,
      this.productSubCategoryId,
      this.subCategoryName,
      this.stateId,
      this.stateName,
      this.districtId,
      this.districtName,
      this.cityId,
      this.cityName,
      this.pincode,
      this.userId,
      this.unitName,
      this.productQuantity,
      this.mdfDt,
      this.productImg});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productTitle = json['product_title'];
    productDescription = json['product_description'];
    productCategoryId = json['product_category_id'];
    categoryName = json['category_name'];
    productSubCategoryId = json['product_sub_category_id'];
    subCategoryName = json['sub_category_name'];
    stateId = json['state_id'];
    stateName = json['state_name'];
    districtId = json['district_id'];
    districtName = json['district_name'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    pincode = json['pincode'];
    userId = json['user_id'];
    unitName = json['unit_name'];
    productQuantity = json['product_quantity'];
    mdfDt = json['mdf_dt'];
    productImg = json['product_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_title'] = this.productTitle;
    data['product_description'] = this.productDescription;
    data['product_category_id'] = this.productCategoryId;
    data['category_name'] = this.categoryName;
    data['product_sub_category_id'] = this.productSubCategoryId;
    data['sub_category_name'] = this.subCategoryName;
    data['state_id'] = this.stateId;
    data['state_name'] = this.stateName;
    data['district_id'] = this.districtId;
    data['district_name'] = this.districtName;
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    data['pincode'] = this.pincode;
    data['user_id'] = this.userId;
    data['unit_name'] = this.unitName;
    data['product_quantity'] = this.productQuantity;
    data['mdf_dt'] = this.mdfDt;
    data['product_img'] = this.productImg;
    return data;
  }
}

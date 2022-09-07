class ProductInfoModel {
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

  ProductInfoModel(
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

  ProductInfoModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_title'] = productTitle;
    data['product_description'] = productDescription;
    data['product_category_id'] = productCategoryId;
    data['category_name'] = categoryName;
    data['product_sub_category_id'] = productSubCategoryId;
    data['sub_category_name'] = subCategoryName;
    data['state_id'] = stateId;
    data['state_name'] = stateName;
    data['district_id'] = districtId;
    data['district_name'] = districtName;
    data['city_id'] = cityId;
    data['city_name'] = cityName;
    data['pincode'] = pincode;
    data['user_id'] = userId;
    data['unit_name'] = unitName;
    data['product_quantity'] = productQuantity;
    data['mdf_dt'] = mdfDt;
    data['product_img'] = productImg;
    return data;
  }
}

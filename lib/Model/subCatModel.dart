class SubCategoryList {
  bool? success;
  String? message;
  List<SubCatData>? data;

  SubCategoryList({this.success, this.message, this.data});

  SubCategoryList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SubCatData>[];
      json['data'].forEach((v) {
        data!.add(new SubCatData.fromJson(v));
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

class SubCatData {
  int? subCategoryId;
  int? categoryId;
  String? subCategoryName;
  String? categoryName;
  String? subCategoryImg;

  SubCatData(
      {this.subCategoryId,
      this.categoryId,
      this.subCategoryName,
      this.categoryName,
      this.subCategoryImg});

  SubCatData.fromJson(Map<String, dynamic> json) {
    subCategoryId = json['sub_category_id'];
    categoryId = json['category_id'];
    subCategoryName = json['sub_category_name'];
    categoryName = json['category_name'];
    subCategoryImg = json['sub_category_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_category_id'] = this.subCategoryId;
    data['category_id'] = this.categoryId;
    data['sub_category_name'] = this.subCategoryName;
    data['category_name'] = this.categoryName;
    data['sub_category_img'] = this.subCategoryImg;
    return data;
  }
}

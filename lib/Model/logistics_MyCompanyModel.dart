class LogisticsMyCompanyGetInfoModel {
  bool? success;
  String? message;
  List<MyCompanyData>? data;

  LogisticsMyCompanyGetInfoModel({this.success, this.message, this.data});

  LogisticsMyCompanyGetInfoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MyCompanyData>[];
      json['data'].forEach((v) {
        data!.add(new MyCompanyData.fromJson(v));
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

class MyCompanyData {
  int? logisticsId;
  int? userId;
  String? logisticsName;
  String? logisticsSpoc;
  String? logisticsContact;
  String? logisticsFromPincode;
  String? logisticsToPincode;
  int? addBy;
  int? mdfBy;
  String? addDt;
  String? mdfDt;

  MyCompanyData(
      {this.logisticsId,
      this.userId,
      this.logisticsName,
      this.logisticsSpoc,
      this.logisticsContact,
      this.logisticsFromPincode,
      this.logisticsToPincode,
      this.addBy,
      this.mdfBy,
      this.addDt,
      this.mdfDt});

  MyCompanyData.fromJson(Map<String, dynamic> json) {
    logisticsId = json['logistics_id'];
    userId = json['user_id'];
    logisticsName = json['logistics_name'];
    logisticsSpoc = json['logistics_spoc'];
    logisticsContact = json['logistics_contact'];
    logisticsFromPincode = json['logistics_from_pincode'];
    logisticsToPincode = json['logistics_to_pincode'];
    addBy = json['add_by'];
    mdfBy = json['mdf_by'];
    addDt = json['add_dt'];
    mdfDt = json['mdf_dt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logistics_id'] = this.logisticsId;
    data['user_id'] = this.userId;
    data['logistics_name'] = this.logisticsName;
    data['logistics_spoc'] = this.logisticsSpoc;
    data['logistics_contact'] = this.logisticsContact;
    data['logistics_from_pincode'] = this.logisticsFromPincode;
    data['logistics_to_pincode'] = this.logisticsToPincode;
    data['add_by'] = this.addBy;
    data['mdf_by'] = this.mdfBy;
    data['add_dt'] = this.addDt;
    data['mdf_dt'] = this.mdfDt;
    return data;
  }
}

class LogisticListByProductIdModel {
  bool? success;
  String? message;
  List<Data>? data;

  LogisticListByProductIdModel({this.success, this.message, this.data});

  LogisticListByProductIdModel.fromJson(Map<String, dynamic> json) {
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
  int? logisticsId;
  String? logisticsName;
  String? logisticsSpoc;
  String? logisticsContact;
  String? logisticsFromPincode;

  Data(
      {this.logisticsId,
      this.logisticsName,
      this.logisticsSpoc,
      this.logisticsContact,
      this.logisticsFromPincode});

  Data.fromJson(Map<String, dynamic> json) {
    logisticsId = json['logistics_id'];
    logisticsName = json['logistics_name'];
    logisticsSpoc = json['logistics_spoc'];
    logisticsContact = json['logistics_contact'];
    logisticsFromPincode = json['logistics_from_pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logistics_id'] = this.logisticsId;
    data['logistics_name'] = this.logisticsName;
    data['logistics_spoc'] = this.logisticsSpoc;
    data['logistics_contact'] = this.logisticsContact;
    data['logistics_from_pincode'] = this.logisticsFromPincode;
    return data;
  }
}

class ContactFarmerDetailsModel {
  bool? success;
  String? message;
  List<Data>? data;

  ContactFarmerDetailsModel({this.success, this.message, this.data});

  ContactFarmerDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? membershipDetailId;
  String? contactNo;
  String? farmerName;
  String? emailId;
  String? stateName;
  String? districtName;
  String? cityName;

  Data(
      {this.membershipDetailId,
      this.contactNo,
      this.farmerName,
      this.emailId,
      this.stateName,
      this.districtName,
      this.cityName});

  Data.fromJson(Map<String, dynamic> json) {
    membershipDetailId = json['membership_detail_id'];
    contactNo = json['Contact_no'];
    farmerName = json['Farmer_Name'];
    emailId = json['Email_id'];
    stateName = json['state_name'];
    districtName = json['district_name'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['membership_detail_id'] = this.membershipDetailId;
    data['Contact_no'] = this.contactNo;
    data['Farmer_Name'] = this.farmerName;
    data['Email_id'] = this.emailId;
    data['state_name'] = this.stateName;
    data['district_name'] = this.districtName;
    data['city_name'] = this.cityName;
    return data;
  }
}

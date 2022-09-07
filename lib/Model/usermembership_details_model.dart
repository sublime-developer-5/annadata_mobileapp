class UserMembershipDetailsModel {
  bool? success;
  String? message;
  List<Data>? data;

  UserMembershipDetailsModel({this.success, this.message, this.data});

  UserMembershipDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? membershipPlanId;
  String? membershipPlanName;
  int? userId;
  Null? name;
  String? membershipStatus;
  String? purchaseDate;
  String? startDate;
  String? endDate;
  String? transactionId;

  Data(
      {this.membershipDetailId,
      this.membershipPlanId,
      this.membershipPlanName,
      this.userId,
      this.name,
      this.membershipStatus,
      this.purchaseDate,
      this.startDate,
      this.endDate,
      this.transactionId});

  Data.fromJson(Map<String, dynamic> json) {
    membershipDetailId = json['membership_detail_id'];
    membershipPlanId = json['membership_plan_id'];
    membershipPlanName = json['membership_plan_name'];
    userId = json['user_id'];
    name = json['name'];
    membershipStatus = json['membership_status'];
    purchaseDate = json['purchase_date'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    transactionId = json['transaction_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['membership_detail_id'] = this.membershipDetailId;
    data['membership_plan_id'] = this.membershipPlanId;
    data['membership_plan_name'] = this.membershipPlanName;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['membership_status'] = this.membershipStatus;
    data['purchase_date'] = this.purchaseDate;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['transaction_id'] = this.transactionId;
    return data;
  }
}

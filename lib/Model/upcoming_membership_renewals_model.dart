class UpcomingMembershipRenewals {
  bool? success;
  String? message;
  List<UpcomingMembershipData>? data;

  UpcomingMembershipRenewals({this.success, this.message, this.data});

  UpcomingMembershipRenewals.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UpcomingMembershipData>[];
      json['data'].forEach((v) {
        data!.add(new UpcomingMembershipData.fromJson(v));
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

class UpcomingMembershipData {
  int? membershipDetailId;
  int? membershipPlanId;
  String? membershipPlanName;
  int? userId;
  String? purchaseDate;
  String? startDate;
  String? endDate;
  String? transactionId;
  String? membershipStatus;
  String? invoice;

  UpcomingMembershipData(
      {this.membershipDetailId,
      this.membershipPlanId,
      this.membershipPlanName,
      this.userId,
      this.purchaseDate,
      this.startDate,
      this.endDate,
      this.transactionId,
      this.membershipStatus,
      this.invoice});

  UpcomingMembershipData.fromJson(Map<String, dynamic> json) {
    membershipDetailId = json['membership_detail_id'];
    membershipPlanId = json['membership_plan_id'];
    membershipPlanName = json['membership_plan_name'];
    userId = json['user_id'];
    purchaseDate = json['purchase_date'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    transactionId = json['transaction_id'];
    membershipStatus = json['membership_status'];
    invoice = json['invoice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['membership_detail_id'] = this.membershipDetailId;
    data['membership_plan_id'] = this.membershipPlanId;
    data['membership_plan_name'] = this.membershipPlanName;
    data['user_id'] = this.userId;
    data['purchase_date'] = this.purchaseDate;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['transaction_id'] = this.transactionId;
    data['membership_status'] = this.membershipStatus;
    data['invoice'] = this.invoice;
    return data;
  }
}

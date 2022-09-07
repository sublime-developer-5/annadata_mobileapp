class MembershipPlanModel {
  bool? success;
  String? message;
  List<Data>? data;

  MembershipPlanModel({this.success, this.message, this.data});

  MembershipPlanModel.fromJson(Map<String, dynamic> json) {
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
  int? membershipPlanId;
  String? membershipPlanName;
  String? membershipPlanDesc;
  int? membershipPlanCost;
  int? durationMonths;
  String? planFor;

  Data(
      {this.membershipPlanId,
      this.membershipPlanName,
      this.membershipPlanDesc,
      this.membershipPlanCost,
      this.durationMonths,
      this.planFor});

  Data.fromJson(Map<String, dynamic> json) {
    membershipPlanId = json['membership_plan_id'];
    membershipPlanName = json['membership_plan_name'];
    membershipPlanDesc = json['membership_plan_desc'];
    membershipPlanCost = json['membership_plan_cost'];
    durationMonths = json['duration_months'];
    planFor = json['plan_for'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['membership_plan_id'] = this.membershipPlanId;
    data['membership_plan_name'] = this.membershipPlanName;
    data['membership_plan_desc'] = this.membershipPlanDesc;
    data['membership_plan_cost'] = this.membershipPlanCost;
    data['duration_months'] = this.durationMonths;
    data['plan_for'] = this.planFor;
    return data;
  }
}

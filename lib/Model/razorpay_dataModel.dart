class RazorpayDataModel {
  bool? success;
  String? message;
  List<RazorPayData>? data;
  Order? order;

  RazorpayDataModel({this.success, this.message, this.data, this.order});

  RazorpayDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RazorPayData>[];
      json['data'].forEach((v) {
        data!.add(new RazorPayData.fromJson(v));
      });
    }
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    return data;
  }
}

class RazorPayData {
  int? membershipPlanCost;
  int? membershipPlanId;

  RazorPayData({this.membershipPlanCost, this.membershipPlanId});

  RazorPayData.fromJson(Map<String, dynamic> json) {
    membershipPlanCost = json['membership_plan_cost'];
    membershipPlanId = json['membership_plan_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['membership_plan_cost'] = this.membershipPlanCost;
    data['membership_plan_id'] = this.membershipPlanId;
    return data;
  }
}

class Order {
  String? id;
  String? entity;
  int? amount;
  int? amountPaid;
  int? amountDue;
  String? currency;
  String? receipt;
  String? offerId;
  String? status;
  int? attempts;
  // List? notes;
  int? createdAt;

  Order(
      {this.id,
      this.entity,
      this.amount,
      this.amountPaid,
      this.amountDue,
      this.currency,
      this.receipt,
      this.offerId,
      this.status,
      this.attempts,
      // this.notes,
      this.createdAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entity = json['entity'];
    amount = json['amount'];
    amountPaid = json['amount_paid'];
    amountDue = json['amount_due'];
    currency = json['currency'];
    receipt = json['receipt'];
    offerId = json['offer_id'];
    status = json['status'];
    attempts = json['attempts'];
    // if (json['notes'] != null) {
    //   notes = <Null>[];
    //   json['notes'].forEach((v) {
    //    // notes!.add(new Null.fromJson(v));
    //   });
    // }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entity'] = this.entity;
    data['amount'] = this.amount;
    data['amount_paid'] = this.amountPaid;
    data['amount_due'] = this.amountDue;
    data['currency'] = this.currency;
    data['receipt'] = this.receipt;
    data['offer_id'] = this.offerId;
    data['status'] = this.status;
    data['attempts'] = this.attempts;
    // if (this.notes != null) {
    //   data['notes'] = this.notes!.map((v) => v.toJson()).toList();
    // }
    data['created_at'] = this.createdAt;
    return data;
  }
}

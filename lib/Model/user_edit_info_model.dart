class UserEditInfo {
  bool? success;
  String? message;
  List<UserData>? data;

  UserEditInfo({this.success, this.message, this.data});

  UserEditInfo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserData>[];
      json['data'].forEach((v) {
        data!.add(new UserData.fromJson(v));
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

class UserData {
  int? id;
  String? name;
  String? emailId;
  String? mobileNo;
  String? gender;
  String? address;
  String? role;
  String? bankName;
  String? bankIfsc;
  String? bankAccountNumber;
  String? bankAccountHolderName;
  String? bankBranchName;
  String? bankBranchAddress;
  String? documentOne;
  String? documentOneName;
  String? documentTwo;
  String? documentTwoName;
  String? profilePhoto;
  int? stateId;
  String? stateName;
  int? districtId;
  String? districtName;
  int? cityId;
  String? cityName;
  int? membershipDetailId;
  int? membershipPlanId;
  String? startDate;
  String? endDate;
  String? membershipPlanName;
  int? pincode;

  UserData(
      {this.id,
      this.name,
      this.emailId,
      this.mobileNo,
      this.gender,
      this.address,
      this.role,
      this.bankName,
      this.bankIfsc,
      this.bankAccountNumber,
      this.bankAccountHolderName,
      this.bankBranchName,
      this.bankBranchAddress,
      this.documentOne,
      this.documentOneName,
      this.documentTwo,
      this.documentTwoName,
      this.profilePhoto,
      this.stateId,
      this.stateName,
      this.districtId,
      this.districtName,
      this.cityId,
      this.cityName,
      this.membershipDetailId,
      this.membershipPlanId,
      this.startDate,
      this.endDate,
      this.membershipPlanName,
      this.pincode});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emailId = json['email_id'];
    mobileNo = json['mobile_no'];
    gender = json['gender'];
    address = json['address'];
    role = json['role'];
    bankName = json['bank_name'];
    bankIfsc = json['bank_ifsc'];
    bankAccountNumber = json['bank_account_number'];
    bankAccountHolderName = json['account_holder_name'];
    bankBranchName = json['bank_branch_name'];
    bankBranchAddress = json['bank_branch_address'];
    documentOne = json['document_one'];
    documentOneName = json['Document_one_name'];
    documentTwo = json['document_two'];
    documentTwoName = json['Document_two_name'];
    profilePhoto = json['profile_photo'];
    stateId = json['state_id'];
    stateName = json['state_name'];
    districtId = json['district_id'];
    districtName = json['district_name'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    membershipDetailId = json['membership_detail_id'];
    membershipPlanId = json['membership_plan_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    membershipPlanName = json['membership_plan_name'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email_id'] = this.emailId;
    data['mobile_no'] = this.mobileNo;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['role'] = this.role;
    data['bank_name'] = this.bankName;
    data['bank_ifsc'] = this.bankIfsc;
    data['bank_account_number'] = this.bankAccountNumber;
    data['account_holder_name'] = this.bankAccountHolderName;
    data['bank_branch_name'] = this.bankBranchName;
    data['bank_branch_address'] = this.bankBranchAddress;
    data['document_one'] = this.documentOne;
    data['Document_one_name'] = this.documentOneName;
    data['document_two'] = this.documentTwo;
    data['Document_two_name'] = this.documentTwoName;
    data['profile_photo'] = this.profilePhoto;
    data['state_id'] = this.stateId;
    data['state_name'] = this.stateName;
    data['district_id'] = this.districtId;
    data['district_name'] = this.districtName;
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    data['membership_detail_id'] = this.membershipDetailId;
    data['membership_plan_id'] = this.membershipPlanId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['membership_plan_name'] = this.membershipPlanName;
    data['pincode'] = this.pincode;
    return data;
  }
}

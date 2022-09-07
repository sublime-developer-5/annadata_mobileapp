class LoginRes {
  bool? success;
  String? message;
  String? token;
  String? role;
  List<Data>? data;

  LoginRes({this.success, this.message, this.token, this.role, this.data});

  LoginRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    role = json['role'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['token'] = token;
    data['role'] = role;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? emailId;
  String? password;
  int? mPin;
  String? mobileNo;
  String? profilePhoto;
  String? gender;
  String? address;
  String? role;
  int? membershipDetailId;
  String? bankName;
  String? bankIfsc;
  String? bankAccountNumber;
  String? bankBranchName;
  String? bankBranchAddress;
  String? documentOne;
  String? documentTwo;
  int? status;
  int? stateId;
  int? districtId;
  int? cityId;
  int? pincode;
  int? otp;
  int? addBy;
  int? mdfBy;
  String? addDt;
  String? mdfDt;
  String? lastLoginDt;
  String? lastLogoutDt;

  Data(
      {this.id,
      this.name,
      this.emailId,
      this.password,
      this.mPin,
      this.mobileNo,
      this.profilePhoto,
      this.gender,
      this.address,
      this.role,
      this.membershipDetailId,
      this.bankName,
      this.bankIfsc,
      this.bankAccountNumber,
      this.bankBranchName,
      this.bankBranchAddress,
      this.documentOne,
      this.documentTwo,
      this.status,
      this.stateId,
      this.districtId,
      this.cityId,
      this.pincode,
      this.otp,
      this.addBy,
      this.mdfBy,
      this.addDt,
      this.mdfDt,
      this.lastLoginDt,
      this.lastLogoutDt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emailId = json['email_id'];
    password = json['password'];
    mPin = json['m_pin'];
    mobileNo = json['mobile_no'];
    profilePhoto = json['profile_photo'];
    gender = json['gender'];
    address = json['address'];
    role = json['role'];
    membershipDetailId = json['membership_detail_id'];
    bankName = json['bank_name'];
    bankIfsc = json['bank_ifsc'];
    bankAccountNumber = json['bank_account_number'];
    bankBranchName = json['bank_branch_name'];
    bankBranchAddress = json['bank_branch_address'];
    documentOne = json['document_one'];
    documentTwo = json['document_two'];
    status = json['status'];
    stateId = json['state_id'];
    districtId = json['district_id'];
    cityId = json['city_id'];
    pincode = json['pincode'];
    otp = json['otp'];
    addBy = json['add_by'];
    mdfBy = json['mdf_by'];
    addDt = json['add_dt'];
    mdfDt = json['mdf_dt'];
    lastLoginDt = json['last_login_dt'];
    lastLogoutDt = json['last_logout_dt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email_id'] = emailId;
    data['password'] = password;
    data['m_pin'] = mPin;
    data['mobile_no'] = mobileNo;
    data['profile_photo'] = profilePhoto;
    data['gender'] = gender;
    data['address'] = address;
    data['role'] = role;
    data['membership_detail_id'] = membershipDetailId;
    data['bank_name'] = bankName;
    data['bank_ifsc'] = bankIfsc;
    data['bank_account_number'] = bankAccountNumber;
    data['bank_branch_name'] = bankBranchName;
    data['bank_branch_address'] = bankBranchAddress;
    data['document_one'] = documentOne;
    data['document_two'] = documentTwo;
    data['status'] = status;
    data['state_id'] = stateId;
    data['district_id'] = districtId;
    data['city_id'] = cityId;
    data['pincode'] = pincode;
    data['otp'] = otp;
    data['add_by'] = addBy;
    data['mdf_by'] = mdfBy;
    data['add_dt'] = addDt;
    data['mdf_dt'] = mdfDt;
    data['last_login_dt'] = lastLoginDt;
    data['last_logout_dt'] = lastLogoutDt;
    return data;
  }
}

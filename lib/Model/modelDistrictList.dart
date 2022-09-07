class DistrictList {
  bool? success;
  String? message;
  List<DistrictData>? data;

  DistrictList({this.success, this.message, this.data});

  DistrictList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DistrictData>[];
      json['data'].forEach((v) {
        data!.add(new DistrictData.fromJson(v));
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

class DistrictData {
  int? stateId;
  String? stateName;
  int? districtId;
  String? districtName;
  int? cityId;
  String? cityName;

  DistrictData(
      {this.stateId,
      this.stateName,
      this.districtId,
      this.districtName,
      this.cityId,
      this.cityName});

  DistrictData.fromJson(Map<String, dynamic> json) {
    stateId = json['state_id'];
    stateName = json['state_name'];
    districtId = json['district_id'];
    districtName = json['district_name'];
    cityId = json['city_id'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_id'] = this.stateId;
    data['state_name'] = this.stateName;
    data['district_id'] = this.districtId;
    data['district_name'] = this.districtName;
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    return data;
  }
}

class UnitListModel {
  bool? success;
  String? message;
  List<UnitListData>? data;

  UnitListModel({this.success, this.message, this.data});

  UnitListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UnitListData>[];
      json['data'].forEach((v) {
        data!.add(new UnitListData.fromJson(v));
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

class UnitListData {
  int? unitId;
  String? unitName;

  UnitListData({this.unitId, this.unitName});

  UnitListData.fromJson(Map<String, dynamic> json) {
    unitId = json['unit_id'];
    unitName = json['unit_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unit_id'] = this.unitId;
    data['unit_name'] = this.unitName;
    return data;
  }
}

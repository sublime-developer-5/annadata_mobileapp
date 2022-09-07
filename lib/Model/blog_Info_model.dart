class BlogInfoModel {
  bool? success;
  String? message;
  List<Data>? data;

  BlogInfoModel({this.success, this.message, this.data});

  BlogInfoModel.fromJson(Map<String, dynamic> json) {
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
  int? blogId;
  int? userId;
  String? title;
  String? description;
  String? blogImage;
  String? addDate;

  Data(
      {this.blogId,
      this.userId,
      this.title,
      this.description,
      this.blogImage,
      this.addDate});

  Data.fromJson(Map<String, dynamic> json) {
    blogId = json['blog_id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    blogImage = json['blog_image'];
    addDate = json['Add_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blog_id'] = this.blogId;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['blog_image'] = this.blogImage;
    data['Add_date'] = this.addDate;
    return data;
  }
}

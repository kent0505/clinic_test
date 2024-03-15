import 'dart:developer';

class User {
  int? id;
  String? token;
  String? name;
  String? email;
  String? phone;
  String? yclientsToken;
  String? yclientsId;
  String? birthday;
  String? gender;
  String? path;
  String? mime;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.yclientsToken,
    this.yclientsId,
    this.birthday,
    this.gender,
    this.path,
    this.mime,
    this.token,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id']??'';
      name = json['name']??'';
      email = json['email']??'';
      phone = json['phone']??'';
      yclientsToken = json['yclientsToken']??'';
      yclientsId = json['yclientsId']??'';
      birthday = json['birthday']??'';
      gender = json['gender']??'';
      path = json['path']??'';
      mime = json['mime']??'';
      createdAt = json['createdAt']??'';
      updatedAt = json['updatedAt']??'';
    } catch (error) {
      log("error getting user info $json");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['yclientsToken'] = yclientsToken;
    data['yclientsId'] = yclientsId;
    data['birthday'] = birthday;
    data['gender'] = gender;
    data['path'] = path;
    data['mime'] = mime;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;

    return data;
  }
}

class PhotoModel {
  final String photoPath;
  final String title;
  PhotoModel({required this.photoPath, required this.title});
}

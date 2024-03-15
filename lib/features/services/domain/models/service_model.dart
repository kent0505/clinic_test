import 'dart:developer';

import 'package:sadykova_app/features/staffs/domain/models/staff_model.dart.dart';

class ServiceModel {
  int? id;
  String? name;
  String? code;
  int? sort;
  bool? isActive;
  int? price;
  int? totalPrice;

  String? duration;
  String? mainDescription;
  String? contraindicationsDescription;
  String? drugsDescription;
  String? preparationDescription;
  int? groupId;
  List<String>? images;
  int? yclientsId;
  String? createdAt;
  String? updatedAt;
  List<StaffModel>? staff;
  String? path;

  ServiceModel({
    this.id,
    this.name,
    this.code,
    this.sort,
    this.isActive,
    this.path,
    this.price,
    this.duration,
    this.mainDescription,
    this.contraindicationsDescription,
    this.drugsDescription,
    this.preparationDescription,
    this.groupId,
    this.images,
    this.yclientsId,
    this.createdAt,
    this.updatedAt,
    this.staff,
    this.totalPrice,
  });

  ServiceModel.fromJson(Map<String, dynamic> json, {bool fromStaff=false}) {
    try {
      id = json['id'];
      path = json['path'];
      name = json['name'];
      code = json['code'];
      sort = json['sort'];
      isActive = json['isActive'] ?? true;
      price = json['price'];
      totalPrice = json['totalprice'];

      duration = json['duration'];
      mainDescription = json['mainDescription'];
      contraindicationsDescription = json['contraindicationsDescription'];
      drugsDescription = json['drugsDescription'];
      preparationDescription = json['preparationDescription'];
      groupId = json['groupId'];
      if (fromStaff) {
        if (json['images'] != null) {
          images = [];
          json['images'].forEach((v) {
            images!.add(v);
          });
        }
      } else {
        if (json['images'] != null && json['images']['key'] != null) {
          images = [];
          json['images']['key'].forEach((v) {
            images!.add(v);
          });
        }
      }

      yclientsId = json['yclientsId'];
      createdAt = json['createdAt'];
      updatedAt = json['updatedAt'];
      if (json['staff'] != null) {
        staff = <StaffModel>[];
        json['staff'].forEach((v) {
          staff!.add(StaffModel.fromJson(v));
        });
      }
    } catch (error) {
      log("error  in service ${json["yclientsId"]} $error");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['sort'] = sort;
    data['isActive'] = isActive;
    data['price'] = price;
    data['duration'] = duration;
    data['mainDescription'] = mainDescription;
    data['contraindicationsDescription'] = contraindicationsDescription;
    data['drugsDescription'] = drugsDescription;
    data['preparationDescription'] = preparationDescription;
    data['groupId'] = groupId;
    data['images'] = images;
    data['yclientsId'] = yclientsId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (staff != null) {
      data['staff'] = staff!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

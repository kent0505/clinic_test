import 'dart:developer';

import 'package:sadykova_app/features/services/domain/models/service_model.dart';
import 'package:sadykova_app/features/staffs/domain/models/certificates_model.dart';
import 'package:sadykova_app/features/staffs/domain/models/review_model.dart';

class StaffModel {
  int? id;
  String? name;
  int? sort;
  String? path;
  String? mime;
  bool? isActive;
  int? yClientsID;
  String? position;
  String? specialization;
  String? education;
  String? workExperience;
  String? workDuration;
  int? staffDiretionId;
  String? createdAt;
  String? updatedAt;
  List<Certifacates>? certifacates;
  List<ReviewModel>? reviews;
  // StaffDirection? staffDirection;
  List<ServiceModel>? services;
  List<String>? images;
  String? avatar;

  StaffModel(
      {this.id,
      this.name,
      this.sort,
      this.path,
      this.mime,
      this.isActive,
      this.yClientsID,
      this.position,
      this.specialization,
      this.education,
      this.avatar,
      this.workExperience,
      this.workDuration,
      this.staffDiretionId,
      this.createdAt,
      this.updatedAt,
      this.certifacates,
      this.reviews,
      // this.staffDirection,
      this.services});

  StaffModel.fromJson(Map<String, dynamic> json, {bool isfromRecord = false}) {
    try {
      id = json['id'];
      avatar = json['avatar'];
      yClientsID = json['yClientsId'];

      name = json['name'];
      sort = json['sort'];
      path = json['path'];
      mime = json['mime'];
      if (json['images'] != null && json['images']['key'] != null) {
        images = [];
        json['images']['key'].forEach((v) {
          images!.add(v);
        });
      }
      isActive = json['isActive'] ?? true;
      if (isfromRecord) {
        position = json['position']['title'];
      } else {
        position = json['position'];
      }
      specialization = json['specialization'];
      education = json['education'];
      workExperience = json['workExperience'];
      workDuration = json['workDuration'];
      staffDiretionId = json['staffDiretionId'];
      createdAt = json['createdAt'];
      updatedAt = json['updatedAt'];
      if (json['certifacates'] != null) {
        certifacates = <Certifacates>[];
        json['certifacates'].forEach((v) {
          certifacates!.add(Certifacates.fromJson(v));
        });
      }
      if (json['reviews'] != null) {
        reviews = <ReviewModel>[];
        json['reviews'].forEach((v) {
          reviews!.add(ReviewModel.fromJson(v));
        });
      }

      // if (json['services'] != null) {
      //   services = <ServiceModel>[];
      //   json['services'].forEach((v) {
      //     services!.add(ServiceModel.fromJson(v, fromStaff: false));
      //   });
      // }
    } catch (error) {
      log("error in staff id ${json['id']}");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sort'] = sort;
    data['path'] = path;
    data['mime'] = mime;
    data['isActive'] = isActive;
    data['yClientsID'] = yClientsID;
    data['position'] = position;
    data['specialization'] = specialization;
    data['education'] = education;
    data['workExperience'] = workExperience;
    data['workDuration'] = workDuration;
    data['staffDiretionId'] = staffDiretionId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (certifacates != null) {
      data['certifacates'] = certifacates!.map((v) => v.toJson()).toList();
    }
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    // if (this.staffDirection != null) {
    //   data['staffDirection'] = this.staffDirection!.toJson();
    // }
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

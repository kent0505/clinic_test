import 'dart:developer';

import 'package:sadykova_app/features/services/domain/models/service_model.dart';

class EquipmentModel {
  int? id;
  String? name;
  int? sort;
  bool? isActive;
  String? label;
  String? description;
  String? principleDescription;
  List<String>? images;
  List<String>? principleImages;
  String? path;
  String? mime;
  String? createdAt;
  String? updatedAt;
  List<ServiceModel>? services;

  EquipmentModel(
      {this.id,
      this.name,
      this.sort,
      this.isActive,
      this.label,
      this.description,
      this.principleDescription,
      this.images,
      this.principleImages,
      this.path,
      this.mime,
      this.createdAt,
      this.updatedAt,
      this.services});

  EquipmentModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      name = json['name'];
      sort = json['sort'];
      isActive = json['isActive'];
      label = json['label'];
      description = json['description'];
      principleDescription = json['principleDescription'];
      if (json['images'] != null) {
        images = json['images'].cast<String>();
      }

      if (json['principleImages'] != null) {
        principleImages = json['principleImages'].cast<String>();
      }
      path = json['path'];
      mime = json['mime'];
      createdAt = json['createdAt'];
      updatedAt = json['updatedAt'];
      if (json['services'] != null) {
        services = <ServiceModel>[];
        json['services'].forEach((v) {
          services!.add(ServiceModel.fromJson(v));
        });
      }
    } catch (error) {
      log("error $error in ${json['id']}");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sort'] = sort;
    data['isActive'] = isActive;
    data['label'] = label;
    data['description'] = description;
    data['principleDescription'] = principleDescription;
    data['images'] = images;
    data['principleImages'] = principleImages;
    data['path'] = path;
    data['mime'] = mime;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

import 'package:sadykova_app/features/services/domain/models/service_model.dart';

class ComplexServiceModel {
  int? id;
  String? name;
  bool? isActive;
  int? sort;
  String? code;
  String? description;
  String? path;
  String? mime;
  int? finalPrice;
  String? shortTitle;
  String? duration;
  int? presentServiceId;
  int? consultationServiceId;
  String? createdAt;
  String? updatedAt;
  ServiceModel? presentService;
  List<ServiceModel>? services;
  ServiceModel? consultationService;
  int? totalCost;
  int? descount;

  ComplexServiceModel(
      {this.id,
      this.name,
      this.isActive,
      this.sort,
      this.code,
      this.description,
      this.path,
      this.mime,
      this.finalPrice,
      this.shortTitle,
      this.duration,
      this.presentServiceId,
      this.consultationServiceId,
      this.createdAt,
      this.updatedAt,
      this.presentService,
      this.services,
      this.consultationService,
      this.totalCost,
      this.descount});

  ComplexServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['isActive'];
    sort = json['sort'];
    code = json['code'];
    description = json['description'];
    path = json['path'];
    mime = json['mime'];
    finalPrice = json['finalPrice'];
    shortTitle = json['shortTitle'];
    duration = json['duration'];
    presentServiceId = json['presentServiceId'];
    consultationServiceId = json['consultationServiceId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    presentService = json['presentService'] != null
        ? ServiceModel.fromJson(json['presentService'])
        : null;
    if (json['services'] != null) {
      services = <ServiceModel>[];
      json['services'].forEach((v) {
        services!.add(ServiceModel.fromJson(v));
      });
    }
    consultationService = json['consultationService'] != null
        ? ServiceModel.fromJson(json['consultationService'])
        : null;
    totalCost = json['totalCost'];
    descount = json['descount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['isActive'] = isActive;
    data['sort'] = sort;
    data['code'] = code;
    data['description'] = description;
    data['path'] = path;
    data['mime'] = mime;
    data['finalPrice'] = finalPrice;
    data['shortTitle'] = shortTitle;
    data['duration'] = duration;
    data['presentServiceId'] = presentServiceId;
    data['consultationServiceId'] = consultationServiceId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (presentService != null) {
      data['presentService'] = presentService!.toJson();
    }
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    if (consultationService != null) {
      data['consultationService'] = consultationService!.toJson();
    }
    data['totalCost'] = totalCost;
    data['descount'] = descount;
    return data;
  }
}


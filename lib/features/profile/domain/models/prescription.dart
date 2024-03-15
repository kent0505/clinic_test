class PrescriptionModel {
  int? id;
  String? path;
  String? mime;
  int? userId;
  String? createdAt;
  String? updatedAt;

  PrescriptionModel(
      {this.id,
      this.path,
      this.mime,
      this.userId,
      this.createdAt,
      this.updatedAt});

  PrescriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    mime = json['mime'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['path'] = path;
    data['mime'] = mime;
    data['userId'] = userId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

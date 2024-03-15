class Certifacates {
  int? id;
  String? path;
  String? mime;
  String? description;
  int? staffId;
  String? createdAt;
  String? updatedAt;

  Certifacates(
      {this.id,
      this.path,
      this.mime,
      this.description,
      this.staffId,
      this.createdAt,
      this.updatedAt});

  Certifacates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    mime = json['mime'];
    description = json['description'];
    staffId = json['staffId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['path'] = path;
    data['mime'] = mime;
    data['description'] = description;
    data['staffId'] = staffId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

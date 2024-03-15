

class ReviewModel {
  int? id;
  String? name;
  String? date;
  String? path;
  String? mime;
  String? description;
  int? staffId;
  String? createdAt;
  String? updatedAt;

  ReviewModel(
      {this.id,
      this.name,
      this.date,
      this.path,
      this.mime,
      this.description,
      this.staffId,
      this.createdAt,
      this.updatedAt});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
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
    data['name'] = name;
    data['date'] = date;
    data['path'] = path;
    data['mime'] = mime;
    data['description'] = description;
    data['staffId'] = staffId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
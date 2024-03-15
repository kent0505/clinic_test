class PageModel {
  int? id;
  String? name;
  bool? isActive;
  int? sort;
  String? code;
  String? description;
  String? description2;
  String? description3;
  String? description4;
  String? description5;
  String? description6;
  String? createdAt;
  String? updatedAt;

  PageModel(
      {this.id,
      this.name,
      this.isActive,
      this.sort,
      this.code,
      this.description,
      this.description2,
      this.description3,
      this.description4,
      this.description5,
      this.description6,
      this.createdAt,
      this.updatedAt});

  PageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['isActive'];
    sort = json['sort'];
    code = json['code'];
    description = json['description'];
    description2 = json['description2'];
    description3 = json['description3'];
    description4 = json['description4'];
    description5 = json['description5'];
    description6 = json['description6'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['isActive'] = isActive;
    data['sort'] = sort;
    data['code'] = code;
    data['description'] = description;
    data['description2'] = description2;
    data['description3'] = description3;
    data['description4'] = description4;
    data['description5'] = description5;
    data['description6'] = description6;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
class ContactMdel {
  int? id;
  String? type;
  String? name;
  String? description;
  int? sort;
  bool? isActive;
  String? map;
  String? createdAt;
  String? updatedAt;

  ContactMdel(
      {this.id,
      this.type,
      this.name,
      this.description,
      this.sort,
      this.isActive,
      this.map,
      this.createdAt,
      this.updatedAt});

  ContactMdel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    description = json['description'];
    sort = json['sort'];
    isActive = json['isActive'];
    map = json['map'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['description'] = description;
    data['sort'] = sort;
    data['isActive'] = isActive;
    data['map'] = map;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
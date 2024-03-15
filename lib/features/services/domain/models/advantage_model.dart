class AdvantageModal {
  int? id;
  String? name;
  String? description;
  int? sort;
  bool? isActive;
  String? path;
  String? mime;
  String? createdAt;
  String? updatedAt;

  AdvantageModal({
    this.id,
    this.name,
    this.description,
    this.sort,
    this.isActive,
    this.path,
    this.mime,
    this.createdAt,
    this.updatedAt,
  });

  AdvantageModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    sort = json['sort'];
    isActive = json['isActive'];
    path = json['path'];
    mime = json['mime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['sort'] = sort;
    data['isActive'] = isActive;
    data['path'] = path;
    data['mime'] = mime;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

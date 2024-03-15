class ArticleModel {
  int? id;
  String? name;
  bool? isActive;
  int? sort;
  String? code;
  String? description;
  String? path;
  String? mime;
  int? indexSort;
  String? createdAt;
  String? updatedAt;

  ArticleModel(
      {this.id,
      this.name,
      this.isActive,
      this.sort,
      this.code,
      this.description,
      this.path,
      this.mime,
      this.indexSort,
      this.createdAt,
      this.updatedAt});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['isActive'];
    sort = json['sort'];
    code = json['code'];
    description = json['description'];
    path = json['path'];
    mime = json['mime'];
    indexSort = json['indexSort'];
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
    data['path'] = path;
    data['mime'] = mime;
    data['indexSort'] = indexSort;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
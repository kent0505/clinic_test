class NewsModel {
  int? id;
  String? name;
  bool? isActive;
  int? sort;
  String? code;
  String? description;
  String? path;
  String? mime;
  String? previewText;
  String? type;
  String? date;
  int? indexSort;
  String? createdAt;
  String? updatedAt;

  NewsModel(
      {this.id,
      this.name,
      this.isActive,
      this.sort,
      this.code,
      this.description,
      this.path,
      this.mime,
      this.previewText,
      this.type,
      this.date,
      this.indexSort,
      this.createdAt,
      this.updatedAt});

  NewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['isActive'];
    sort = json['sort'];
    code = json['code'];
    description = json['description'];
    path = json['path'];
    mime = json['mime'];
    previewText = json['previewText'];
    type = json['type'];
    date = json['date'];
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
    data['previewText'] = previewText;
    data['type'] = type;
    data['date'] = date;
    data['indexSort'] = indexSort;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
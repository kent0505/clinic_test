class GroupServiceModel {
  int? id;
  String? name;
  int? sort;
  bool? isActive;
  String? path;
  String? mime;
  int? parentId;
  int? yclientsId;

  GroupServiceModel(
      {this.id,
      this.name,
      this.sort,
      this.isActive,
      this.path,
      this.mime,
      this.parentId,
      this.yclientsId});

  GroupServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sort = json['sort'];
    isActive = json['isActive'];
    path = json['path'];
    mime = json['mime'];
    parentId = json['parentId'];
    yclientsId = json['yclientsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sort'] = sort;
    data['isActive'] = isActive;
    data['path'] = path;
    data['mime'] = mime;
    data['parentId'] = parentId;
    data['yclientsId'] = yclientsId;
    return data;
  }
}

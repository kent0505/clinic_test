class AnalisModel {
  int? id;
  String? name;
  String? path;
  String? mime;
  String? laboratory;
  String? readyDate;
  String? analysisDate;
  bool? viewed;
  int? userId;
  int? staffId;
  String? createdAt;
  String? updatedAt;

  AnalisModel(
      {this.id,
      this.name,
      this.path,
      this.mime,
      this.laboratory,
      this.readyDate,
      this.analysisDate,
      this.viewed,
      this.userId,
      this.staffId,
      this.createdAt,
      this.updatedAt});

  AnalisModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    path = json['path'];
    mime = json['mime'];
    laboratory = json['laboratory'];
    readyDate = json['readyDate'];
    analysisDate = json['analysisDate'];
    viewed = json['viewed'];
    userId = json['userId'];
    staffId = json['staffId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['path'] = path;
    data['mime'] = mime;
    data['laboratory'] = laboratory;
    data['readyDate'] = readyDate;
    data['analysisDate'] = analysisDate;
    data['viewed'] = viewed;
    data['userId'] = userId;
    data['staffId'] = staffId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

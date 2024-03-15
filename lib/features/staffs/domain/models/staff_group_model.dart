class StaffGroupModel {
  int? id;
  String? name;
  int? sort;

  StaffGroupModel({id, name, sort});

  StaffGroupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sort'] = sort;
    return data;
  }
}

class StaffDirection {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  StaffDirection(
      {this.id, this.name, this.createdAt, this.updatedAt});

  StaffDirection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}


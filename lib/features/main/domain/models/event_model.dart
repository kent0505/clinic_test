class EventModel {
  int? id;
  String? name;
  bool? isActive;
  int? sort;
  String? code;
  String? description;
  String? path;
  String? mime;
  String? shortDescription;
  String? middleDescription;
  String? bottomDescription;
  String? address;
  int? price;
  int? indexSort;
  String? createdAt;
  String? updatedAt;
  List<Schedule>? schedule;

  EventModel({
    this.id,
    this.name,
    this.isActive,
    this.sort,
    this.code,
    this.description,
    this.path,
    this.mime,
    this.shortDescription,
    this.middleDescription,
    this.bottomDescription,
    this.address,
    this.price,
    this.indexSort,
    this.createdAt,
    this.updatedAt,
    this.schedule,
  });

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['isActive'] ?? false;
    sort = json['sort'];
    code = json['code'];
    description = json['description'];
    path = json['path'];
    mime = json['mime'];
    shortDescription = json['shortDescription'];
    middleDescription = json['middleDescription'];
    bottomDescription = json['bottomDescription'];
    address = json['address'];
    price = json['price'];
    indexSort = json['indexSort'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['schedule'] != null) {
      schedule = <Schedule>[];
      json['schedule'].forEach((v) {
        schedule!.add(Schedule.fromJson(v));
      });
    }
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
    data['shortDescription'] = shortDescription;
    data['middleDescription'] = middleDescription;
    data['bottomDescription'] = bottomDescription;
    data['address'] = address;
    data['price'] = price;
    data['indexSort'] = indexSort;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (schedule != null) {
      data['schedule'] = schedule!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Schedule {
  int? id;
  String? date;
  String? description;
  int? eventId;
  String? createdAt;
  String? updatedAt;

  Schedule({
    this.id,
    this.date,
    this.description,
    this.eventId,
    this.createdAt,
    this.updatedAt,
  });

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    description = json['description'];
    eventId = json['eventId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['description'] = description;
    data['eventId'] = eventId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

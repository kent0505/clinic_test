import 'dart:developer';

import 'package:sadykova_app/features/staffs/domain/models/staff_model.dart.dart';

class RecordModel {
  int? id;
  List<Services>? services;
  Company? company;
  int? clientsCount;
  String? date;
  String? datetime;
  String? createDate;
  String? comment;
  bool? deleted;
  int? attendance;
  int? length;
  int? notifyBySms;
  int? notifyByEmail;
  bool? masterRequested;
  bool? online;
  String? apiId;
  String? lastChangeDate;
  bool? prepaid;
  bool? prepaidConfirmed;
  int? activityId;
  StaffModel? staff;
  int? paidAmount;
  bool? allowDeleteRecord;
  bool? allowChangeRecord;

  RecordModel({
    this.id,
    this.services,
    this.company,
    this.clientsCount,
    this.date,
    this.datetime,
    this.createDate,
    this.comment,
    this.deleted,
    this.attendance,
    this.length,
    this.notifyBySms,
    this.notifyByEmail,
    this.masterRequested,
    this.online,
    this.apiId,
    this.lastChangeDate,
    this.prepaid,
    this.prepaidConfirmed,
    this.activityId,
    this.staff,
    this.paidAmount,
    this.allowDeleteRecord,
    this.allowChangeRecord,
  });

  RecordModel.fromJson(Map<String, dynamic> json) {
    try {
      log("json ${json['id']}");

      log("json ${json['staff']}");

      id = json['id'];
      if (json['services'] != null) {
        services = <Services>[];
        json['services'].forEach((v) {
          services!.add(Services.fromJson(v));
        });
      }
      company =
          json['company'] != null ? Company.fromJson(json['company']) : null;
      clientsCount = json['clients_count'];
      date = json['date'];
      datetime = json['datetime'];
      createDate = json['create_date'];
      comment = json['comment'];
      deleted = json['deleted'];
      attendance = json['attendance'];
      length = json['length'];
      notifyBySms = json['notify_by_sms'];
      notifyByEmail = json['notify_by_email'];
      masterRequested = json['master_requested'];
      online = json['online'];
      apiId = json['api_id'];
      lastChangeDate = json['last_change_date'];
      prepaid = json['prepaid'];
      prepaidConfirmed = json['prepaid_confirmed'];
      activityId = json['activity_id'];

      staff = json['staff'] != null
          ? StaffModel.fromJson(json['staff'], isfromRecord: true)
          : null;
      paidAmount = json['paid_amount'];
      allowDeleteRecord = json['allow_delete_record'];
      allowChangeRecord = json['allow_change_record'];
    } catch (error) {
      log("error in parsing record ${json[id]}");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;

    if (company != null) {
      data['company'] = company!.toJson();
    }
    data['clients_count'] = clientsCount;
    data['date'] = date;
    data['datetime'] = datetime;
    data['create_date'] = createDate;
    data['comment'] = comment;
    data['deleted'] = deleted;
    data['attendance'] = attendance;
    data['length'] = length;
    data['notify_by_sms'] = notifyBySms;
    data['notify_by_email'] = notifyByEmail;
    data['master_requested'] = masterRequested;
    data['online'] = online;
    data['api_id'] = apiId;
    data['last_change_date'] = lastChangeDate;
    data['prepaid'] = prepaid;
    data['prepaid_confirmed'] = prepaidConfirmed;
    data['activity_id'] = activityId;
    if (staff != null) {
      data['staff'] = staff!.toJson();
    }
    data['paid_amount'] = paidAmount;
    data['allow_delete_record'] = allowDeleteRecord;
    data['allow_change_record'] = allowChangeRecord;
    return data;
  }
}

class PrepaidSettings {
  String? status;
  PrepaidFull? prepaidFull;
  PrepaidMin? prepaidMin;

  PrepaidSettings({this.status, this.prepaidFull, this.prepaidMin});

  PrepaidSettings.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    prepaidFull = json['prepaid_full'] != null
        ? PrepaidFull.fromJson(json['prepaid_full'])
        : null;
    prepaidMin = json['prepaid_min'] != null
        ? PrepaidMin.fromJson(json['prepaid_min'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (prepaidFull != null) {
      data['prepaid_full'] = prepaidFull!.toJson();
    }
    if (prepaidMin != null) {
      data['prepaid_min'] = prepaidMin!.toJson();
    }
    return data;
  }
}

class PrepaidFull {
  int? amount;
  String? currency;

  PrepaidFull({this.amount, this.currency});

  PrepaidFull.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['currency'] = currency;
    return data;
  }
}

class PrepaidMin {
  int? amount;
  int? percent;
  String? currency;

  PrepaidMin({this.amount, this.percent, this.currency});

  PrepaidMin.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    percent = json['percent'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['percent'] = percent;
    data['currency'] = currency;
    return data;
  }
}

class Company {
  int? id;
  String? title;
  int? countryId;
  String? country;
  int? cityId;
  String? city;
  String? phone;
  List<String>? phones;
  int? timezone;
  String? address;
  double? coordinateLat;
  double? coordinateLon;
  bool? allowDeleteRecord;
  bool? allowChangeRecord;
  String? site;
  String? currencyShortTitle;
  int? allowChangeRecordDelayStep;
  int? allowDeleteRecordDelayStep;
  String? logo;

  Company({
    this.id,
    this.title,
    this.countryId,
    this.country,
    this.cityId,
    this.city,
    this.phone,
    this.phones,
    this.timezone,
    this.address,
    this.coordinateLat,
    this.coordinateLon,
    this.allowDeleteRecord,
    this.allowChangeRecord,
    this.site,
    this.currencyShortTitle,
    this.allowChangeRecordDelayStep,
    this.allowDeleteRecordDelayStep,
    this.logo,
  });

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    countryId = json['country_id'];
    country = json['country'];
    cityId = json['city_id'];
    city = json['city'];
    phone = json['phone'];
    phones = json['phones'].cast<String>();
    timezone = json['timezone'];
    address = json['address'];
    coordinateLat = json['coordinate_lat'];
    coordinateLon = json['coordinate_lon'];
    allowDeleteRecord = json['allow_delete_record'];
    allowChangeRecord = json['allow_change_record'];
    site = json['site'];
    currencyShortTitle = json['currency_short_title'];
    allowChangeRecordDelayStep = json['allow_change_record_delay_step'];
    allowDeleteRecordDelayStep = json['allow_delete_record_delay_step'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['country_id'] = countryId;
    data['country'] = country;
    data['city_id'] = cityId;
    data['city'] = city;
    data['phone'] = phone;
    data['phones'] = phones;
    data['timezone'] = timezone;
    data['address'] = address;
    data['coordinate_lat'] = coordinateLat;
    data['coordinate_lon'] = coordinateLon;
    data['allow_delete_record'] = allowDeleteRecord;
    data['allow_change_record'] = allowChangeRecord;
    data['site'] = site;
    data['currency_short_title'] = currencyShortTitle;
    data['allow_change_record_delay_step'] = allowChangeRecordDelayStep;
    data['allow_delete_record_delay_step'] = allowDeleteRecordDelayStep;
    data['logo'] = logo;
    return data;
  }
}

class Services {
  int? id;
  String? title;
  int? cost;
  int? priceMin;
  int? priceMax;
  int? discount;
  int? amount;
  int? seanceLength;
  String? apiId;
  int? abonementRestriction;
  PrepaidSettings? prepaidSettings;

  Services({
    this.id,
    this.title,
    this.cost,
    this.priceMin,
    this.priceMax,
    this.discount,
    this.amount,
    this.seanceLength,
    this.apiId,
    this.abonementRestriction,
    this.prepaidSettings,
  });

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    cost = json['cost'];
    priceMin = json['price_min'];
    priceMax = json['price_max'];
    discount = json['discount'];
    amount = json['amount'];
    seanceLength = json['seance_length'];
    apiId = json['api_id'];
    abonementRestriction = json['abonement_restriction'];
    prepaidSettings = json['prepaid_settings'] != null
        ? PrepaidSettings.fromJson(json['prepaid_settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['cost'] = cost;
    data['price_min'] = priceMin;
    data['price_max'] = priceMax;
    data['discount'] = discount;
    data['amount'] = amount;
    data['seance_length'] = seanceLength;
    data['api_id'] = apiId;
    data['abonement_restriction'] = abonementRestriction;
    if (prepaidSettings != null) {
      data['prepaid_settings'] = prepaidSettings!.toJson();
    }
    return data;
  }
}

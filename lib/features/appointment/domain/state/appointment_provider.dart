import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sadykova_app/features/appointment/domain/models/branch_model.dart';
import 'package:sadykova_app/features/appointment/domain/models/clinic_model.dart';
import 'package:sadykova_app/features/auth/domain/state/user_provider.dart';
import 'package:sadykova_app/features/services/domain/models/service_model.dart';
import 'package:sadykova_app/features/staffs/domain/models/staff_model.dart.dart';

class AppointmemtProvider extends ChangeNotifier {
  // ignore: unused_field
  UserProvider? _userProvider;
  List<BranchModel> listOfBranches = [];
  ClinicModel? selectedClinic;
  StaffModel? selectStaffModel;
  List<ServiceModel> seletServices = [];
  PageController tabCalendarPageController = PageController();
  ServiceModel? selectedSubService;

  String monthAndYear = DateFormat("MMMM", "ru").format(DateTime.now());
  String? selectedTime;
  DateTime? thisFocusedDate;
  DateTime? currentBookingDate;

  DateTime thisSelectedDate = DateTime.now();
  DateFormat bottomCalendarDateFormat = DateFormat("yyyy-MM-dd", "ru_RU");

  double appointmentPrice() {
    double sum = 0;
    for (var service in seletServices) {
      sum = sum + service.price!;
    }
    return sum;
  }

  void setSelectedTime(String time) {
    selectedTime = time;
    notifyListeners();
  }

  void setMothAndYear(DateTime newMonthAndYear) {
    monthAndYear = DateFormat("MMMM", "ru_RU").format(newMonthAndYear);
    notifyListeners();
  }

  void selectClinic(ClinicModel clinic) {
    selectedClinic = clinic;
    notifyListeners();
  }

  void chooseDates(selectedDate, thisFocusedDate) {
    thisSelectedDate = selectedDate;
    thisFocusedDate = thisFocusedDate;

    notifyListeners();
  }

  void setCurrentBookingData(DateTime date, {bool needUPD = false}) {
    currentBookingDate = date;

    if (needUPD) {
      notifyListeners();
    }
  }

  void selectSubService(ServiceModel service) {
    selectedSubService = service;
    notifyListeners();
  }

  void addMiniService(ServiceModel service) {
    seletServices.add(service);
    notifyListeners();
  }

  void removeService(ServiceModel service) {
    seletServices.remove(service);
    notifyListeners();
  }

  void selectStaff(StaffModel model) {
    selectStaffModel = model;
    notifyListeners();
  }
}

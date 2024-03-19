import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sadykova_app/core/error/failures.dart';
import 'package:sadykova_app/data/repository/staff_repository.dart';
import 'package:sadykova_app/features/staffs/domain/models/staff_group_model.dart';
import 'package:sadykova_app/features/staffs/domain/models/staff_model.dart.dart';

class StaffProvider extends ChangeNotifier {
  Failure? error;
  void clearError({bool isNeedNotifilistenres = false}) {
    error = null;
    if (isNeedNotifilistenres) {
      notifyListeners();
    }
  }

  StaffRepository repository = StaffRepository();
  List<StaffModel> staffList = [];
  List<StaffModel> staffListById = [];
  List<StaffModel> filteredStaffList = [];
  String orderLink = '';

  void filterStaff({required String filter}) {
    filteredStaffList = [];
    if (filter.isEmpty) {
      filteredStaffList = staffList;
      notifyListeners();
      return;
    } else {
      for (var element in staffList) {
        if (element.name != null &&
                element.name!.toLowerCase().contains(filter.toLowerCase()) ||
            element.position != null &&
                element.position!
                    .toLowerCase()
                    .contains(filter.toLowerCase())) {
          filteredStaffList.add(element);
        }
      }
      notifyListeners();
    }
  }

  List<StaffGroupModel> staffGroupList = [];

  ///[_staff_modal]
  StaffModel? selectedStaffModel;

  ///[group_id]
  int groupId = 0;

  ///[loading]
  bool _loading = false;
  bool get loading => _loading;
  set loading(bool flag) {
    _loading = flag;
    notifyListeners();
  }

  bool _loading2 = false;
  bool get loading2 => _loading2;
  set loading2(bool flag) {
    _loading2 = flag;
    notifyListeners();
  }

  ///[staff_loading]
  bool _staffLoading = false;
  bool get staffLoading => _staffLoading;
  set staffLoading(bool flag) {
    _staffLoading = flag;
    notifyListeners();
  }

  Future<void> getStaffList() async {
    try {
      clearError();
      loading = true;
      var result = await repository.getListOfStaffs();
      result.fold(
        (left) {
          staffList = left;
          filteredStaffList = left;
        },
        (right) {
          error = right;
        },
      );
    } catch (error) {
      log("Erorr $error");
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> getDetailStaff({required int staffID}) async {
    bool isSucces = false;
    try {
      staffLoading = true;
      await Future.delayed(const Duration(milliseconds: 500));
      clearError();
      var result = await repository.getStaffDetailInfo(staffId: staffID);
      result.fold((left) {
        isSucces = true;
        selectedStaffModel = left;
      }, (right) {
        isSucces = false;
        error = right;
      });
    } catch (error) {
      log("Erorr Erorr $error");
    } finally {
      staffLoading = false;
      notifyListeners();
    }
    return isSucces;
  }

  Future<void> getStaffListById() async {
    try {
      clearError();
      loading2 = true;
      var result = await repository.getListOfStaffbyGroupId(groupId: groupId);
      result.fold(
        (left) {
          staffListById = left;
        },
        (right) {
          error = right;
        },
      );
    } catch (error) {
      log("Erorr $error");
    } finally {
      loading2 = false;
      notifyListeners();
    }
  }

  Future<void> getListOfStaffGroups() async {
    try {
      clearError();
      loading = true;
      var result = await repository.getListOfStaffGroups();
      result.fold((left) {
        staffGroupList = left;
      }, (right) {
        error = right;
      });
    } catch (error) {
      log("Error $error");
    } finally {
      // loading = false;
      notifyListeners();
    }
  }

  Future<void> creteOrderBySttaffAndId({
    int? staffId,
    List<int>? serviceIds,
  }) async {
    try {
      clearError();
      loading = true;
      log("staffId $staffId");
      var result = await repository.creteOrderBySttaffAndId(
        staffId: staffId,
        serviceIds: serviceIds,
      );
      result.fold((left) {
        orderLink = left;
      }, (right) {
        error = right;
      });
    } catch (error) {
      log("Erorr $error");
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}

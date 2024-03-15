import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sadykova_app/core/error/failures.dart';
import 'package:sadykova_app/data/repository/service_repository.dart';
import 'package:sadykova_app/features/services/domain/models/advantage_model.dart';
import 'package:sadykova_app/features/services/domain/models/group_service_model.dart';
import 'package:sadykova_app/features/services/domain/models/service_model.dart';
import 'package:sadykova_app/features/services/domain/models/sub_group_service_model.dart';

class ServiceProvider extends ChangeNotifier {
  ServiceProvider() {
    getAdvantages();
  }
  List<GroupServiceModel> groupServices = [];

  List<ServiceModel> serviceList = [];
  List<ServiceModel> searchServiceList = [];

  List<AdvantageModal> advantageList = [];

  List<SubGroupService> subGroupService = [];
  ServiceRepository repository = ServiceRepository();
  Failure? error;

  ///[ServiceModel]
  ServiceModel? _selectService;
  ServiceModel get selectService => _selectService!;
  set selectService(ServiceModel flag) {
    _selectService = flag;
  }

  ///[loading]
  bool _loading = false;
  bool get loading => _loading;
  set loading(bool flag) {
    _loading = flag;
    notifyListeners();
  }

  ///[loading]
  bool _serviceLoading = false;
  bool get serviceLoading => _serviceLoading;
  set serviceLoading(bool flag) {
    _serviceLoading = flag;
    notifyListeners();
  }

  ///[loading]
  final bool _searchLoading = false;
  bool get searchLoading => _searchLoading;
  set searchLoading(bool flag) {
    _serviceLoading = flag;
    notifyListeners();
  }

  ///[group_id]
  int groupId = 0;

  ///[sub_group_id]
  int subGroupId = 0;

  GroupServiceModel getSelectedGroupModel() {
    return groupServices
        .where((element) => element.id == groupId)
        .toList()
        .first;
  }

  SubGroupService getSelectSubGroupModel() {
    return subGroupService
        .where((element) => element.id == subGroupId)
        .toList()
        .first;
  }

  void clearError({bool isNeedNotifilistenres = false}) {
    error = null;
    if (isNeedNotifilistenres) {
      notifyListeners();
    }
  }

  // void filterGroupService({required String filter}) {
  //   filteredGrouList = [];
  //   if (filter.isEmpty) {
  //     filteredGrouList = groupServices;
  //   } else {
  //     for (var item in groupServices) {
  //       if (item.name != null && item.name!.contains(filter)) {
  //         filteredGrouList.add(item);
  //       }
  //     }
  //   }
  //   notifyListeners();
  // }

  Future<void> getGroupList() async {
    try {
      clearError();
      loading = true;
      var result = await repository.getListOfGroupService();
      result.fold((left) {
        groupServices = left;
        groupServices.sort((a, b) => a.yclientsId!.compareTo(b.yclientsId!));
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

  Future<void> getAdvantages() async {
    try {
      clearError();
      var result = await repository.getAdvantageList();
      result.fold(
        (left) {
          advantageList = left;
        },
        (right) {
          error = right;
        },
      );
    } catch (error) {
      log("Erorr $error");
    } finally {
      notifyListeners();
    }
  }

  Future<void> getSubGroupById() async {
    try {
      clearError();
      loading = true;
      var result = await repository.getListOfSubGroupService(groupId: groupId);
      result.fold((left) {
        subGroupService = left;
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

  Future<void> getServiceById() async {
    try {
      clearError();
      loading = true;
      var result = await repository.getListOfServiceByGroupId(
        subGroupId: subGroupId,
      );
      result.fold(
        (left) {
          serviceList = left;
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

  Future<void> searchServiceByText({required String text}) async {
    try {
      clearError();
      searchLoading = true;
      var result = await repository.searchServiceByText(search: text);
      result.fold(
        (left) {
          searchServiceList = left;
        },
        (right) {
          error = right;
        },
      );
    } catch (error) {
      log("Erorr $error");
    } finally {
      searchLoading = false;
      notifyListeners();
    }
  }

  Future<bool> getServiceDetailInfo({required int serviceId}) async {
    bool isSucces = false;

    try {
      clearError();
      serviceLoading = true;
      var result = await repository.getDetailsServiceInfo(serviceId: serviceId);
      result.fold(
        (left) {
          selectService = left;
          isSucces = true;
        },
        (right) {
          error = right;
          isSucces = false;
        },
      );
    } catch (error) {
      log("Erorr $error");
    } finally {
      serviceLoading = false;
      notifyListeners();
    }
    return isSucces;
  }
}

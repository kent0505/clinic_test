import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sadykova_app/core/error/failures.dart';
import 'package:sadykova_app/data/api/service_api_cleint.dart';
import 'package:sadykova_app/features/services/domain/models/advantage_model.dart';
import 'package:sadykova_app/features/services/domain/models/group_service_model.dart';
import 'package:sadykova_app/features/services/domain/models/service_model.dart';
import 'package:sadykova_app/features/services/domain/models/sub_group_service_model.dart';

class ServiceRepository {
  ServiceRepository({this.token = ''}) {
    _client = ServiceApiClient(
      dio: Dio(
        BaseOptions(
          contentType: "application/json",
          headers: {
            if (token.isNotEmpty) 'Authorization': 'Bearer $token',
          },
        ),
      ),
    );
  }

  late ServiceApiClient _client;
  String token;

  Future<Either<List<AdvantageModal>, Failure>> getAdvantageList() async {
    final result = _client.getAdvantageList();
    return result;
  }

  ///[Список услуг по групп ID]
  Future<Either<List<GroupServiceModel>, Failure>>
      getListOfGroupService() async {
    final result = _client.getListOfGroupService();
    return result;
  }

  Future<Either<List<SubGroupService>, Failure>> getListOfSubGroupService(
      {required int groupId}) async {
    final result = _client.getListOfSubGroupService(groupId: groupId);
    return result;
  }

  ///[Список услуг по групп ID]
  Future<Either<List<ServiceModel>, Failure>> getListOfServiceByGroupId(
      {required int subGroupId}) async {
    final result = _client.getListOfServiceByGroupId(subGroupId: subGroupId);
    return result;
  }

  ///[Детальная информаци о услуге]
  Future<Either<ServiceModel, Failure>> getDetailsServiceInfo(
      {required int serviceId}) async {
    final result = _client.getDetailsServiceInfo(serviceId: serviceId);
    return result;
  }

  Future<Either<List<ServiceModel>, Failure>> searchServiceByText(
      {required String search}) async {
    final result = _client.searchServiceByText(search: search);
    return result;
  }
}

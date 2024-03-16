import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sadykova_app/core/error/failures.dart';
import 'package:sadykova_app/core/logger/logger_impl.dart';
import 'package:sadykova_app/core/network_check/network_info.dart';
import 'package:sadykova_app/features/services/domain/models/advantage_model.dart';
import 'package:sadykova_app/features/services/domain/models/group_service_model.dart';
import 'package:sadykova_app/features/services/domain/models/service_model.dart';
import 'package:sadykova_app/features/services/domain/models/sub_group_service_model.dart';

class ServiceApiClient {
  final Dio dio;
  String? baseUrl;

  ServiceApiClient({required this.dio}) {
    baseUrl = dotenv.env['API_URL'];
  }

  ///[SERVICE_MODULE]
  ///[Список навправлений]
  Future<Either<List<GroupServiceModel>, Failure>>
      getListOfGroupService() async {
    List<GroupServiceModel> groupServiceModel = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/services/groups/list');
        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            groupServiceModel.add(GroupServiceModel.fromJson(item));
          }
        }
        return Left(
          groupServiceModel,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка групп услуг',
        ),
      );
    }
  }

  Future<Either<List<AdvantageModal>, Failure>> getAdvantageList() async {
    List<AdvantageModal> groupServiceModel = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/benefits');
        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            groupServiceModel.add(AdvantageModal.fromJson(item));
          }
        }
        return Left(
          groupServiceModel,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка групп услуг',
        ),
      );
    }
  }

  ///[Список подкатегории]
  Future<Either<List<SubGroupService>, Failure>> getListOfSubGroupService(
      {required int groupId}) async {
    List<SubGroupService> groupServiceModel = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response =
            await dio.get(baseUrl! + '/api/services/groups/list/$groupId');
        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            groupServiceModel.add(SubGroupService.fromJson(item));
          }
        }
        return Left(
          groupServiceModel,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка групп услуг',
        ),
      );
    }
  }

  ///[Список услуг по подкатегории]
  Future<Either<List<ServiceModel>, Failure>> getListOfServiceByGroupId(
      {required int subGroupId}) async {
    List<ServiceModel> groupServiceModel = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response =
            await dio.get(baseUrl! + '/api/services/list/group/$subGroupId');
        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            groupServiceModel.add(ServiceModel.fromJson(item));
          }
        }
        return Left(
          groupServiceModel,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка  услуг по ID',
        ),
      );
    }
  }

  ///[Список услуг по подкатегории]
  Future<Either<List<ServiceModel>, Failure>> searchServiceByText({
    required String search,
  }) async {
    List<ServiceModel> searchService = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/services/search/$search');
        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            searchService.add(ServiceModel.fromJson(item));
          }
        }
        return Left(
          searchService,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка  услуг по ID',
        ),
      );
    }
  }

  ///[Список услуг по групп ID]
  Future<Either<List<ServiceModel>, Failure>> getListOfSubServiceById(
      {required int serviceId}) async {
    List<ServiceModel> groupServiceModel = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response =
            await dio.get(baseUrl! + '/api/services/groups/list/$serviceId');
        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            groupServiceModel.add(ServiceModel.fromJson(item));
          }
        }
        return Left(
          groupServiceModel,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка  услуг по ID',
        ),
      );
    }
  }

  ///[Детальная информаци о услуге]
  Future<Either<ServiceModel, Failure>> getDetailsServiceInfo(
      {required int serviceId}) async {
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response =
            await dio.get(baseUrl! + '/api/services/detail/$serviceId');
        if (response.data != null) {
          return Left(
            ServiceModel.fromJson(response.data),
          );
        }
        return const Right(
          ServerFailuer(
            message: 'Ошибка загрузки списка  услуг по ID',
          ),
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка  услуг по ID',
        ),
      );
    }
  }
}

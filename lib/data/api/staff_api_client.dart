import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sadykova_app/core/error/failures.dart';
import 'package:sadykova_app/core/logger/logger_impl.dart';
import 'package:sadykova_app/core/network_check/network_info.dart';
import 'package:sadykova_app/features/staffs/domain/models/staff_group_model.dart';
import 'package:sadykova_app/features/staffs/domain/models/staff_model.dart.dart';

class StaffApiClient {
  final Dio dio;
  String? baseUrl;

  StaffApiClient({required this.dio}) {
    baseUrl = dotenv.env['API_URL2'];
  }

  ///[STAFF_MODULE]
  ///[Cписок всех сотрудников]
  Future<Either<List<StaffModel>, Failure>> getListOfStaffs() async {
    List<StaffModel> staffList = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/staff/list');
        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            staffList.add(StaffModel.fromJson(item));
          }
        }
        return Left(
          staffList,
        );
      }
    } catch (error) {
      logger.e('$error');
      return Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка докторов $error',
        ),
      );
    }
  }

  ///[Cписок всех направлений]
  Future<Either<List<StaffGroupModel>, Failure>> getListOfStaffGroups() async {
    List<StaffGroupModel> staffList = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/staff/groups/list');
        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            staffList.add(StaffGroupModel.fromJson(item));
          }
        }
        return Left(
          staffList,
        );
      }
    } catch (error) {
      logger.e('$error');
      return Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка направлений $error',
        ),
      );
    }
  }

  ///[Cписок сотрудников направления]
  Future<Either<List<StaffModel>, Failure>> getListOfStaffbyGroupId(
      {required int groupId}) async {
    List<StaffModel> staffList = [];
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
            await dio.get(baseUrl! + '/api/staff/list/group/$groupId');
        if (response.data != null && response.data.length != 0) {
          var list = response.data as List;
          for (var item in list) {
            staffList.add(StaffModel.fromJson(item));
          }
        }
        return Left(
          staffList,
        );
      }
    } catch (error) {
      logger.e('$error');
      return Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка сотрудников по id $error',
        ),
      );
    }
  }

  Future<Either<StaffModel, Failure>> getStaffDetailInfo(
      {required int staffId}) async {
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/staff/detail/$staffId');
        if (response.data != null) {
          return Left(
            StaffModel.fromJson(response.data),
          );
        }
        return const Right(
          ServerFailuer(
            message: 'Ошибка подключения к серверу',
          ),
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка подключения к серверу',
        ),
      );
    }
  }

  Future<Either<String, Failure>> creteOrderBySttaffAndId({
    int? staffId,
    List<int>? serviceIds,
  }) async {
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.post(baseUrl! + '/api/order/widget/', data: {
          if (staffId != null) "staffId": staffId,
          if (serviceIds != null) "serviceIds": serviceIds
        });
        if (response.data != null) {
          return Left(
            response.data['url'],
          );
        }
        return const Right(
          ServerFailuer(
            message: 'Ошибка подключения к серверу',
          ),
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка подключения к серверу',
        ),
      );
    }
  }
}

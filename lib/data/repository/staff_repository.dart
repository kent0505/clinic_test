import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sadykova_app/core/error/failures.dart';
import 'package:sadykova_app/data/api/staff_api_client.dart';
import 'package:sadykova_app/features/staffs/domain/models/staff_group_model.dart';
import 'package:sadykova_app/features/staffs/domain/models/staff_model.dart.dart';

class StaffRepository {
  StaffRepository({this.token = ''}) {
    _client = StaffApiClient(
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

  late StaffApiClient _client;
  String token;

  ///[Cписок всех сотрудников]
  Future<Either<List<StaffModel>, Failure>> getListOfStaffs() async {
    final result = _client.getListOfStaffs();
    return result;
  }

  ///[Cписок всех направлений]
  Future<Either<List<StaffGroupModel>, Failure>> getListOfStaffGroups() async {
    final result = _client.getListOfStaffGroups();
    return result;
  }

  ///[Cписок сотрудников направления]
  Future<Either<List<StaffModel>, Failure>> getListOfStaffbyGroupId({
    required int groupId,
  }) async {
    final result = _client.getListOfStaffbyGroupId(groupId: groupId);
    return result;
  }

  Future<Either<StaffModel, Failure>> getStaffDetailInfo({
    required int staffId,
  }) async {
    final result = _client.getStaffDetailInfo(staffId: staffId);
    return result;
  }

  Future<Either<String, Failure>> creteOrderBySttaffAndId({
    int? staffId,
    List<int>? serviceIds,
  }) async {
    final result = _client.creteOrderBySttaffAndId(
      staffId: staffId,
      serviceIds: serviceIds,
    );
    return result;
  }
}

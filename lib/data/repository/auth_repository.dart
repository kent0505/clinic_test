import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sadykova_app/core/error/failures.dart';
import 'package:sadykova_app/data/api/auth_api_client.dart';
import 'package:sadykova_app/data/local/storage_client.dart';
import 'package:sadykova_app/features/auth/domain/models/user.dart';
import 'package:sadykova_app/features/profile/domain/models/analize.dart';
import 'package:sadykova_app/features/profile/domain/models/prescription.dart';
import 'package:sadykova_app/features/profile/domain/models/record_model.dart';

class AuthRepository {
  AuthRepository({this.token = ''}) {
    _client = AuthApiclient(
      dio: Dio(
        BaseOptions(
          contentType: "application/json",
          headers: {
            if (token.isNotEmpty) 'Authorization': 'Bearer $token',
          },
        ),
      ),
    );
    _stoageAuthlient = StorageAuthClient();
  }
  String token;

  late AuthApiclient _client;
  late StorageAuthClient _stoageAuthlient;

  Future<Either<bool, Failure>> confirmPhone({required String phone}) async {
    final result = _client.confirmPhone(phone: phone);
    return result;
  }

  Future<Either<User, Failure>> login({
    required String phone,
    required String code,
  }) async {
    final result = _client.login(
      phone: phone,
      code: code,
    );
    return result;
  }

  Future<User?> getUserFromStorage() async {
    final result = await _stoageAuthlient.getUserFromStorage();
    return result;
  }

  Future<void> setUserToStorage(User userModel) async {
    await _stoageAuthlient.setUserToStorage(userModel);
  }

  Future<void> deleteUserFromStorage() async {
    await _stoageAuthlient.deleteUserFromStorage();
  }

  ///Личний кабинет
  Future<Either<User, Failure>> getUserInfo() async {
    final result = _client.getUserInfo();
    return result;
  }

  Future<Either<bool, Failure>> deleteAccountUser() async {
    final result = _client.deleteAccountUser();
    return result;
  }

  Future<Either<bool, Failure>> updateUserInfo({
    required String email,
    required String name,
    required String gender,
  }) async {
    final result = _client.updateUserInfo(
      email: email,
      gender: gender,
      name: name,
    );
    return result;
  }

  Future<Either<bool, Failure>> updateAvatar(
      {required MultipartFile file}) async {
    final result = _client.updateAvatar(file: file);
    return result;
  }

  Future<Either<List<AnalisModel>, Failure>> getAnalyzeList() async {
    final result = _client.getAnalyzeList();
    return result;
  }

  Future<Either<AnalisModel, Failure>> getAnalyzeDetail(
      {required int id}) async {
    final result = _client.getAnalyzeDetail(id: id);
    return result;
  }

  Future<Either<bool, Failure>> setAnalyzeViewed({required int id}) async {
    final result = _client.setAnalyzeViewed(id: id);
    return result;
  }

  Future<Either<bool, Failure>> updatePhotoPrescription(
      {required MultipartFile file}) async {
    final result = _client.updatePhotoPrescription(file: file);
    return result;
  }

  Future<Either<List<PrescriptionModel>, Failure>> getGalleyList() async {
    final result = _client.getGalleyList();
    return result;
  }

  Future<Either<bool, Failure>> updatePhotoGallery(
      {required MultipartFile file, required String imageSizes}) async {
    final result =
        _client.updatePhotoGallery(file: file, imageSized: imageSizes);
    return result;
  }

  Future<Either<List<RecordModel>, Failure>> getNewRecords() async {
    final result = _client.getNewRecords();
    return result;
  }

  Future<Either<List<RecordModel>, Failure>> getOldRecords() async {
    final result = _client.getOldRecords();
    return result;
  }

  Future<Either<List<PrescriptionModel>, Failure>> getPrescription() async {
    final result = _client.getPrescription();
    return result;
  }

  Future<Either<bool, Failure>> sendNaloginspection({
    required String fioSender,
    required String fioPatient,
    required String birthday,
    required int iin,
    required String reportYear,
    required String comment,
  }) async {
    final result = _client.sendNaloginspection(
      birthday: birthday,
      comment: comment,
      fioPatient: fioPatient,
      fioSender: fioSender,
      iin: iin,
      reportYear: reportYear,
    );
    return result;
  }
}

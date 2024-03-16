import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sadykova_app/core/error/failures.dart';
import 'package:sadykova_app/core/logger/logger_impl.dart';
import 'package:sadykova_app/core/network_check/network_info.dart';
import 'package:sadykova_app/features/auth/domain/models/user.dart';
import 'package:sadykova_app/features/profile/domain/models/prescription.dart';
import 'package:sadykova_app/features/profile/domain/models/record_model.dart';
import 'package:sadykova_app/features/profile/domain/models/analize.dart';

const yclientLink = "https://api.yclients.com/api/v1/book_code/102988/";

class AuthApiclient {
  final Dio dio;
  String? baseUrl;

  AuthApiclient({required this.dio}) {
    baseUrl = dotenv.env['API_URL2'];
  }

  Future<Either<bool, Failure>> confirmPhone({required String phone}) async {
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        final Dio _dio = Dio();
        _dio.options.headers = {
          'Accept': 'application/vnd.yclients.v2+json',
          'Authorization': 'Bearer 3wcdd6t34uf5779hc6zb'
        };
        var response = await _dio.post(
          yclientLink,
          data: {"phone": convertPhoneToSimple(phone)},
        );
        log("response.data  confirmPhone ${response.data}");
        if (response.statusCode == 200 || response.statusCode == 201) {
          if (response.data['code'] != null &&
              response.data['code'] == 'failed') {
            return Right(
              ServerFailuer(
                message: response.data['message'],
              ),
            );
          }
          return const Left(true);
        } else {
          return Right(
            ServerFailuer(
              message: response.data['message'],
            ),
          );
        }
      }
    } catch (error) {
      if (error is DioError) {
        log("error.response!.statusCode ${error.response!.statusCode}");
        log("error.response!.statusCode ${error.response!.data}");
      }
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка авторизации',
        ),
      );
    }
  }

  Future<Either<User, Failure>> login({
    required String phone,
    required String code,
  }) async {
    log(phone);
    log(code);
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(message: 'Нет подключения к интернету'),
        );
      } else {
        var response = await dio.post(
          baseUrl! + '/api/auth/login',
          data: {
            "phone": convertPhoneToSimple(phone),
            "code": code,
          },
        );
        print("-----------------------------------------");
        print("response.data login ${response.data}");
        print("response.data  ${response.statusCode}");
        print("response.data ${response.data['token']}");
        print("response.data login ${response.data['user']}");
        print("-----------------------------------------");

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (response.data['token'] == null) {
            return Right(
              ServerFailuer(message: response.data['message']),
            );
          }
          User newUser = User.fromJson(response.data['user']);
          newUser.token = response.data['token'];
          return Left(newUser);
        } else {
          return Right(
            ServerFailuer(message: response.data['message']),
          );
        }
      }
    } catch (error) {
      if (error is DioError) {
        log("error.response!.statusCode ${error.response!.statusCode}");
        log("error.response!.statusCode ${error.response!.data}");
      }
      return const Right(
        ServerFailuer(
          message: 'Ошибка авторизации',
        ),
      );
    }
  }

  String convertPhoneToSimple(String phone) {
    log("phone $phone");
    var newPhone = '';
    if (phone.isNotEmpty) {
      newPhone = phone
          .replaceAll(" ", "")
          .replaceAll("(", "")
          .replaceAll(")", "")
          .replaceAll("-", "")
          .replaceAll("+", '');
    }
    log("newPhone $newPhone");

    return newPhone;
  }

//личный кабинет
  Future<Either<User, Failure>> getUserInfo() async {
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/account/profile');
        return Left(
          User.fromJson(response.data),
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки информации о юзере',
        ),
      );
    }
  }

  //личный кабинет
  Future<Either<bool, Failure>> deleteAccountUser() async {
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.delete(baseUrl! + '/api/account/profile');
        log("delete accout ${response.data}");
        if (response.data != null && response.statusCode == 200 ||
            response.statusCode == 201) {
          return const Left(true);
        }
        return const Left(false);
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки информации о юзере',
        ),
      );
    }
  }

  Future<Either<bool, Failure>> updateUserInfo({
    required String email,
    required String name,
    required String gender,
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
        var response = await dio.post(baseUrl! + '/api/account/profile', data: {
          if (email.isNotEmpty) "email": email,
          if (name.isNotEmpty) "name": name,
          if (gender.isNotEmpty) 'gender': gender
        });

        log("updateUserInfo ${response.data} ");
        if (response.statusCode == 200 || response.statusCode != 201) {
          if (response.data['code'] != null &&
              response.data['code'] == 'failed') {
            return Right(
              ServerFailuer(
                message: response.data['message'],
              ),
            );
          }
          return const Left(true);
        } else {
          return Right(
            ServerFailuer(
              message: response.data['message'],
            ),
          );
        }
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка авторизации',
        ),
      );
    }
  }

  Future<Either<bool, Failure>> updateAvatar({
    required MultipartFile file,
  }) async {
    try {
      FormData formData = FormData.fromMap({"image": file});
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        dio.options.headers['Content-Type'] = "multipart/form-data";
        var response = await dio.post(
          baseUrl! + '/api/account/profile/photo',
          data: formData,
        );

        log("response avatar ${response.data}");
        if (response.statusCode == 200 || response.statusCode != 201) {
          if (response.data['code'] != null &&
              response.data['code'] == 'failed') {
            return Right(
              ServerFailuer(
                message: response.data['message'],
              ),
            );
          }
          return const Left(true);
        } else {
          return Right(
            ServerFailuer(
              message: response.data['message'],
            ),
          );
        }
      }
    } catch (error) {
      logger.e(' error error error error $error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка авторизации',
        ),
      );
    }
  }

  Future<Either<List<AnalisModel>, Failure>> getAnalyzeList() async {
    List<AnalisModel> actionsModels = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/account/analyzes');
        if (response.data != null) {
          log("response.data  ${response.data}");
          var list = response.data as List;
          for (var item in list) {
            actionsModels.add(AnalisModel.fromJson(item));
          }
        }
        return Left(
          actionsModels,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка акций',
        ),
      );
    }
  }

  Future<Either<AnalisModel, Failure>> getAnalyzeDetail(
      {required int id}) async {
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/account/analyzes/$id');
        if (response.data != null) {
          return Left(
            AnalisModel.fromJson(response.data),
          );
        }
        return const Right(
          ServerFailuer(
            message: 'Ошибка подключению к серверу',
          ),
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка подключению к серверу',
        ),
      );
    }
  }

  Future<Either<bool, Failure>> setAnalyzeViewed({required int id}) async {
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
            await dio.post(baseUrl! + '/api/account/analyzes/$id/viewed');
        if (response.data != null) {
          return const Left(
            true,
          );
        }
        return const Right(
          ServerFailuer(
            message: 'Ошибка подключению к серверу',
          ),
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка подключению к серверу',
        ),
      );
    }
  }

  Future<Either<bool, Failure>> updatePhotoPrescription(
      {required MultipartFile file}) async {
    try {
      FormData formData = FormData.fromMap({"image": file});
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        dio.options.headers['Content-Type'] = 'multipart/form-data';
        var response = await dio.post(
            baseUrl! + '/api/account/prescriptions/photo',
            data: formData);
        log("response updatePhotoPrescription ${response.data}");
        if (response.statusCode == 200 || response.statusCode != 201) {
          if (response.data['code'] != null &&
              response.data['code'] == 'failed') {
            return Right(
              ServerFailuer(
                message: response.data['message'],
              ),
            );
          }
          return const Left(true);
        } else {
          return Right(
            ServerFailuer(
              message: response.data['message'],
            ),
          );
        }
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка авторизации',
        ),
      );
    }
  }

  Future<Either<List<PrescriptionModel>, Failure>> getGalleyList() async {
    List<PrescriptionModel> galleryList = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/account/gallery');
        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            galleryList.add(PrescriptionModel.fromJson(item));
          }
        }
        return Left(
          galleryList,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка акций',
        ),
      );
    }
  }

  Future<Either<bool, Failure>> updatePhotoGallery(
      {required MultipartFile file, required String imageSized}) async {
    try {
      FormData formData = FormData.fromMap({"image": file});
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        dio.options.headers['Content-Type'] = "multipart/form-data";

        var response = await dio.post(
          '$baseUrl/api/account/gallery/photo',
          data: formData,
        );
        log("response ${response.data}");
        if (response.statusCode == 200 || response.statusCode != 201) {
          if (response.data['code'] != null &&
              response.data['code'] == 'failed') {
            return Right(
              ServerFailuer(
                message: response.data['message'],
              ),
            );
          }
          return const Left(true);
        } else {
          return Right(
            ServerFailuer(
              message: response.data['message'],
            ),
          );
        }
      }
    } catch (error) {
      if (error is DioError) {
        log("error.response!.statusCode ${error.response!.statusCode}");
        log("error.response!.statusCode ${error.response!.data}");
      }
      logger.e('eror in update photo: $error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка авторизации',
        ),
      );
    }
  }

  Future<Either<List<RecordModel>, Failure>> getNewRecords() async {
    List<RecordModel> recordList = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        log('dio ${dio.options.headers}');
        var response = await dio.get(baseUrl! + '/api/account/records/active');
        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            recordList.add(RecordModel.fromJson(item));
          }
        }
        return Left(
          recordList,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка акций',
        ),
      );
    }
  }

  Future<Either<List<RecordModel>, Failure>> getOldRecords() async {
    List<RecordModel> recordList = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/account/records/history');
        if (response.data != null) {
          // log("response.data old record ${response.data}");
          var list = response.data as List;
          for (var item in list) {
            recordList.add(RecordModel.fromJson(item));
          }
        }
        return Left(
          recordList,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка акций',
        ),
      );
    }
  }

  Future<Either<List<PrescriptionModel>, Failure>> getPrescription() async {
    List<PrescriptionModel> recordList = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/account/prescriptions');
        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            recordList.add(PrescriptionModel.fromJson(item));
          }
        }
        return Left(
          recordList,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка акций',
        ),
      );
    }
  }

  Future<Either<bool, Failure>> sendNaloginspection(
      {required String fioSender,
      required String fioPatient,
      required String birthday,
      required int iin,
      required String reportYear,
      required String comment}) async {
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
            await dio.post(baseUrl! + '/api/account/tax-certificate', data: {
          if (fioSender.isNotEmpty) "fullName": fioSender,
          if (fioPatient.isNotEmpty) "taxpayer": fioPatient,
          if (birthday.isNotEmpty) 'birthday': birthday,
          if (reportYear.isNotEmpty) 'reportYear': reportYear,
          if (comment.isNotEmpty) 'comment': reportYear,
          "tin": iin,
        });
        log("nalog ${response.data}");
        if (response.statusCode == 200 || response.statusCode != 201) {
          if (response.data['code'] != null &&
              response.data['code'] == 'failed') {
            return Right(
              ServerFailuer(
                message: response.data['message'],
              ),
            );
          }
          return const Left(true);
        } else {
          return Right(
            ServerFailuer(
              message: response.data['message'],
            ),
          );
        }
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка авторизации',
        ),
      );
    }
  }
}

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:sadykova_app/core/error/failures.dart';
import 'package:sadykova_app/data/repository/auth_repository.dart';
import 'package:sadykova_app/features/auth/domain/models/user.dart';
import 'package:sadykova_app/features/auth/domain/state/user_provider.dart';
import 'package:sadykova_app/features/profile/domain/models/analize.dart';
import 'package:sadykova_app/features/profile/domain/models/prescription.dart';
import 'package:sadykova_app/features/profile/domain/models/record_model.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(UserProvider userProvider) {
    _userProvider = userProvider;
    if (userProvider.user != null && userProvider.user!.token != null) {
      repository = AuthRepository(token: userProvider.user!.token ?? '');
    }
  }

  AuthRepository repository = AuthRepository();

  UserProvider? _userProvider;
  Failure? error;

  List<RecordModel> newRecordmodel = [];
  List<RecordModel> orldRecordModel = [];
  List<PrescriptionModel> prescriptionModel = [];
  List<PrescriptionModel> galleryList = [];
  List<AnalisModel> analisList = [];

  ///for pinputError
  bool _isErrorPincode = false;
  bool get isErrorPincode => _isErrorPincode;
  set isErrorPincode(bool flag) {
    _isErrorPincode = flag;
    notifyListeners();
  }

  ///for pinputError
  bool _loading = false;
  bool get loading => _loading;
  set loading(bool flag) {
    _loading = flag;
    notifyListeners();
  }

  Future<bool> confirmPhone() async {
    bool isSuccess = false;
    try {
      loading = true;

      log(_userProvider!.phoneController.text);
      log(convertPhoneNumber(_userProvider!.phoneController.text));

      var result = await repository.confirmPhone(
        phone: convertPhoneNumber(_userProvider!.phoneController.text),
        // phone: '998998472580',
      );
      result.fold((left) {
        isSuccess = true;
        isErrorPincode = false;
      }, (right) {
        //change here
        isSuccess = true;

        error = right;
        isErrorPincode = true;
        log("error $error");
      });
    } catch (error) {
      log("Erorr $error");
    } finally {
      loading = false;
      notifyListeners();
    }
    return isSuccess;
  }

  Future<bool> login() async {
    bool isSuccess = false;
    try {
      loading = true;
      var result = await repository.login(
        phone: convertPhoneNumber(_userProvider!.phoneController.text),
        // phone: '998998472580',
        code: _userProvider!.codeController.text,
      );

      log(convertPhoneNumber(_userProvider!.phoneController.text));
      log(_userProvider!.codeController.text);

      print("result $result");
      result.fold(
        (left) async {
          print("left $left");

          isSuccess = true;
          isErrorPincode = false;
          await _userProvider!.updateUserToStorage(left);
        },
        (right) async {
          print("Erorr $right");

          //change here
          // await _userProvider!.updateUserToStorage(User(token: '34'));

          error = right;
          isErrorPincode = true;
        },
      );
    } catch (error) {
      log("Erorr $error");
    } finally {
      loading = false;
      notifyListeners();
    }
    return isSuccess;
  }

  ///profile infos
  Future<bool> updateAvatar(File sendFile) async {
    log("sendFile ${sendFile.path}");
    bool isSucces = false;
    String fileName = sendFile.path.split('/').last;
    var multipartFile = await MultipartFile.fromFile(
      sendFile.path,
      filename: fileName,
    );
    var result = await repository.updateAvatar(file: multipartFile);
    result.fold((data) {
      isSucces = data;
    }, (error) {
      error = error;
      isSucces = false;
    });
    return isSucces;
  }

  ///profile infos
  Future<User> getUserInfo() async {
    loading = true;
    User userInfo = User();

    var result = await repository.getUserInfo();
    var result2 = await repository.getNewRecords();
    var result3 = await repository.getAnalyzeList();

    result2.fold((left) {
      newRecordmodel = left;
    }, (right) {
      error = right;
    });

    result3.fold((left) {
      analisList = left;
    }, (right) {
      error = right;
    });

    result.fold((data) async {
      userInfo = data;

      await _userProvider!.updateUserToStorage(userInfo);
    }, (error) {
      error = error;
    });

    loading = true;
    notifyListeners();
    return userInfo;
  }

  Future<bool> deleteUserAccount() async {
    loading = true;
    bool sucess = false;

    var result = await repository.deleteAccountUser();
    result.fold((data) async {
      sucess = data;
    }, (error) {
      sucess = false;
      error = error;
    });
    loading = true;
    notifyListeners();
    return sucess;
  }

  ///profile infos
  Future<bool> updateUserInfo(String name, String gender, String email) async {
    loading = true;
    bool isSucces = false;

    var result = await repository.updateUserInfo(
      email: email,
      gender: gender,
      name: name,
    );
    result.fold((data) async {
      isSucces = true;
    }, (error) {
      isSucces = true;

      error = error;
    });
    loading = true;
    notifyListeners();
    return isSucces;
  }

  ///profile infos
  Future<bool> sendNaloginspection(
    String birthday,
    String comment,
    String fioPatient,
    String fioSender,
    String reportYear,
    int iin,
  ) async {
    bool isSucces = false;

    var result = await repository.sendNaloginspection(
      birthday: birthday,
      comment: comment,
      fioPatient: fioPatient,
      fioSender: fioSender,
      iin: iin,
      reportYear: reportYear,
    );
    result.fold((data) async {
      isSucces = true;
    }, (error) {
      isSucces = true;

      error = error;
    });
    loading = false;
    notifyListeners();
    return isSucces;
  }

  Future<void> getNewRecords() async {
    try {
      loading = true;
      var result = await repository.getNewRecords();
      result.fold((left) {
        newRecordmodel = left;
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

  Future<void> getOldREcordModel() async {
    try {
      loading = true;
      var result = await repository.getOldRecords();
      result.fold((left) {
        orldRecordModel = left;
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

  Future<void> getPrescription() async {
    try {
      loading = true;
      var result = await repository.getPrescription();
      result.fold((left) {
        prescriptionModel = left;
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

  Future<void> getGalleyList() async {
    try {
      loading = true;
      var result = await repository.getGalleyList();
      result.fold((left) {
        galleryList = left;
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

  Future<void> getAnalisList() async {
    try {
      loading = true;
      var result = await repository.getAnalyzeList();
      result.fold((left) {
        analisList = left;
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

  ///profile infos
  Future<bool> updatePhotoPrescription(File sendFile) async {
    log("sendFile ${sendFile.path}");
    bool isSucces = false;
    loading = true;
    String fileName = sendFile.path.split('/').last;
    var multipartFile = await MultipartFile.fromFile(
      sendFile.path,
      filename: fileName,
    );
    var result = await repository.updatePhotoPrescription(file: multipartFile);
    result.fold((data) {
      isSucces = data;
    }, (error) {
      error = error;
      isSucces = false;
    });
    loading = false;
    return isSucces;
  }

  ///profile infos
  Future<bool> updatePhotoGallery(File sendFile) async {
    bool isSucces = false;
    loading = true;
    String fileName = sendFile.path.split('/').last;
    var multipartFile = await MultipartFile.fromFile(
      sendFile.path,
      filename: fileName,
      contentType: MediaType("image", "jpeg"),
    );
    var result = await repository.updatePhotoGallery(
      file: multipartFile,
      imageSizes: sendFile.length().toString(),
    );
    result.fold((data) {
      isSucces = data;
    }, (error) {
      error = error;
      isSucces = false;
    });
    loading = false;
    return isSucces;
  }

  String convertPhoneNumber(String phone) {
    var newPhone = phone
        .replaceAll(" ", "")
        .replaceAll("-", "")
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll("+", "");
    return newPhone;
  }
}

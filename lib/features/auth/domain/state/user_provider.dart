import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sadykova_app/core/compoents/top_snackbar/snackbar_model.dart';
import 'package:sadykova_app/data/repository/auth_repository.dart';
import 'package:sadykova_app/features/auth/domain/models/user.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    getUserFromStorage();
  }

  bool _startPinPutPage = false;
  bool get startPinPutPage => _startPinPutPage;
  set startPinPutPage(bool show) {
    _startPinPutPage = show;
    notifyListeners();
  }

  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  Future<void> getUserFromStorage() async {
    repository.getUserFromStorage().then(
      (value) {
        if (value != null) {
          user = value;
          log("user name ${value.name}");
          log("user token ${value.token}");
          log("user name ${value.phone}");
        }
        firstInit = false;
      },
    );
  }

  Future<void> deleteUserFromStorage() async {
    log("deleteUserFromStorage deleteUserFromStorage deleteUserFromStorage");
    repository.deleteUserFromStorage().then(
      (value) {
        user = null;
        notifyListeners();
      },
    );
  }

  bool _firstInit = true;
  bool get firstInit => _firstInit;
  set firstInit(bool flag) {
    _firstInit = flag;
    notifyListeners();
  }

  User? user;
  String selectedCity = "Казань";
  bool isFirstInit = true;
  AuthRepository repository = AuthRepository();

  void setSelectedCity(String city) {
    selectedCity = city;
    notifyListeners();
  }

  void changeFirsetInit() {
    isFirstInit = false;
    notifyListeners();
  }

  void skipLogin() {
    log("skipLogin skipLogin");
    user = User();
    notifyListeners();
  }

  void openLogin() {
    user = null;
    notifyListeners();
  }

  Future<void> updateUserToStorage(User? newUser) async {
    User? updateUser = User();

    if (newUser != null && newUser.token != null && newUser.token!.isNotEmpty) {
      updateUser = newUser;
    } else {
      updateUser = newUser;
      updateUser!.token = user!.token;
    }
    user = updateUser;
    await repository.setUserToStorage(user ?? User());
    log("repository repository repository $user");

    notifyListeners();
  }

  ///for showing notifications
  final List<SnackBarModal> _notificationsList = [];
  List<SnackBarModal> get notificationsList => _notificationsList;
  addNotification(SnackBarModal model) {
    _notificationsList.add(model);
    notifyListeners();
  }

  removeLastNotification() {
    _notificationsList.removeLast();
    notifyListeners();
  }
}

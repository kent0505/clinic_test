import 'dart:developer';

import 'package:sadykova_app/features/auth/domain/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageAuthClient {
  Future<void> setUserToStorage(User user) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (user.token != null && user.token!.isNotEmpty) {
        prefs.setString('token', user.token ?? '');
      }
      prefs.setInt('id', user.id ?? 0);
      prefs.setString('name', user.name ?? '');
      prefs.setString('email', user.email ?? '');
      prefs.setString('yclientsToken', user.yclientsToken ?? '');
      prefs.setString('yclientsId', user.yclientsId ?? '');
      prefs.setString("birthday", user.birthday ?? '');
      prefs.setString("gender", user.gender ?? '');
      prefs.setString("path", user.path ?? '');
      prefs.setString("mime", user.mime ?? '');
      prefs.setString("createdAt", user.createdAt ?? '');
      prefs.setString("updatedAt", user.updatedAt ?? '');
    } catch (error) {
      log("error in saving to storage $error");
    }
  }

  Future<User?> getUserFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("token") != null &&
        prefs.getString("token")!.isNotEmpty) {
      return User(
        id: prefs.getInt("id"),
        token: prefs.getString("token") ?? '',
        name: prefs.getString("name") ?? '',
        email: prefs.getString("email") ?? '',
        yclientsToken: prefs.getString("yclientsToken") ?? '',
        yclientsId: prefs.getString("yclientsId") ?? "",
        birthday: prefs.getString("birthday") ?? '',
        gender: prefs.getString("gender") ?? '',
        path: prefs.getString("path") ?? '',
        mime: prefs.getString("mime") ?? '',
        createdAt: prefs.getString("createdAt") ?? '',
        updatedAt: prefs.getString("updatedAt") ?? '',
      );
    } else {
      return null;
    }
  }

  Future<void> deleteUserFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("id");
    prefs.remove("token");
    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("phone");
    prefs.remove("yclientsId");
    prefs.remove("birthday");
    prefs.remove("gender");
    prefs.remove("path");
    prefs.remove("createdAt");
    prefs.remove("updatedAt");
  }

  Future<bool> isFirstInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstInit = prefs.getBool("first_init") ?? true;
    return isFirstInit;
  }

  Future<void> makeFirstInitViewed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("first_init", false);
  }
}

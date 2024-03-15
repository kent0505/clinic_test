import 'dart:io';

import 'package:sadykova_app/core/logger/logger_impl.dart';


class NetworkInfo {
  static Future<bool> isConnected() async {
    try {
      logger.i("CHECKING INTERNET");
      final result = await InternetAddress.lookup('example.com');
      logger.d(result);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }
}



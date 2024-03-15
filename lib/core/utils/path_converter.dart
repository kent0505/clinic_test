import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';

class ImagePathConvertor {
  static String convertTopaht({required String path}) {
    if (path.isEmpty) {
      return noImageLink;
    }
    String newPath = '';
    newPath = dotenv.env['API_URL']! + '/static/upload/' + path;
    return newPath;
  }
}

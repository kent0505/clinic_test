import 'package:intl/intl.dart';

class DateConverter {
  static String convertStringToDate(String dateString) {
    if (dateString.isEmpty) {
      return '';
    } else {
      try {
        DateTime date = DateTime(
          int.parse(
            dateString.substring(0, 4),
          ),
          int.parse(
            dateString.substring(5, 7),
          ),
          int.parse(
            dateString.substring(8, 10),
          ),
        );
        String formattedDate = DateFormat.yMMMMd('ru_RU').format(date);
        return formattedDate;
      } catch (error) {
        return error.toString();
      }
    }
  }

  static String convertStringToDateAndTime(String dateString) {
    if (dateString.isEmpty) {
      return '';
    } else {
      try {
        DateTime date = DateTime(
          int.parse(
            dateString.substring(0, 4),
          ),
          int.parse(
            dateString.substring(5, 7),
          ),
          int.parse(
            dateString.substring(8, 10),
          ),
          int.parse(
            dateString.substring(11, 13),
          ),
          int.parse(
            dateString.substring(14, 16),
          ),
        );
        String formattedDate =
            DateFormat.yMMMMd('ru_RU').format(date).replaceAll("г.", "") +
                "(" +
                DateFormat.EEEE('ru_RU').format(date) +
                ")  " +
                DateFormat.Hm('ru_RU').format(date);
        return formattedDate;
      } catch (error) {
        return error.toString();
      }
    }
  }
}

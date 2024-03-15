// ignore_for_file: constant_identifier_names

class SnackBarModal {
   final SnackBarTypes snackBarType;
  final String text;

  SnackBarModal({this.snackBarType=SnackBarTypes.ERROR,required this.text});
}

enum SnackBarTypes { SUCCES, ERROR }

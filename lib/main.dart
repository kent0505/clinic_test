import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sadykova_app/aplication.dart';

void main() async {
  // AndroidYandexMap.useAndroidViewSurface = false;
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  await dotenv.load(fileName: '.env');
  runApp(const Application());
}
// fvm 2.10.2
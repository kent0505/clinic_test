import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sadykova_app/core/compoents/appBar/custom_app_bar.dart';
import 'package:sadykova_app/core/compoents/top_snackbar/top_alert.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/features/auth/ui/screens/loader_screen.dart';

class PdfViewScreen extends StatefulWidget {
  const PdfViewScreen({
    Key? key,
    required this.pdfPath,
    required this.tittle,
  }) : super(key: key);

  final String pdfPath;
  final String tittle;

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  String localPath = '';

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    try {
      final url = widget.pdfPath;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      await file.writeAsBytes(bytes, flush: true);
      showTopAlertSucces(context, "Файл успешно сохранен", topPadding: 40);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl().then(
      (f) {
        setState(
          () {
            localPath = f.path;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (localPath.isEmpty) {
      return const LoaderScreen();
    }

    return Scaffold(
      backgroundColor: kBgColor,
      appBar: customAppBar(
        () {
          Navigator.pop(context);
        },
        title: Text(
          widget.tittle,
          style: const TextStyle(
            color: Color(0xff415164),
            fontSize: 17,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat-b',
          ),
        ),
      ),
      // body: const SizedBox(
      //   child: const PDF().cachedFromUrl(
      //     widget.pdfPath,
      //     placeholder: (double progress) => Center(child: Text('$progress %')),
      //     errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      //   ),
      // child: SfPdfViewer.network(
      //   widget.pdfPath,
      // ),
      // ),
    );
  }
}

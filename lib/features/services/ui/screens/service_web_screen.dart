import 'package:flutter/material.dart';
import 'package:sadykova_app/core/compoents/appBar/custom_app_bar.dart';
import 'package:sadykova_app/features/main/ui/widgets/webview_widget.dart';

class ServiceWebScreen extends StatelessWidget {
  const ServiceWebScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        () {
          Navigator.pop(context);
        },
      ),
      body: WebViewWidget(url: url),
    );
  }
}

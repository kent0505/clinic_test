import 'package:flutter/material.dart';
import 'package:sadykova_app/features/main/ui/widgets/webview_widget.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 29,
          bottom: 48,
        ),
        child: WebViewWidget(
          url: widget.url,
        ),
      ),
    );
  }
}

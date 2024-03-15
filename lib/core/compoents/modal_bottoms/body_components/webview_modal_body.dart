import 'package:flutter/material.dart';
import 'package:sadykova_app/features/main/ui/widgets/webview_widget.dart';

class WebViewModalBody extends StatelessWidget {
  const WebViewModalBody({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff5f5f5),
      child: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: WebViewWidget(url: url),
      ),
    );
  }
}

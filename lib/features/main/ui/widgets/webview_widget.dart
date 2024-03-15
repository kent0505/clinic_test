import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sadykova_app/core/compoents/loaders/loader.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewWidget extends StatefulWidget {
  const WebViewWidget({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goBack(context),
      child: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            WebView(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              javascriptMode: JavascriptMode.unrestricted,
              zoomEnabled: false,
              initialUrl: widget.url,
              onWebViewCreated: (WebViewController webViewController) {
                _controllerCompleter.complete(webViewController);
              },
              onPageFinished: (finish) {
                setState(
                  () {
                    isLoading = false;
                  },
                );
              },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith("sberpay://")) {
                  launchURLSber(request.url);
                  return NavigationDecision.prevent;
                } else {
                  return NavigationDecision.navigate;
                }
              },
            ),
            isLoading ? const Loader() : Container(),
          ],
        ),
      ),
    );
  }

  Future<bool> _goBack(BuildContext context) async {
    // if (await _controller!.canGoBack()) {
    //   _controller!.goBack();
    //   return Future.value(false);
    // } else {
    //   return Future.value(true);
    // }
    return Future.value(true);
  }
}

void launchURLSber(String url) async {
  Uri uri = Uri.parse(url);
  await launchUrl(uri);
}

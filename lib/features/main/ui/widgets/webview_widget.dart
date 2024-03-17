import 'dart:async';
import 'dart:io';

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
  final _controllerCompleter = Completer<WebViewController>();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        WebViewController webViewController = await _controllerCompleter.future;
        bool canNavigate = await webViewController.canGoBack();
        if (canNavigate) {
          webViewController.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          WebView(
            initialUrl: widget.url,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            javascriptMode: JavascriptMode.unrestricted,
            zoomEnabled: false,
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
    );
  }

  // Future<bool> _goBack(BuildContext context) async {
  //   if (await _controller!.canGoBack()) {
  //     _controller!.goBack();
  //     return Future.value(false);
  //   } else {
  //     return Future.value(true);
  //   }
  //   return Future.value(true);
  // }
}

void launchURLSber(String url) async {
  Uri uri = Uri.parse(url);
  await launchUrl(uri);
}

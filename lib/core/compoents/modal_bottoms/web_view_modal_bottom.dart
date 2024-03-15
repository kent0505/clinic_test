import 'package:flutter/material.dart';

import 'main_components/close_modal_widget.dart';

class WebViewModalBotom {
  static void showSimpleModalBottom({
    required BuildContext context,
    required Widget body,
    bool isNeddPaddingBottom = true,
    Color backGroundColor = const Color(0xfff5f5f5),
    bool expanded = false,
  }) {
    showModalBottomSheet(
      enableDrag: false,
      useRootNavigator: true,
      backgroundColor: backGroundColor,
      isScrollControlled: true,
      context: context,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.95,
        child: Container(
          decoration: BoxDecoration(
            color: backGroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: body,
                  )
                ],
              ),
              CloseModalWidget(
                onClose: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sadykova_app/core/theme/colors.dart';

import 'main_components/close_modal_widget.dart';

class MainModalBottom {
  static void showSimpleModalBottom({
    required BuildContext context,
    required Widget body,
    bool isNeddPaddingBottom = true,
    Color backGroundColor = kBgColor,
    bool expanded = false,
  }) {
    showCupertinoModalBottomSheet(
      expand: expanded,
      useRootNavigator: true,
      backgroundColor: backGroundColor,
      topRadius: const Radius.circular(22),
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: backGroundColor,
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        body,
                        if (isNeddPaddingBottom) const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ],
              ),
              const CloseModalWidget()
            ],
          ),
        );
      },
    );
  }
}

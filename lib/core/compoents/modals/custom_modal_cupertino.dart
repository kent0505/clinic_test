
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/features/main/ui/widgets/close_widget.dart';

void showCutomCupertinoModal(
    {required BuildContext context, required Widget child}) {
  showCupertinoModalBottomSheet(
    useRootNavigator: true,
    backgroundColor: kBgColor,
    expand: true,
    topRadius: const Radius.circular(16),
    context: context,
    builder: (context) => Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            bottom: 0,
            child: buildbottomModal(context),
          ),
          Positioned.fill(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  child,
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: closWidgets(context),
          ),
        ],
      ),
    ),
  );
}

Widget closWidgets(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 100,
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          right: 12,
          top: 12,
          child: CloseWidget(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        Container(
          width: 95,
          height: 5,
          margin: const EdgeInsets.only(bottom: 10, top: 6),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ],
    ),
  );
}

Widget buildbottomModal(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.width * 0.8,
    decoration: const BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(
          modalBg,
        ),
      ),
    ),
  );
}

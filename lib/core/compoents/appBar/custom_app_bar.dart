import 'package:flutter/material.dart';
import 'package:sadykova_app/core/theme/colors.dart';

PreferredSize customAppBar(
  Function onPressBack, {
  bool showLeading = true,
  bool showActions = true,
  List<Widget>? actions,
  Widget? title,
  double appBarHeight = 100,
  double topPadding = 40.0,
  Color iconColor = kGreyScale900Color,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(appBarHeight),
    child: Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: AppBar(
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //   // Status bar color
        //   statusBarColor: Colors.transparent,
        //   // Status bar brightness (optional)
        //   systemNavigationBarColor: Color(0xFF000000),
        //   systemNavigationBarDividerColor: Color(0xFF000000),
        //   statusBarIconBrightness: Brightness.light,
        //   // For Android (dark icons)
        //   statusBarBrightness: Brightness.light, // For iOS (dark icons)
        // ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: title ?? Container(),
        leading: IconButton(
          splashRadius: 20.0,
          onPressed: () {
            onPressBack();
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: iconColor,
          ),
        ),
        actions: actions,
      ),
    ),
  );
}

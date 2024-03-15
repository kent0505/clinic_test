import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sadykova_app/core/theme/colors.dart';

class CloseWidget extends StatelessWidget {
  const CloseWidget({Key? key, required this.onTap}) : super(key: key);
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff66788C).withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: const Padding(
          padding: EdgeInsets.all(5.0),
          child: Icon(
            Icons.close_rounded,
            color: kWhiteColor,
            size: 22,
          ),
        ),
      ),
    );
  }
}

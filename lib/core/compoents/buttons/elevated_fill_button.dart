import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sadykova_app/core/compoents/loaders/loader.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/utils/constants.dart';

class ElevatedFillButton extends StatelessWidget {
  const ElevatedFillButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.buttonColor = kPrimaryColor,
    this.textColor = Colors.white,
    required this.height,
    this.fontSize = 14,
    this.icon = '',
    this.isLoading = false,
    this.elevation = 0,
  }) : super(key: key);

  final String title;
  final Function() onTap;
  final Color buttonColor;
  final Color textColor;
  final double height;
  final double fontSize;
  final String? icon;
  final double elevation;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          minimumSize: Size.zero,
          backgroundColor: buttonColor,
          elevation: elevation,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(mainBorderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SvgPicture.asset(
                  icon!,
                  height: 24,
                  width: 24,
                  color: textColor,
                ),
              ),
            Center(
              child: !isLoading
                  ? Text(
                      title,
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat-bold',
                      ),
                    )
                  : const Loader(),
            ),
          ],
        ),
      ),
    );
  }
}

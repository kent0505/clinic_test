import 'package:flutter/material.dart';
import 'package:sadykova_app/core/theme/colors.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    this.title,
    this.width,
    this.height = 50,
    this.fontSize = 18,
    this.child,
    this.margin,
    required this.onPressed,
    this.textColor = Colors.white,
    this.buttonColor = Colors.black,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double? fontSize;
  final String? title;
  final Widget? child;
  final EdgeInsets? margin;
  final Function() onPressed;
  final Color? textColor;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kPrimaryColor.withOpacity(0.5),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(
            title ?? '',
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kBlack,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

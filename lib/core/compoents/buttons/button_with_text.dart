import 'package:flutter/material.dart';

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    Key? key,
    required this.onTap,
    required this.text,
    this.fontSize = 23,
  }) : super(key: key);
  final Function() onTap;
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xffFAF9F4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: const Color(0xff66788C),
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

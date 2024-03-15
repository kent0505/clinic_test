import 'package:flutter/material.dart';
import 'package:sadykova_app/core/theme/colors.dart';

class CustomLine extends StatelessWidget {
  const CustomLine({
    Key? key,
    this.color = kLinerColor,
    this.height = 1,
  }) : super(key: key);

  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 0.5,
      color: color,
    );
  }
}

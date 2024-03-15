import 'package:flutter/material.dart';
import 'package:sadykova_app/core/theme/text_styles.dart';

class SaleTypeWidget extends StatelessWidget {
  const SaleTypeWidget({
    Key? key,
    required this.title,
    required this.color,
    this.textColor = const Color(0xff66788C),
    this.date = '',
    this.isAction = false,
  }) : super(key: key);

  final String title;
  final Color color;
  final Color textColor;
  final String? date;
  final bool isAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: mainRegulartTextStyle.copyWith(
              color: textColor,
              fontSize: 14,
              fontWeight: isAction ? FontWeight.w400 : FontWeight.w600,
              fontFamily: isAction ? 'Montserrat' : null,
            ),
          ),
          if (isAction)
            Text(
              " – $date",
              style: mainRegulartTextStyle.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
        ],
      ),
    );
  }
}

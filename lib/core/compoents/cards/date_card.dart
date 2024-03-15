import 'package:flutter/material.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/theme/text_styles.dart';

class DateCard extends StatelessWidget {
  const DateCard({Key? key, required this.startDate, required this.endDate})
      : super(key: key);
  final String startDate;
  final String endDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(47),
        color: kSecondaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 6, bottom: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Дата проведения  ",
              style:
                  mainBoldTextStyle.copyWith(fontSize: 14, color: kWhiteColor),
            ),
            Text(
              startDate,
              style: mainRegulartTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kWhiteColor),
            ),
            Text(
              "  -  $endDate",
              style: mainRegulartTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kWhiteColor),
            ),
          ],
        ),
      ),
    );
  }
}

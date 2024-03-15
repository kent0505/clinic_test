import 'package:flutter/material.dart';
import 'package:sadykova_app/core/compoents/top_snackbar/top_snack_bar.dart';
import 'package:sadykova_app/core/theme/colors.dart';


void showTopAlertSucces(BuildContext context, String text,{double topPadding = 16}) async {
  showTopSnackBar(
    context,
    Material(
      type: MaterialType.transparency,
      child: Container(
        clipBehavior: Clip.hardEdge,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.done,
                color: kWhiteColor,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.zero,
                child: Text(
                  text,
                  style: const TextStyle(color: kWhiteColor, fontSize: 15),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    displayDuration: const Duration(seconds: 2),
    additionalTopPadding: topPadding
  );
}

void showTopAlertError(BuildContext context, String text,{double topPadding = 16}) async {
  showTopSnackBar(
    context,
    Material(
      type: MaterialType.transparency,
      child: Container(
        clipBehavior: Clip.hardEdge,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: const BoxDecoration(
          color: kRedColor,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.error,
                color: kWhiteColor,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.zero,
                child: Text(
                  text,
                  style: const TextStyle(color: kWhiteColor, fontSize: 15),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    displayDuration: const Duration(seconds: 2),
    additionalTopPadding: topPadding
  );
}

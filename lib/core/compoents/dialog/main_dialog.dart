import 'package:flutter/material.dart';
import 'package:sadykova_app/core/theme/colors.dart';

import 'cards/main_card.dart';

class MainDialog extends StatelessWidget {
  const MainDialog({
    Key? key,
    this.title,
    this.child,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.only(left: 24, right: 24),
  }) : super(key: key);

  final String? title;
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: MainCard(
          padding: const EdgeInsets.only(bottom: 16),
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).scaffoldBackgroundColor,
          margin: const EdgeInsets.only(bottom: 30),
          shadowPadding: const EdgeInsets.only(bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
                child: Text(
                  title ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kBlack,
                  ),
                ),
              ),
              Container(
                padding: padding,
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

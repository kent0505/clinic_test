import 'package:flutter/material.dart';
import 'package:sadykova_app/core/compoents/dialog/cards/main_card.dart';

class MainDialog extends StatelessWidget {
  final String title;
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const MainDialog({
    Key? key,
    required this.title,
    required this.child,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.only(left: 24, right: 24),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      margin: margin,
      child: Material(
        color: Theme.of(context).splashColor,
        child: MainCard(
          padding: const EdgeInsets.only(bottom: 16),
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).scaffoldBackgroundColor,
          margin: const EdgeInsets.only(bottom: 30),
          shadowPadding: const EdgeInsets.only(bottom: 24),
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (title.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).canvasColor,
                          ),
                    ),
                  ),
                Container(
                  padding: padding,
                  child: child,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sadykova_app/core/theme/text_styles.dart';

class MenuWithDote extends StatelessWidget {
  const MenuWithDote({
    Key? key,
    this.title,
    required this.menuItems,
    this.isNumber = false,
  }) : super(key: key);
  final String? title;
  final List<String> menuItems;
  final bool isNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Column(
            children: [
              Text(
                title!,
                style: mainBoldTextStyle.copyWith(fontSize: 17),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        Column(
          children: List.generate(
            menuItems.length,
            (index) => buildMenuItem(menuItems[index], index),
          ),
        )
      ],
    );
  }

  Widget buildMenuItem(String item, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          !isNumber
              ? Text(
                  "·",
                  style: mainBoldTextStyle.copyWith(
                      fontWeight: FontWeight.w700, fontSize: 18),
                )
              : Text(
                  "${index + 1}.",
                  style: mainRegulartTextStyle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              item,
              style: mainRegulartTextStyle.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}

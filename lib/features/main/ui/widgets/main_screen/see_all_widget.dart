import 'package:flutter/material.dart';

class SeeAllWidget extends StatelessWidget {
  const SeeAllWidget({
    Key? key,
    required this.mainText,
    required this.onTapAll,
    this.showAll = true,
  }) : super(key: key);

  final String mainText;
  final Function() onTapAll;
  final bool showAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            mainText,
            style: const TextStyle(
              color: Color(0xff66788C),
              fontSize: 23,
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat-b',
            ),
          ),
          if (showAll)
            InkWell(
              onTap: onTapAll,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(5),
                child: const Text(
                  "Вce",
                  style: TextStyle(
                    color: Color(0xff66788C),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

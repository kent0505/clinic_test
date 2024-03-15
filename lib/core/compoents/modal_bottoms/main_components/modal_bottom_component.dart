import 'package:flutter/material.dart';
import 'package:sadykova_app/core/compoents/buttons/elevated_fill_button.dart';

class ModalBottomComponent extends StatelessWidget {
  const ModalBottomComponent({
    Key? key,
    required this.onTapButton,
  }) : super(key: key);

  final Function() onTapButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 70),
          const Text(
            "Запишитесь,\nмы Вам рады!",
            style: TextStyle(
              color: Color(0xff66788C),
              fontSize: 38,
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat-b',
            ),
          ),
          const SizedBox(height: 22),
          ElevatedFillButton(
            height: 55,
            onTap: onTapButton,
            title: 'Записаться',
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class StaffTypeContainer extends StatelessWidget {
  const StaffTypeContainer({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Ink(
        height: 32,
        decoration: BoxDecoration(
          color: const Color(0xffD8DCE0),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                color: Color(0xff66788C),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}

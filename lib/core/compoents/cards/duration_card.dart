import 'package:flutter/material.dart';

class DurationCard extends StatelessWidget {
  const DurationCard({
    Key? key,
    required this.title,
    required this.duration,
  }) : super(key: key);

  final String title;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(47),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$title – ',
              style: const TextStyle(
                color: Color(0xff66788C),
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat',
              ),
            ),
            Text(
              duration,
              style: const TextStyle(
                color: Color(0xff66788C),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

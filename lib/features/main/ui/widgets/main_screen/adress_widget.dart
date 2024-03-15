import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class AdressWidget extends StatelessWidget {
  const AdressWidget({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xff66788C),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Html(
          data: body,
          style: {
            '#': Style(
              color: const Color(0xff66788C),
              fontSize: const FontSize(14),
              fontFamily: 'Montserrat',
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
            ),
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

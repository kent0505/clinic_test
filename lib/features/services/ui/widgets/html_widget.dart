import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CustomHtmlWidget extends StatelessWidget {
  const CustomHtmlWidget({
    Key? key,
    required this.title,
    required this.data,
    this.textStyle,
    this.imgStyle,
    this.titleFontSize = 17,
  }) : super(key: key);

  final String title;
  final String data;
  final Style? textStyle;
  final Style? imgStyle;
  final double titleFontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Text(
            title,
            style: TextStyle(
              color: const Color(0xff66788C),
              fontSize: titleFontSize,
              fontWeight: FontWeight.w700,
            ),
          ),
        // const SizedBox(height: 12),
        Html(
          data: data,
          style: {
            '#': textStyle != null
                ? textStyle!.copyWith(
                    color: const Color(0xff66788C),
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                  )
                : Style(
                    color: const Color(0xff66788C),
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                  ),
            'img': imgStyle != null
                ? imgStyle!
                : Style(
                    color: const Color(0xff66788C),
                    fontSize: const FontSize(15),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Montserrat',
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                  ),
          },
        )
      ],
    );
  }
}

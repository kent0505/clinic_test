import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sadykova_app/core/compoents/image/oval_avatar.dart';

class PhotoTextMenuItem extends StatelessWidget {
  const PhotoTextMenuItem({
    Key? key,
    required this.title,
    required this.description,
    required this.photo,
    this.advantage = false,
  }) : super(key: key);

  final String title;
  final String description;
  final String photo;
  final bool advantage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: advantage ? 16 : 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OvalAvatar(
            height: advantage ? 60 : 56,
            width: advantage ? 60 : 56,
            imgPath: photo,
          ),
          SizedBox(width: advantage ? 16 : 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xff66788C),
                    fontSize: advantage ? 15 : 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: advantage ? 4 : 5),
                Html(
                  data: description,
                  style: {
                    '#': Style(
                      color: const Color(0xff66788C),
                      fontSize: const FontSize(13),
                      fontFamily: 'Montserrat',
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                    ),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

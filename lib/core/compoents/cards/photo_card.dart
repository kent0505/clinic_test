import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/theme/text_styles.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({
    Key? key,
    required this.title,
    this.photo,
    required this.body,
  }) : super(key: key);
  final String title;
  final String? photo;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: kWhiteColor, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(photo!=null)
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.48,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(photo!),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
              ],
            ),
            Text(
              title,
              style: mainBoldTextStyle.copyWith(
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            body,
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sadykova_app/core/compoents/loaders/loader.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';

class OvalAvatar extends StatelessWidget {
  const OvalAvatar({
    Key? key,
    this.imgPath = '',
    this.height = 40,
    this.width = 40,
    this.defaultImage = defaultUseravatar,
  }) : super(key: key);

  final String imgPath;
  final double height;
  final double width;
  final String defaultImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CachedNetworkImage(
        imageUrl: imgPath,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: imageProvider,
            ),
          ),
        ),
        errorWidget: (context, a, b) {
          return Container();
        },
        placeholder: (context, url) => const Center(
          child: Loader(),
        ),
      ),
    );
  }
}

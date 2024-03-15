import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sadykova_app/core/compoents/loaders/loader.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/core/utils/path_converter.dart';

class CardWithSlider extends StatelessWidget {
  const CardWithSlider({
    Key? key,
    required this.photos,
    required this.topWidget,
    this.photoHeight = 100,
    this.photoWidth = 100,
    required this.onImageTap,
  }) : super(key: key);

  final List<String?> photos;
  final Widget topWidget;
  final double photoHeight;
  final double photoWidth;
  final Function(int index, String url) onImageTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 19,
            color: Color(0x0d474139),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topWidget,
            if (photos.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 18),
                child: SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      photos.length,
                      (index) => InkWell(
                        onTap: () {
                          onImageTap(index, photos[index] ?? '');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: photos[index] != null
                              ? CachedNetworkImage(
                                  imageUrl: ImagePathConvertor.convertTopaht(
                                    path: photos[index] ?? '',
                                  ),
                                  placeholder: (context, url) {
                                    return const Center(
                                      child: Loader(),
                                    );
                                  },
                                  errorWidget: (context, a, b) {
                                    return SizedBox(
                                      height: photoHeight,
                                      width: photoWidth,
                                    );
                                  },
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      height: photoHeight,
                                      width: photoWidth,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : CachedNetworkImage(
                                  imageUrl: noImageLink,
                                  placeholder: (context, url) => const Center(
                                    child: Loader(),
                                  ),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    height: photoHeight,
                                    width: photoWidth,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

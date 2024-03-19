import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/core/utils/path_converter.dart';

class ModalHedaerPhoto extends StatelessWidget {
  const ModalHedaerPhoto({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String? path;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.8,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(
            path != null
                ? ImagePathConvertor.convertTopaht(path: path!)
                : noImageLink,
          ),
        ),
      ),
    );
  }
}

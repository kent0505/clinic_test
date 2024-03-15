import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sadykova_app/core/compoents/loaders/loader.dart';
import 'package:sadykova_app/core/utils/path_converter.dart';
import 'package:sadykova_app/features/main/domain/models/equipment_model.dart';

class EquepmantCard extends StatelessWidget {
  const EquepmantCard({
    Key? key,
    required this.model,
    required this.onTapCard,
    this.isLoading = false,
  }) : super(key: key);

  final EquipmentModel model;
  final Function() onTapCard;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapCard();
      },
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 207,
            child: CachedNetworkImage(
              imageUrl: ImagePathConvertor.convertTopaht(path: model.path!),
              placeholder: (context, url) {
                return const Center(
                  child: Loader(),
                );
              },
              errorWidget: (context, a, b) {
                return Container();
              },
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 207,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: imageProvider,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Text(
            model.name ?? '',
            style: const TextStyle(
              color: Color(0xff66788C),
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            convertHtmlToSimpleString(
              model.description ?? '',
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xff66788C),
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
    );
  }

  String convertHtmlToSimpleString(String text) {
    if (text.isEmpty) {
      return '';
    }
    String newString = Bidi.stripHtmlIfNeeded(text);
    return newString.substring(1);
  }
}

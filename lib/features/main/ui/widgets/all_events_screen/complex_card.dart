import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sadykova_app/core/compoents/loaders/loader.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/utils/path_converter.dart';
import 'package:sadykova_app/features/main/domain/models/complex_service_model.dart';

class ComplexCard extends StatelessWidget {
  const ComplexCard({
    Key? key,
    required this.model,
    required this.onTap,
    required this.isLoading,
  }) : super(key: key);

  final ComplexServiceModel model;
  final Function() onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5, top: 5),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 220,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: ImagePathConvertor.convertTopaht(
                  path: model.path ?? '',
                ),
                placeholder: (context, url) => const Center(
                  child: Loader(),
                ),
                errorWidget: (context, a, b) {
                  return Container();
                },
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: kBlack.withOpacity(0.65),
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      kBlack.withOpacity(0.6),
                      kBlack.withOpacity(0),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      model.name ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: AutoSizeText(
                        model.shortTitle ?? '',
                        maxLines: 4,
                        presetFontSizes: const [15, 14],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: isLoading ? const Loader() : const SizedBox.shrink(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

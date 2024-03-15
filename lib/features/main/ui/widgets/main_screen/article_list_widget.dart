import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sadykova_app/core/compoents/loaders/loader.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/core/utils/path_converter.dart';
import 'package:sadykova_app/features/main/domain/models/article_model.dart';

class ArticleListWidget extends StatelessWidget {
  const ArticleListWidget({
    Key? key,
    required this.listOfArticle,
    required this.onTap,
  }) : super(key: key);

  final List<ArticleModel> listOfArticle;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    if (listOfArticle.isEmpty) {
      return Container();
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        itemCount: listOfArticle.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: () {
                onTap(index);
              },
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                        imageUrl: ImagePathConvertor.convertTopaht(
                          path: listOfArticle[index].path ?? noImageLink,
                        ),
                        placeholder: (context, url) {
                          return const Center(child: Loader());
                        },
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            height:
                                MediaQuery.of(context).size.width * 0.4 * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                    const SizedBox(height: 11),
                    Text(
                      listOfArticle[index].name ?? '',
                      maxLines: 4,
                      style: const TextStyle(
                        color: Color(0xff66788C),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

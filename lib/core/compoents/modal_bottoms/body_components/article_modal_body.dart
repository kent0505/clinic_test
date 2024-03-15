import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_components/modal_header_photo.dart';
import 'package:sadykova_app/features/main/domain/models/article_model.dart';

class ArticleModalBody extends StatelessWidget {
  const ArticleModalBody({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ArticleModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ModalHedaerPhoto(path: model.path),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 21),
              Text(
                model.name ?? '',
                style: const TextStyle(
                  color: Color(0xff66788C),
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat-b',
                ),
              ),
              const SizedBox(height: 31),
              DefaultTextStyle.merge(
                style: const TextStyle(color: Color(0xff66788C)),
                child: Html(
                  data: model.description ?? '',
                  style: {
                    '#': Style(
                      color: const Color(0xff66788C),
                      fontFamily: 'Montserrat',
                      padding: EdgeInsets.zero,
                      margin: const EdgeInsets.only(bottom: 8),
                    ),
                  },
                ),
              ),
              // CustomHtmlWidget(title: "", data: model.description ?? '')
            ],
          ),
        )
      ],
    );
  }
}

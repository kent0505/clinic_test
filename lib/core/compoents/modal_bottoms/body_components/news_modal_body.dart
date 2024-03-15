import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sadykova_app/core/compoents/buttons/elevated_fill_button.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/webview_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_components/modal_header_photo.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/web_view_modal_bottom.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/utils/constants.dart';
import 'package:sadykova_app/core/utils/date_converter.dart';
import 'package:sadykova_app/features/main/domain/models/news_model.dart';
import 'package:sadykova_app/features/main/ui/widgets/sale_type_widget.dart';

class NewsModalBody extends StatelessWidget {
  const NewsModalBody({
    Key? key,
    required this.model,
  }) : super(key: key);

  final NewsModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ModalHedaerPhoto(path: model.path),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                model.name ?? '',
                style: const TextStyle(
                  color: Color(0xff66788C),
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat-b',
                ),
              ),
              const SizedBox(height: 16),
              SaleTypeWidget(
                color: kWhiteColor,
                title: DateConverter.convertStringToDate(model.date ?? ''),
              ),
              const SizedBox(height: 32),
              Html(
                data: model.description ?? '',
                style: {
                  '#': Style(
                    color: const Color(0xff66788C),
                    fontFamily: 'Montserrat',
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                  ),
                },
              ),
              const SizedBox(height: 32),
              ElevatedFillButton(
                height: 55,
                fontSize: 17,
                onTap: () {
                  WebViewModalBotom.showSimpleModalBottom(
                    isNeddPaddingBottom: false,
                    context: context,
                    body: const WebViewModalBody(
                      url: orederLink,
                    ),
                  );
                },
                title: 'Запись на прием',
              ),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sadykova_app/core/compoents/functions/function.dart';
import 'package:sadykova_app/core/compoents/url/ull_launcher.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/features/main/domain/models/contact_model.dart';
import 'package:sadykova_app/features/main/ui/widgets/main_screen/social_item_widget.dart';

class SocialList extends StatelessWidget {
  final ContactMdel website;
  final ContactMdel vk;
  final ContactMdel whastapp;

  const SocialList({
    Key? key,
    required this.website,
    required this.vk,
    required this.whastapp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SocialItemWidget(
            icon: webIcon,
            onTap: () {
              UrlLauncher.launchURL(
                convertHtmlToSimpleString(website.description ?? ''),
              );
            },
          ),
          const SizedBox(width: 6),
          SocialItemWidget(
            icon: vkIcon,
            onTap: () {
              UrlLauncher.launchURL(
                convertHtmlToSimpleString(vk.description ?? ''),
              );
            },
          ),
          const SizedBox(width: 6),
          SocialItemWidget(
            icon: whatsappIconmain,
            onTap: () {
              openWhatsapp(
                context: context,
                number: convertLinkToNumber(link: whastapp.description ?? '')
                    .replaceAll(" ", ""),
                text: '',
              );
            },
          ),
        ],
      ),
    );
  }

  String convertHtmlToSimpleString(String text) {
    String newString = Bidi.stripHtmlIfNeeded(text);
    return newString.substring(1);
  }
}

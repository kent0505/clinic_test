import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/features/main/domain/models/contact_model.dart';
import 'package:sadykova_app/features/main/ui/widgets/main_screen/adress_widget.dart';
import 'package:sadykova_app/features/main/ui/widgets/main_screen/social_list_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsWidget extends StatelessWidget {
  const ContactsWidget({
    Key? key,
    required this.contactModel,
    required this.mapWidget,
  }) : super(key: key);

  final List<ContactMdel> contactModel;
  final Widget mapWidget;

  @override
  Widget build(BuildContext context) {
    ContactMdel phone =
        contactModel.firstWhere((element) => element.type == 'phone');
    ContactMdel website =
        contactModel.firstWhere((element) => element.type == 'site');
    ContactMdel whatsapp =
        contactModel.firstWhere((element) => element.type == 'whatsapp');
    ContactMdel vk = contactModel.firstWhere((element) => element.type == 'vk');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(contactModel.length, (index) {
                if (contactModel[index].type == 'vk' ||
                    contactModel[index].type == 'telegram' ||
                    contactModel[index].type == 'phone' ||
                    contactModel[index].type == 'site' ||
                    contactModel[index].type == 'whatsapp') {
                  return Container();
                }

                return AdressWidget(
                  title: contactModel[index].name ?? '',
                  body: contactModel[index].description ?? '',
                );
              }),
            ),
            const SizedBox(height: 4),
            Material(
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () async {
                  Uri uri = Uri(
                    scheme: 'tel',
                    path: convertHtmlToSimpleString(phone.description ?? '')
                        .replaceAll(" ", ""),
                  );
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    throw 'Could make call';
                  }
                },
                borderRadius: BorderRadius.circular(8),
                child: Ink(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xffFAF9F4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      convertHtmlToSimpleString(phone.description ?? ''),
                      style: const TextStyle(
                        color: Color(0xff66788C),
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            SocialList(
              website: website,
              vk: vk,
              whastapp: whatsapp,
            ),
            // const SizedBox(height: 4),
            mapWidget,
          ],
        ),
      ),
    );
  }

  String convertHtmlToSimpleString(String text) {
    String newString = Bidi.stripHtmlIfNeeded(text);
    return newString.substring(1);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sadykova_app/core/compoents/cards/duration_card.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_components/modal_bottom_component.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_components/modal_header_photo.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_components/text_with_dot.dart';
import 'package:sadykova_app/core/compoents/utils/custom_line.dart';
import 'package:sadykova_app/core/theme/text_styles.dart';
import 'package:sadykova_app/features/main/ui/widgets/card_with_slider.dart';
import 'package:sadykova_app/features/profile/ui/screens/photo_open_screen.dart';
import 'package:sadykova_app/features/staffs/domain/models/certificates_model.dart';
import 'package:sadykova_app/features/staffs/domain/models/staff_model.dart.dart';
import 'package:sadykova_app/features/staffs/ui/widgets/review_widget.dart';

class StaffModalBody extends StatelessWidget {
  const StaffModalBody({
    Key? key,
    required this.model,
    required this.onAcept,
  }) : super(key: key);

  final StaffModel model;
  final Function(BuildContext context) onAcept;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (model.path != null || model.path!.isNotEmpty) ...[
          ModalHedaerPhoto(path: model.path),
        ],
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      model.name ?? '',
                      style: const TextStyle(
                        color: Color(0xff66788C),
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat-b',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    model.position ?? '',
                    style: const TextStyle(
                      color: Color(0xff66788C),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(height: 15),
                  if (model.workDuration != null)
                    DurationCard(
                      title: 'Опыт работы',
                      duration: '${model.workDuration} лет',
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const CustomLine(color: Color(0x6666788C)),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (model.specialization != null) ...[
                    const Text(
                      'Специализация:',
                      style: TextStyle(
                        color: Color(0xff66788C),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    DefaultTextStyle.merge(
                      style: const TextStyle(color: Color(0xff66788C)),
                      child: Html(
                        data: model.specialization,
                        style: {
                          '#': Style(
                            fontSize: const FontSize(14),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat',
                            color: const Color(0xff66788C),
                          ),
                          'li': Style(
                            fontSize: const FontSize(14),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat',
                            color: const Color(0xff66788C),
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.only(bottom: 4),
                          ),
                        },
                      ),
                    ),
                  ],
                  if (model.education != null) ...[
                    const SizedBox(height: 18),
                    const Text(
                      'Образование:',
                      style: TextStyle(
                        color: Color(0xff66788C),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    DefaultTextStyle.merge(
                      style: const TextStyle(color: Color(0xff66788C)),
                      child: Html(
                        data: model.education,
                        style: {
                          'li': Style(
                            fontSize: const FontSize(14),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat',
                            color: const Color(0xff66788C),
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.only(bottom: 6),
                          ),
                          'span': Style(
                            fontSize: const FontSize(14),
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff66788C),
                            fontFamily: 'Montserrat',
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.only(bottom: 6),
                          ),
                        },
                      ),
                    ),
                  ],
                  if (model.workExperience != null) ...[
                    const SizedBox(height: 18),
                    const Text(
                      'О враче:',
                      style: TextStyle(
                        color: Color(0xff66788C),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Html(
                      data: model.workExperience,
                      style: {
                        '#': Style(
                          fontSize: const FontSize(14),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat',
                          color: const Color(0xff66788C),
                          margin: EdgeInsets.zero,
                          padding: const EdgeInsets.only(top: 4),
                        ),
                      },
                    ),
                  ],
                  if (model.certifacates != null &&
                      model.certifacates!.isNotEmpty)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        Text(
                          'Курсы повышения \nквалификации',
                          style: mainBoldTextStyle.copyWith(
                            color: const Color(0xff66788C),
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat-b',
                          ),
                        ),
                        const SizedBox(height: 16),
                        CardWithSlider(
                          photoWidth: 147,
                          onImageTap: (index, url) {
                            pushNewScreen(
                              context,
                              withNavBar: false,
                              screen: PhotoOpenScreen(
                                initialIndex: index,
                                photoModels: convertToListPath(
                                  model.certifacates ?? [],
                                ),
                              ),
                            );
                          },
                          photos: convertToListPath(model.certifacates ?? []),
                          topWidget: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Column(
                              children: List.generate(
                                model.certifacates!.length,
                                (index) {
                                  return TextWithDot(
                                    text: model
                                            .certifacates![index].description ??
                                        '',
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (model.images != null && model.images!.isNotEmpty)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        Text(
                          'Результаты работы',
                          style: mainBoldTextStyle.copyWith(
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        CardWithSlider(
                          onImageTap: (index, url) {
                            pushNewScreen(
                              context,
                              withNavBar: false,
                              screen: PhotoOpenScreen(
                                initialIndex: index,
                                photoModels: model.images ?? [],
                              ),
                            );
                          },
                          photos: model.images ?? [],
                          photoWidth: 150,
                          topWidget: Container(),
                        ),
                      ],
                    ),
                  if (model.reviews != null && model.reviews!.isNotEmpty) ...[
                    const SizedBox(height: 25),
                    const Text(
                      'Отзывы:',
                      style: TextStyle(
                        color: Color(0xff66788C),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: List.generate(
                        model.reviews!.length,
                        (index) {
                          return ReviewWidget(
                            review: model.reviews![index],
                          );
                        },
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
        ModalBottomComponent(
          onTapButton: () {
            onAcept(context);
          },
        )
      ],
    );
  }

  List<String?> convertToListPath(List<Certifacates> certificates) {
    List<String?> newList = [];
    for (var item in certificates) {
      if (item.path != null && item.path!.isNotEmpty) {
        newList.add(item.path);
      }
    }
    return newList;
  }
}

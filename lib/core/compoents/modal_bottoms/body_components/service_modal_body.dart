import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sadykova_app/core/compoents/cards/duration_card.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_components/advantage_widget.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_components/modal_bottom_component.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_components/modal_header_photo.dart';
import 'package:sadykova_app/core/theme/text_styles.dart';
import 'package:sadykova_app/core/utils/path_converter.dart';
import 'package:sadykova_app/features/main/ui/widgets/card_with_slider.dart';
import 'package:sadykova_app/features/main/ui/widgets/instruction_widget.dart';
import 'package:sadykova_app/features/main/ui/widgets/photo_text_menu_item.dart';
import 'package:sadykova_app/features/profile/ui/screens/photo_open_screen.dart';
import 'package:sadykova_app/features/services/domain/models/advantage_model.dart';
import 'package:sadykova_app/features/services/domain/models/service_model.dart';

class ServiceModalBody extends StatelessWidget {
  const ServiceModalBody({
    Key? key,
    required this.model,
    required this.advantages,
    required this.onAccept,
  }) : super(key: key);

  final ServiceModel model;
  final List<AdvantageModal> advantages;
  final Function(BuildContext context) onAccept;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        model.path!.isNotEmpty
            ? ModalHedaerPhoto(path: model.path)
            : Container(),
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
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat-b',
                ),
              ),
              const SizedBox(height: 16),
              DurationCard(
                duration: model.duration ?? '',
                title: "Длительность",
              ),
              const SizedBox(height: 17),
              if (model.mainDescription != null)
                DefaultTextStyle.merge(
                  style: const TextStyle(color: Color(0xff66788C)),
                  child: Html(
                    data: model.mainDescription ?? '',
                    style: {
                      '#': Style(
                        color: const Color(0xff66788C),
                        fontSize: const FontSize(14),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Montserrat',
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                      ),
                    },
                  ),
                ),
              const SizedBox(height: 12),
              if (model.contraindicationsDescription != null)
                InstructionItem(
                  title: 'Противопоказания',
                  body: model.contraindicationsDescription!,
                ),
              if (model.drugsDescription != null)
                InstructionItem(
                  title: 'Какие препараты используются',
                  body: model.drugsDescription ?? '',
                ),
              if (model.preparationDescription != null)
                InstructionItem(
                  title: 'Подготовка',
                  body: model.preparationDescription ?? '',
                ),
              if (advantages.isNotEmpty)
                AdvantageWidget(advantages: advantages),
              if (model.images != null && model.images!.isNotEmpty)
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
                  topWidget: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Эффект после процедуры",
                      style: TextStyle(
                        color: Color(0xff66788C),
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat-b',
                      ),
                    ),
                  ),
                ),
              if (model.staff != null && model.staff!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 44),
                    Text(
                      "Специалисты",
                      style: mainBoldTextStyle.copyWith(
                        color: const Color(0xff66788C),
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat-b',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: List.generate(
                        model.staff!.length,
                        (index) => PhotoTextMenuItem(
                          title: model.staff![index].name ?? '',
                          description: model.staff![index].position ?? '',
                          photo: ImagePathConvertor.convertTopaht(
                            path: model.staff![index].path ?? '',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        ModalBottomComponent(
          onTapButton: () {
            onAccept(context);
          },
        ),
      ],
    );
  }
}

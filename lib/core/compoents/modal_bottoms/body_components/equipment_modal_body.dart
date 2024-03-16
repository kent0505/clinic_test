import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:sadykova_app/core/compoents/buttons/elevated_fill_button.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/service_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/webview_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_components/modal_header_photo.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_modal_bottom.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/web_view_modal_bottom.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/utils/constants.dart';
import 'package:sadykova_app/features/appointment/domain/state/appointment_provider.dart';
import 'package:sadykova_app/features/main/domain/models/equipment_model.dart';
import 'package:sadykova_app/features/main/ui/widgets/card_with_slider.dart';
import 'package:sadykova_app/features/profile/ui/screens/photo_open_screen.dart';
import 'package:sadykova_app/features/services/domain/state/service_provider.dart';
import 'package:sadykova_app/features/services/ui/widgets/html_widget.dart';
import 'package:sadykova_app/features/services/ui/widgets/service_with_price.dart';
import 'package:sadykova_app/features/staffs/domain/state/staff_provider.dart';

class EquipModalBody extends StatelessWidget {
  const EquipModalBody({
    Key? key,
    required this.model,
    required this.onAcept,
  }) : super(key: key);

  final Function() onAcept;
  final EquipmentModel model;

  @override
  Widget build(BuildContext context) {
    final appointmemtProvider = Provider.of<AppointmemtProvider>(context);
    final staffProvider = Provider.of<StaffProvider>(context);
    final serviceProvider = Provider.of<ServiceProvider>(context);

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
              const SizedBox(height: 20),
              CustomHtmlWidget(
                title: "",
                data: model.description ?? '',
                textStyle: Style(
                  fontSize: const FontSize(15),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Montserrat',
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                ),
              ),
              const SizedBox(height: 32),
              CardWithSlider(
                onImageTap: (index, url) {
                  pushNewScreen(
                    context,
                    withNavBar: false,
                    screen: PhotoOpenScreen(
                      initialIndex: index,
                      photoModels: model.principleImages ?? [],
                    ),
                  );
                },
                photos: model.principleImages ?? [],
                topWidget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Принцип действия:',
                        style: TextStyle(
                          color: Color(0xff66788C),
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 21),
                      DefaultTextStyle.merge(
                        style: const TextStyle(color: Color(0xff66788C)),
                        child: Html(
                          data: model.principleDescription ?? '',
                          style: {
                            '#': Style(
                              color: const Color(0xff66788C),
                              fontSize: const FontSize(14),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Montserrat',
                              padding: EdgeInsets.zero,
                              margin: const EdgeInsets.only(bottom: 4),
                            ),
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              if (model.services != null && model.services!.isNotEmpty)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    const Text(
                      "Услуги",
                      style: TextStyle(
                        color: Color(0xff66788C),
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: List.generate(
                        model.services!.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: InkWell(
                            onTap: () async {
                              var result =
                                  await serviceProvider.getServiceDetailInfo(
                                serviceId: model.services![index].id!,
                              );

                              if (result) {
                                MainModalBottom.showSimpleModalBottom(
                                  context: context,
                                  isNeddPaddingBottom: false,
                                  body: ServiceModalBody(
                                    model: serviceProvider.selectService,
                                    advantages: serviceProvider.advantageList,
                                    onAccept: (BuildContext newContext) {
                                      staffProvider.creteOrderBySttaffAndId(
                                          serviceIds: [
                                            model.services![index].yclientsId!
                                          ]).then(
                                        (value) async {
                                          if (staffProvider
                                              .orderLink.isNotEmpty) {
                                            WebViewModalBotom
                                                .showSimpleModalBottom(
                                              isNeddPaddingBottom: false,
                                              expanded: true,
                                              backGroundColor: kWhiteColor,
                                              context: newContext,
                                              body: WebViewModalBody(
                                                url: staffProvider.orderLink,
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                            child: ServiceCardWithPrice(
                              serviceModel: model.services![index],
                              isSelected:
                                  appointmemtProvider.seletServices.contains(
                                model.services![index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
        buildbottomModal(context)
      ],
    );
  }

  Widget buildbottomModal(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 0.8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 130),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Запишитесь,\nмы Вам рады!",
                  style: TextStyle(
                    color: Color(0xff66788C),
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat-b',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedFillButton(
                  height: 55,
                  onTap: () async {
                    WebViewModalBotom.showSimpleModalBottom(
                      isNeddPaddingBottom: false,
                      context: context,
                      body: const WebViewModalBody(url: orederLink),
                    );
                  },
                  title: 'Записаться',
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

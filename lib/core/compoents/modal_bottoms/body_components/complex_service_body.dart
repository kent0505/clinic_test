import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/service_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/webview_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_components/modal_header_photo.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_modal_bottom.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/web_view_modal_bottom.dart';
import 'package:sadykova_app/core/compoents/utils/custom_line.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/features/appointment/domain/state/appointment_provider.dart';
import 'package:sadykova_app/features/main/domain/models/complex_service_model.dart';
import 'package:sadykova_app/features/main/ui/widgets/sale_type_widget.dart';
import 'package:sadykova_app/features/services/domain/state/service_provider.dart';
import 'package:sadykova_app/features/services/ui/widgets/service_with_price.dart';
import 'package:sadykova_app/features/staffs/domain/state/staff_provider.dart';

class ComplexServiceBody extends StatelessWidget {
  const ComplexServiceBody({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ComplexServiceModel model;

  @override
  Widget build(BuildContext context) {
    final appointmemtProvider = Provider.of<AppointmemtProvider>(context);
    final staffProvider = Provider.of<StaffProvider>(context);
    final serviceProvider = Provider.of<ServiceProvider>(context);

    return Column(
      children: [
        ModalHedaerPhoto(
          path: model.path,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 17,
            right: 12,
            left: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                model.name ?? '',
                style: const TextStyle(
                  color: Color(0xff66788C),
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat-b',
                ),
              ),
              const SizedBox(height: 18),
              SaleTypeWidget(
                date: model.duration,
                color: Colors.white,
                isAction: true,
                title: "Продолжительность",
              ),
              const SizedBox(height: 19),
              Html(
                data: model.description ?? '',
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
              const SizedBox(height: 32),
              buildListOfProgramm(context),
              const SizedBox(height: 10),
              buildPresentService(),
              const SizedBox(height: 10),
              buildFinalprice(),
              const SizedBox(height: 32),
              buildRecordText(),
              buildConsultationService(
                appointmemtProvider,
                staffProvider,
                serviceProvider,
                context,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildPresentService() {
    if (model.presentService == null) {
      return const SizedBox.shrink();
    }
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "В подарок!",
              style: TextStyle(
                color: Color(0xff66788C),
                fontSize: 23,
                fontWeight: FontWeight.w700,
                fontFamily: 'Montserrat-b',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    model.presentService!.name ?? '',
                    style: const TextStyle(
                      color: Color(0xff66788C),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Text(
                  "${model.presentService!.price} ₽",
                  style: const TextStyle(
                    color: Color(0xff66788C),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildListOfProgramm(BuildContext context) {
    if (model.services != null && model.services!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Программа включает:",
                style: TextStyle(
                  color: Color(0xff66788C),
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat-b',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: List.generate(
                model.services!.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 4, top: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLine(
                        color: const Color(0xFF66788C).withOpacity(0.4),
                        height: 0.5,
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                model.services![index].name ?? '',
                                style: const TextStyle(
                                  color: Color(0xff66788C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Text(
                              "${model.services![index].totalPrice} ₽",
                              style: const TextStyle(
                                color: Color(0xff66788C),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      // if (index < model.services!.length - 1)
                      //   const Padding(
                      //     padding: EdgeInsets.only(top: 8),
                      //     child: CustomLine(),
                      //   )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildFinalprice() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    "Итого:",
                    style: TextStyle(
                      color: Color(0xff66788C),
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat-b',
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${model.finalPrice} ₽",
                        style: const TextStyle(
                          color: Color(0xff66788C),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat',
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "${model.descount} ₽".replaceAll('-', ''),
                        style: const TextStyle(
                          color: Color(0xff66788C),
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Выгода ${model.totalCost!.abs()} ₽",
                        style: const TextStyle(
                          color: Color(0xff66788C),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "*Сумма оплаченого пакета будет на индивидуальном счете пациента в клинике",
          style: TextStyle(
            color: Color(0xff66788C),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: 'Montserrat',
          ),
        ),
      ],
    );
  }

  Widget buildRecordText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Запись на консультацию",
          style: TextStyle(
            color: Color(0xff66788C),
            fontSize: 23,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat-b',
          ),
        ),
        SizedBox(height: 16),
        Text(
          "Для прохождения данной программы необходима консультация нашего косметолога.",
          style: TextStyle(
            color: Color(0xff66788C),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: 'Montserrat',
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget buildConsultationService(
    AppointmemtProvider appointmemtProvider,
    StaffProvider staffProvider,
    ServiceProvider serviceProvider,
    BuildContext context,
  ) {
    if (model.consultationService == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () async {
        var result = await serviceProvider.getServiceDetailInfo(
          serviceId: model.consultationService!.id!,
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
                    serviceIds: [model.consultationService!.yclientsId!]).then(
                  (value) async {
                    if (staffProvider.orderLink.isNotEmpty) {
                      WebViewModalBotom.showSimpleModalBottom(
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
        isSelected: appointmemtProvider.seletServices.contains(
          model.consultationService,
        ),
        serviceModel: model.consultationService!,
        // isComplexService: false,
      ),
    );
  }
}

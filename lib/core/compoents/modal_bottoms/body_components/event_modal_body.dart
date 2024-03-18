import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sadykova_app/core/compoents/functions/function.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_components/modal_header_photo.dart';
import 'package:sadykova_app/core/compoents/utils/custom_line.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/core/utils/date_converter.dart';
import 'package:sadykova_app/features/main/domain/models/contact_model.dart';
import 'package:sadykova_app/features/main/domain/models/event_model.dart';
import 'package:sadykova_app/features/main/domain/state/home_provider.dart';
import 'package:sadykova_app/features/main/ui/widgets/sale_type_widget.dart';
import 'package:sadykova_app/features/services/ui/widgets/html_widget.dart';

class EventModalBody extends StatefulWidget {
  final EventModel model;
  final ContactMdel? whatsApp;

  const EventModalBody({
    Key? key,
    required this.model,
    required this.whatsApp,
  }) : super(key: key);

  @override
  State<EventModalBody> createState() => _EventModalBodyState();
}

class _EventModalBodyState extends State<EventModalBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final homeProvider = Provider.of<HomeProvider>(context, listen: false);
        homeProvider.getEventDetail(id: widget.model.id!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Column(
      children: [
        ModalHedaerPhoto(path: widget.model.path),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                widget.model.name ?? '',
                style: const TextStyle(
                  color: Color(0xff66788C),
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat-b',
                ),
              ),
              const SizedBox(height: 16),
              SaleTypeWidget(
                color: const Color(0xffE50052),
                title: 'Дата проведения ${DateConverter.convertStringToDate(
                  homeProvider.selectEvent?.schedule?[0].date ?? '',
                )}',
                textColor: Colors.white,
              ),
              const SizedBox(height: 32),
              Html(
                data: widget.model.description ?? '',
                style: {
                  '#': Style(
                    color: const Color(0xff66788C),
                    fontSize: const FontSize(14),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Montserrat',
                    padding: EdgeInsets.zero,
                    margin: const EdgeInsets.only(bottom: 8),
                  ),
                  'strong': Style(
                    color: const Color(0xff66788C),
                    fontSize: const FontSize(23),
                    fontWeight: FontWeight.w600,
                  ),
                },
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kWhiteColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: CustomHtmlWidget(
                      title: "",
                      data: widget.model.middleDescription ?? '',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Html(
                data: widget.model.bottomDescription ?? '',
                style: {
                  '#': Style(
                    color: const Color(0xff66788C),
                    fontSize: const FontSize(14),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Montserrat',
                    padding: EdgeInsets.zero,
                    margin: const EdgeInsets.only(bottom: 8),
                  ),
                  'strong': Style(
                    color: const Color(0xff66788C),
                    fontSize: const FontSize(23),
                    fontWeight: FontWeight.w600,
                  ),
                },
              ),
              if (widget.model.schedule != null &&
                  widget.model.schedule!.isNotEmpty)
                buildShedules(
                  widget.model.schedule ?? [],
                ),
              const SizedBox(height: 16),
              buildbottomModal(widget.model, widget.whatsApp, context)
            ],
          ),
        )
      ],
    );
  }

  Widget buildShedules(List<Schedule> schedule) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14, top: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          schedule.length,
          (index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kWhiteColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateConverter.convertStringToDateAndTime(
                      schedule[index].date ?? '',
                    ),
                    style: const TextStyle(
                      color: Color(0xff66788C),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Html(
                    data: schedule[index].description ?? '',
                    style: {
                      '#': Style(
                        color: const Color(0xff66788C),
                        fontSize: const FontSize(14),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Montserrat',
                        padding: EdgeInsets.zero,
                        margin: const EdgeInsets.only(bottom: 8),
                      ),
                      'strong': Style(
                        color: const Color(0xff66788C),
                        fontSize: const FontSize(23),
                        fontWeight: FontWeight.w600,
                      ),
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildbottomModal(
    EventModel event,
    ContactMdel? whatsApp,
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Записаться",
                          style: TextStyle(
                            color: Color(0xff66788C),
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (widget.model.address != null) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            widget.model.address ?? '',
                            style: const TextStyle(
                              color: Color(0xff66788C),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  // Container(
                  //   width: 60,
                  //   height: 60,
                  //   decoration: const BoxDecoration(
                  //     shape: BoxShape.circle,
                  //   ),
                  //   child: Image.asset(eventBG),
                  // )
                ],
              ),
              const SizedBox(height: 28),
              CustomLine(
                color: const Color(0xff66788C).withOpacity(0.4),
                height: 0.5,
              ),
            ],
          ),
          if (event.price != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Cтоимость",
                        style: TextStyle(
                          color: Color(0xff66788C),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Text(
                        '${event.price} ₽',
                        style: const TextStyle(
                          color: Color(0xff66788C),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomLine(
                  color: const Color(0xff66788C).withOpacity(0.4),
                  height: 0.5,
                ),
              ],
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              InkWell(
                onTap: () async {
                  // try {
                  //   String link =
                  //       "https://wa.me/${convertLinkToNumber(link: whatsApp!.description ?? '').replaceAll(" ", "")}";

                  //   await launchUrl(
                  //       Uri.parse(
                  //         link,
                  //       ),
                  //       mode: LaunchMode.externalApplication);
                  // } catch (error) {
                  // }
                  openWhatsapp(
                    context: context,
                    number: convertLinkToNumber(
                      link: whatsApp?.description ?? '',
                    ).replaceAll(" ", ""),
                    text: '',
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 16),
                    SvgPicture.asset(
                      whatsappIcon,
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      convertLinkToNumber(
                        link: whatsApp?.description ?? '',
                      ),
                      style: const TextStyle(
                        color: Color(0xff66788C),
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat-b',
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          )
        ],
      ),
    );
  }
}

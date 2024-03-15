import 'package:flutter/material.dart';
import 'package:sadykova_app/core/compoents/image/oval_avatar.dart';
import 'package:sadykova_app/core/compoents/utils/custom_line.dart';
import 'package:sadykova_app/core/utils/date_converter.dart';
import 'package:sadykova_app/features/profile/domain/models/record_model.dart';

class RecordCard extends StatelessWidget {
  const RecordCard({
    Key? key,
    required this.model,
    required this.isCurrent,
  }) : super(key: key);

  final RecordModel model;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              right: 16,
              left: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OvalAvatar(
                  imgPath: model.staff != null && model.staff!.avatar != null
                      ? model.staff!.avatar!
                      : '',
                  height: 76,
                  width: 76,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        DateConverter.convertStringToDate(model.datetime ?? ''),
                        style: const TextStyle(
                          color: Color(0xFF66788C),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        model.staff!.name ?? '',
                        style: const TextStyle(
                          color: Color(0xFF66788C),
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        model.staff!.position ?? '',
                        style: const TextStyle(
                          color: Color(0xFF66788C),
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // if (isCurrent)
          //   Padding(
          //     padding: const EdgeInsets.only(
          //         right: 16, top: 16, left: 16, bottom: 16),
          //     child: Row(
          //       children: [
          //         Expanded(
          //           flex: 3,
          //           child: ElvatedFillButton(
          //             buttonColor: kGreyScale300Color,
          //             elavted: 0,
          //             textColor: kRedColor,
          //             height: 38,
          //             onTap: () {},
          //             tittle: 'Отменить запись',
          //           ),
          //         ),
          //         const SizedBox(
          //           width: 8,
          //         ),
          //         Expanded(
          //           flex: 2,
          //           child: ElvatedFillButton(
          //             height: 38,
          //             elavted: 0,
          //             onTap: () {},
          //             tittle: 'Изменить',
          //             buttonColor: kGreyScale300Color,
          //             textColor: kGreyScale900Color,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          if (model.services != null && model.services!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                CustomLine(
                  color: const Color(0xff66788C).withOpacity(0.4),
                  height: 0.5,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      model.services!.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.services![index].cost.toString() + " ₽",
                                style: const TextStyle(
                                  color: Color(0xff66788C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                model.services![index].title.toString() +
                                    " ${(model.services![index].seanceLength! / 60).ceil()} Мин.",
                                style: const TextStyle(
                                  color: Color(0xff66788C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 13),
              ],
            ),
        ],
      ),
    );
  }
}

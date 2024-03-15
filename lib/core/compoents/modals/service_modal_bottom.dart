// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:sadykova_app/core/compoents/buttons/elvated_fill_button.dart';
// import 'package:sadykova_app/core/compoents/cards/duration_card.dart';
// import 'package:sadykova_app/core/theme/text_styles.dart';
// import 'package:sadykova_app/core/utils/asset_paths.dart';
// import 'package:sadykova_app/features/main/ui/widgets/card_with_slider.dart';
// import 'package:sadykova_app/features/services/domain/models/service_model.dart';
// import 'package:sadykova_app/features/services/ui/widgets/html_widget.dart';

// class ServiceModelBotoom extends StatefulWidget {
//   const ServiceModelBotoom({Key? key, required this.service}) : super(key: key);
//   final ServiceModel service;

//   @override
//   State<ServiceModelBotoom> createState() => _ServiceModelBotoomState();
// }

// class _ServiceModelBotoomState extends State<ServiceModelBotoom> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         buildHeader(),
//         buildInfos(),
//         buildEffectWidget(),
//         buildTeachers(),
//         buildBottomInfo()
//       ],
//     );
//   }

//   Widget buildBottomInfo() {
//     return Padding(
//       padding: const EdgeInsets.only(right: 12, left: 12),
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 130),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Запишитесь,\nмы Вам рады!",
//               style: mainBoldTextStyle.copyWith(
//                 fontSize: 36,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             ElvatedFillButton(
//               elavted: 2.0,
//               height: 55,
//               onTap: () {},
//               tittle: 'Записаться',
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildHeader() {
//     return Stack(
//       alignment: Alignment.topCenter,
//       children: [
//         Container(
//           height: MediaQuery.of(context).size.width * 0.56,
//           width: MediaQuery.of(context).size.width,
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//             image: DecorationImage(
//               fit: BoxFit.cover,
//               image: CachedNetworkImageProvider(noImageLink),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildInfos() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 20, right: 12, left: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 16),
//             child: Text(
//               widget.service.name ?? '',
//               style: mainBoldTextStyle.copyWith(
//                 fontSize: 28,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 16),
//             child: DurationCard(
//               duration: widget.service.duration ?? '',
//               title: "Длительность",
//             ),
//           ),
//           if (widget.service.mainDescription != null)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 16),
//               child: CustomHtmlWidget(
//                 title: 'Описание',
//                 data: widget.service.mainDescription ?? '',
//               ),
//             ),
//           if (widget.service.preparationDescription != null)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 16),
//               child: CustomHtmlWidget(
//                 title: 'Подготовка',
//                 data: widget.service.preparationDescription ?? '',
//               ),
//             ),
//           if (widget.service.drugsDescription != null)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 16),
//               child: CustomHtmlWidget(
//                 title: 'Препараты',
//                 data: widget.service.drugsDescription ?? '',
//               ),
//             ),
//           if (widget.service.contraindicationsDescription != null)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 16),
//               child: CustomHtmlWidget(
//                 title: 'Противопоказания',
//                 data: widget.service.contraindicationsDescription ?? '',
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget buildEffectWidget() {


//   Widget buildTeachers() {
//     if (widget.service.staff == null || widget.service.staff!.isEmpty) {
//       return Container();
//     }
//     return Padding(
//       padding: const EdgeInsets.only(right: 12, left: 12, top: 44),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Специалисты",
//             style: mainBoldTextStyle.copyWith(
//               fontSize: 23,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           const SizedBox(
//             height: 16,
//           ),
//           // Column(
//           //   children: List.generate(
//           //     widget.service.doctors.length,
//           //     (index) => PhotoTextMenuItem(
//           //       title: widget.service.doctors[index].name,
//           //       description: widget.service.doctors[index].typeStaff,
//           //       photo: widget.service.doctors[index].photo,
//           //     ),
//           //   ),
//           // )
//         ],
//       ),
//     );
//   }
// }

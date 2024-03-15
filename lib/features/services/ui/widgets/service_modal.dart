// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:sadykova_app/core/compoents/buttons/elvated_fill_button.dart';
// import 'package:sadykova_app/core/compoents/cards/duration_card.dart';
// import 'package:sadykova_app/core/theme/colors.dart';
// import 'package:sadykova_app/core/theme/text_styles.dart';
// import 'package:sadykova_app/core/utils/asset_paths.dart';
// import 'package:sadykova_app/features/main/ui/widgets/card_with_slider.dart';
// import 'package:sadykova_app/features/main/ui/widgets/close_widget.dart';
// import 'package:sadykova_app/features/services/domain/models/service_model.dart';
// import 'package:sadykova_app/features/services/ui/widgets/html_widget.dart';

// class ServiceBottomSheet extends StatefulWidget {
//   final Function onAcept;
//   final ScrollController controller;
//   final ServiceModel service;
//   const ServiceBottomSheet(
//       {Key? key,
//       required this.onAcept,
//       required this.controller,
//       required this.service})
//       : super(key: key);
//   @override
//   ServiceBottomSheetState createState() => ServiceBottomSheetState();
// }

// class ServiceBottomSheetState extends State<ServiceBottomSheet> {
//   @override
//   void initState() {
//     super.initState();
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

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.95,
//       decoration: const BoxDecoration(
//         color: kBgColor,
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(20),
//           topLeft: Radius.circular(20),
//         ),
//       ),
//       child: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           SingleChildScrollView(
//             physics: const ClampingScrollPhysics(),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     buildHeader(),
//                     buildInfos(),
//                     buildEffectWidget(),
//                     buildTeachers(),
//                   ],
//                 ),
//                 buildbottomModal(),
//               ],
//             ),
//           ),
//           closWidgets(),
//         ],
//       ),
//     );
//   }

//   Widget closWidgets() {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       height: 100,
//       child: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           Positioned(
//             right: 12,
//             top: 12,
//             child: CloseWidget(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//           Container(
//             width: 95,
//             height: 5,
//             margin: const EdgeInsets.only(bottom: 10, top: 6),
//             decoration: BoxDecoration(
//               color: kWhiteColor,
//               borderRadius: BorderRadius.circular(15),
//             ),
//           ),
//         ],
//       ),
//     );
//   }



//   // Widget buildInstruction() {
//   //   return Padding(
//   //     padding: const EdgeInsets.only(right: 12, left: 12),
//   //     child: Column(
//   //         children: List.generate(
//   //       widget.service.instructions.length,
//   //       (index) => InstructionItem(
//   //         instuction: widget.service.instructions[index],
//   //       ),
//   //     )),
//   //   );
//   // }

//   // Widget buildAdvantages() {
//   //   return Padding(
//   //     padding: const EdgeInsets.only(right: 12, left: 12),
//   //     child: AdvantageWidget(
//   //       advantages: widget.service.advantages,
//   //     ),
//   //   );
//   // }

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

//   Widget buildbottomModal() {
//     return 
//   }
// }

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:sadykova_app/core/compoents/buttons/elvated_fill_button.dart';
// import 'package:sadykova_app/core/theme/colors.dart';
// import 'package:sadykova_app/core/theme/text_styles.dart';
// import 'package:sadykova_app/core/utils/asset_paths.dart';
// import 'package:sadykova_app/core/utils/path_converter.dart';
// import 'package:sadykova_app/features/appointment/domain/state/appointment_provider.dart';
// import 'package:sadykova_app/features/services/domain/models/service_model.dart';
// import 'package:sadykova_app/features/services/ui/widgets/html_widget.dart';
// import 'package:sadykova_app/features/services/ui/widgets/service_with_price.dart';
// import 'package:sadykova_app/features/main/domain/models/equipment_model.dart';
// import 'package:sadykova_app/features/main/ui/widgets/card_with_slider.dart';
// import 'package:sadykova_app/features/main/ui/widgets/close_widget.dart';
// import 'package:provider/provider.dart';
// import 'package:sadykova_app/features/services/ui/widgets/widget_from_html.dart';

// import '../../../../features/staffs/domain/models/cource_model.dart';

// class EquepmentViewModal extends StatefulWidget {
//   final Function() onAcept;
//   final EquipmentModel model;
//   final bool showBottomButton;
//   const EquepmentViewModal({
//     Key? key,
//     required this.onAcept,
//     required this.model,
//     this.showBottomButton = false,
//   }) : super(key: key);
//   @override
//   EquepmentViewModalState createState() => EquepmentViewModalState();
// }

// class EquepmentViewModalState extends State<EquepmentViewModal> {
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
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//             image: DecorationImage(
//               fit: BoxFit.cover,
//               image: CachedNetworkImageProvider(
//                 ImagePathConvertor.convertTopaht(
//                   path: widget.model.path!,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
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

//   Widget buildInfos() {
//     final AppointmemtProvider appointmemtProvider =
//         Provider.of<AppointmemtProvider>(context);
//     return Padding(
//       padding: const EdgeInsets.only(top: 20, bottom: 17, right: 12, left: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.8,
//             child: Text(
//               widget.model.name ?? '',
//               style: mainBoldTextStyle.copyWith(
//                 fontSize: 28,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           CustomHtmlWidget(
//             title: "",
//             data: widget.model.description ?? '',
//             textStyle: Style(
//                 fontSize: const FontSize(15),
//                 fontWeight: FontWeight.w400,
//                 padding: EdgeInsets.zero,
//                 margin: EdgeInsets.zero),
//           ),
//           const SizedBox(
//             height: 25,
//           ),
//           buildPrincipes(),
//           const SizedBox(
//             height: 25,
//           ),
//           buildEffectWidget(),
//           listOfMiniServices(
//             models: widget.model.services ?? [],
//             provider: appointmemtProvider,
//           )
//         ],
//       ),
//     );
//   }

//   Widget buildPrincipes() {
//     return CustomWidgetFromHtml(
//       data: widget.model.principleDescription!,
//       title: 'Принцип действия:',
//     );
//   }

//   Widget listOfMiniServices(
//       {required List<ServiceModel> models,
//       required AppointmemtProvider provider}) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(
//           height: 32,
//         ),
//         Text(
//           "Услуги",
//           style: mainBoldTextStyle.copyWith(
//             fontSize: 28,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         const SizedBox(
//           height: 16,
//         ),
//         Column(
//           children: List.generate(
//             models.length,
//             (index) => ServiceCardWithPrice(
//               serviceModel: models[index],
//               isSelected: provider.seletServices.contains(models[index]),
//             ),
//           ),
//         ),
//         // const SizedBox(
//         //   height: 32,
//         // ),
//         // ElvatedFillButton(
//         //   tittle: "Показать ещё",
//         //   onTap: () {},
//         //   height: 55,
//         //   buttonColor: kWhiteColor,
//         //   textColor: kGreyScale900Color,
//         // )
//       ],
//     );
//   }


//   }

//   Widget buildListOfReviews() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(
//           height: 25,
//         ),
//         ElvatedFillButton(
//           tittle: "Показать ещё",
//           onTap: () {},
//           height: 55,
//           buttonColor: kWhiteColor,
//           textColor: kGreyScale900Color,
//         )
//       ],
//     );
//   }

//   Widget buildMenuItem(CourseModel item) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 8, bottom: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "· ",
//             style: mainBoldTextStyle.copyWith(
//                 fontWeight: FontWeight.w700, fontSize: 18),
//           ),
//           const SizedBox(
//             width: 8,
//           ),
//           Row(
//             children: [
//               Text(
//                 item.date,
//                 maxLines: 1,
//                 style: mainRegulartTextStyle.copyWith(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               Text(
//                 " - ",
//                 style: mainRegulartTextStyle.copyWith(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               Text(
//                 item.courseName,
//                 style: mainRegulartTextStyle.copyWith(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ],
//           )
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
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               // buildHeader(),
//               Expanded(
//                 child: ListView(
//                   physics: const ClampingScrollPhysics(),
//                   padding: EdgeInsets.zero,
//                   children: [
//                     buildHeader(),
//                     buildInfos(),
//                     buildbottomModal(),
//                   ],
//                 ),
//               )
//             ],
//           ),
//           closWidgets(),
//           if (widget.showBottomButton)
//             Positioned(
//               bottom: 38,
//               right: 12,
//               left: 12,
//               child: ElvatedFillButton(
//                 height: 48,
//                 onTap: () {
//                   Navigator.pop(context);
//                   widget.onAcept();
//                 },
//                 tittle: 'Выбрать врача',
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget buildbottomModal() {
//     return Stack(
//       alignment: Alignment.bottomCenter,
//       children: [
//         Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.width * 0.8,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               fit: BoxFit.cover,
//               image: AssetImage(
//                 modalBg,
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(right: 12, left: 12),
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 130),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Запишитесь,\nмы Вам рады!",
//                   style: mainBoldTextStyle.copyWith(
//                     fontSize: 36,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 ElvatedFillButton(
//                   height: 55,
//                   onTap: () {},
//                   tittle: 'Записаться',
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sadykova_app/core/theme/colors.dart';
// import 'package:sadykova_app/core/theme/text_styles.dart';

// class SegmentSlider extends StatefulWidget {
//   const SegmentSlider({
//     Key? key,
//     required this.onChanged,
//     required this.initValue,
//   }) : super(key: key);
//   final Function(int value) onChanged;
//   final int initValue;
//   List<String> listOfelements;

//   @override
//   State<SegmentSlider> createState() => _SegmentSliderState();
// }

// class _SegmentSliderState extends State<SegmentSlider> {
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoSlidingSegmentedControl<int>(
//       groupValue: widget.initValue,
//       backgroundColor: kGreyScale900Color.withOpacity(0.1),
//       thumbColor: kWhiteColor,
//       children: getListOfMap(),
//       padding: EdgeInsets.zero,
//       onValueChanged: (value) {
//         widget.onChanged(value!);
//       },
//     );
//   }

//   Map<int, dynamic> getListOfMap(){
//     Map<int, dynamic> mapOfWidgets={};
//     for(int i=0; i< widget.listOfelements.length; i++){
//         mapOfWidgets[i]=widget.listOfelements[i];
//     }
// return mapOfWidgets;
//   }

//   Widget buildSegment(String text) {
//     return Container(
//       padding: const EdgeInsets.only(
//         top: 8,
//         bottom: 8,
//       ),
//       child: Text(
//         text,
//         style: mainMediumTexttStyle.copyWith(
//           fontSize: 15,
//           fontWeight: FontWeight.w400,
//         ),
//       ),
//     );
//   }
// }

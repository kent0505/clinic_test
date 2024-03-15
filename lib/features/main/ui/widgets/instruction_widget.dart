import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sadykova_app/core/compoents/utils/custom_line.dart';

class InstructionItem extends StatelessWidget {
  InstructionItem({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  final String title;
  final String body;
  final controller = ExpandableController(initialExpanded: false);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      controller: controller,
      child: Expandable(
        collapsed: ExpandableButton(
          child: Column(
            children: [
              ExpandableButton(
                theme: const ExpandableThemeData(useInkWell: false),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      const SizedBox(height: 18),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Color(0xff66788C),
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Color(0xff66788C),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      CustomLine(
                        height: 1,
                        color: const Color(0xff66788C).withOpacity(0.4),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        expanded: ExpandableButton(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: ExpandableButton(
                  theme: const ExpandableThemeData(useInkWell: false),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        const SizedBox(height: 18),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: Color(0xff66788C),
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_up_rounded,
                              color: Color(0xff66788C),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        DefaultTextStyle.merge(
                          style: const TextStyle(color: Color(0xff66788C)),
                          child: Html(
                            data: body,
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
                        const SizedBox(height: 22),
                        CustomLine(
                          height: 1,
                          color: const Color(0xff66788C).withOpacity(0.4),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

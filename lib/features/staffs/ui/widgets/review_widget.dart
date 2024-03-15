import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/theme/text_styles.dart';
import 'package:sadykova_app/core/utils/date_converter.dart';
import 'package:sadykova_app/features/staffs/domain/models/review_model.dart';

// ignore: must_be_immutable
class ReviewWidget extends StatelessWidget {
  ReviewWidget({
    Key? key,
    required this.review,
  }) : super(key: key);

  final ReviewModel review;

  final controller = ExpandableController(
    initialExpanded: false,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ExpandableNotifier(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review.name!,
                                      style: const TextStyle(
                                        color: Color(0xff66788C),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      DateConverter.convertStringToDate(
                                        review.date ?? '',
                                      ),
                                      style: const TextStyle(
                                        color: Color(0xff66788C),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                // CachedNetworkImage(
                                //   imageUrl: review.path == null
                                //       ? noImageLink
                                //       : ImagePathConvertor.convertTopaht(
                                //           path: review.path ?? ''),
                                //   placeholder: (context, url) => const Center(
                                //     child: Loader(),
                                //   ),
                                //   imageBuilder: (context, imageProvider) =>
                                //       Container(
                                //     width: 53,
                                //     height: 53,
                                //     decoration: BoxDecoration(
                                //         image: DecorationImage(
                                //           fit: BoxFit.cover,
                                //           image: imageProvider,
                                //         ),
                                //         borderRadius: BorderRadius.circular(6)),
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(
                              review.description ?? '',
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xff66788C),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "Развернуть",
                              style: mainMediumTexttStyle.copyWith(
                                color: kGreyScale700Color,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
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
                  children: [
                    ExpandableButton(
                      theme: const ExpandableThemeData(useInkWell: false),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review.name ?? '',
                                      style: const TextStyle(
                                        color: Color(0xff66788C),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      DateConverter.convertStringToDate(
                                        review.date ?? '',
                                      ),
                                      style: const TextStyle(
                                        color: Color(0xff66788C),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                // CachedNetworkImage(
                                //   imageUrl: review.path == null
                                //       ? noImageLink
                                //       : ImagePathConvertor.convertTopaht(
                                //           path: review.path ?? ''),
                                //   placeholder: (context, url) => const Center(
                                //     child: Loader(),
                                //   ),
                                //   imageBuilder: (context, imageProvider) =>
                                //       Container(
                                //     width: 53,
                                //     height: 53,
                                //     decoration: BoxDecoration(
                                //         image: DecorationImage(
                                //           fit: BoxFit.cover,
                                //           image: imageProvider,
                                //         ),
                                //         borderRadius: BorderRadius.circular(6)),
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(
                              review.description ?? '',
                              style: const TextStyle(
                                color: Color(0xff66788C),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Свернуть",
                              style: TextStyle(
                                color: Color(0xff66788C),
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

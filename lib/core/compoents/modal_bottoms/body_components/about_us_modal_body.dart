import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:sadykova_app/core/compoents/loaders/loader.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_components/static_image_header.dart';
import 'package:sadykova_app/features/main/domain/state/home_provider.dart';

class AboutUsModalBody extends StatefulWidget {
  const AboutUsModalBody({Key? key}) : super(key: key);

  @override
  State<AboutUsModalBody> createState() => _AboutUsModalBodyState();
}

class _AboutUsModalBodyState extends State<AboutUsModalBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.getPages();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Column(
      children: [
        const StaticImageHeader(),
        if (homeProvider.pageLoading) ...[
          const SizedBox(height: 30),
          const Loader(),
        ] else ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                homeProvider.pageList.length,
                (index) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    if (homeProvider.pageList[index].name != null)
                      Text(
                        homeProvider.pageList[index].name ?? '',
                        style: const TextStyle(
                          color: Color(0xff66788C),
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Montserrat-b',
                        ),
                      ),
                    const SizedBox(height: 24),
                    if (homeProvider.pageList[index].description != null) ...[
                      Container(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                          bottom: 28,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Html(
                          data: homeProvider.pageList[index].description,
                          style: {
                            '#': Style(
                              color: const Color(0xff66788C),
                              fontSize: const FontSize(14),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Montserrat',
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero,
                            ),
                            'strong': Style(
                              color: const Color(0xff66788C),
                              fontSize: const FontSize(23),
                              fontWeight: FontWeight.w600,
                              margin: const EdgeInsets.only(bottom: 21),
                            ),
                          },
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    if (homeProvider.pageList[index].description2 != null)
                      Container(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                          bottom: 28,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DefaultTextStyle.merge(
                          style: const TextStyle(color: Color(0xff66788C)),
                          child: Html(
                            data: homeProvider.pageList[index].description2,
                            style: {
                              '#': Style(
                                color: const Color(0xff66788C),
                                fontSize: const FontSize(14),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Montserrat',
                                padding: EdgeInsets.zero,
                                margin: EdgeInsets.zero,
                              ),
                              'strong': Style(
                                color: const Color(0xff66788C),
                                fontSize: const FontSize(23),
                                fontWeight: FontWeight.w600,
                                margin: const EdgeInsets.only(bottom: 21),
                              ),
                              'li': Style(
                                fontSize: const FontSize(14),
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff66788C),
                                margin: const EdgeInsets.only(
                                  bottom: 8,
                                ),
                              ),
                            },
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    if (homeProvider.pageList[index].description3 != null)
                      Container(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                          bottom: 28,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Позиционирование',
                              style: TextStyle(
                                color: Color(0xff66788C),
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            const SizedBox(height: 21),
                            DefaultTextStyle.merge(
                              style: const TextStyle(color: Color(0xff66788C)),
                              child: Html(
                                data: homeProvider.pageList[index].description3!
                                    .replaceAll('Позиционирование', ''),
                                style: {
                                  '#': Style(
                                    color: const Color(0xff66788C),
                                    fontSize: const FontSize(14),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Montserrat',
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                  ),
                                  'p': Style(
                                    color: const Color(0xff66788C),
                                    fontSize: const FontSize(14),
                                    fontWeight: FontWeight.w400,
                                    margin: const EdgeInsets.only(bottom: 8),
                                  ),
                                  'li': Style(
                                    fontSize: const FontSize(14),
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff66788C),
                                    margin: const EdgeInsets.only(
                                      bottom: 8,
                                    ),
                                  ),
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 16),
                    if (homeProvider.pageList[index].description4 != null)
                      Container(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                          bottom: 28,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Html(
                          data: homeProvider.pageList[index].description4,
                          style: {
                            '#': Style(
                              color: const Color(0xff66788C),
                              fontSize: const FontSize(14),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Montserrat',
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero,
                            ),
                            'strong': Style(
                              color: const Color(0xff66788C),
                              fontSize: const FontSize(23),
                              fontWeight: FontWeight.w600,
                              margin: const EdgeInsets.only(bottom: 21),
                            ),
                            'p': Style(
                              color: const Color(0xff66788C),
                              fontSize: const FontSize(23),
                              fontWeight: FontWeight.w600,
                              margin: const EdgeInsets.only(bottom: 8),
                            ),
                          },
                        ),
                      ),
                    const SizedBox(height: 16),
                    if (homeProvider.pageList[index].description5 != null)
                      Container(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                          bottom: 28,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ценности и философия компании',
                              style: TextStyle(
                                color: Color(0xff66788C),
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Html(
                              data: homeProvider.pageList[index].description5!
                                  .replaceAll(
                                      'Ценности и философия компании', ''),
                              style: {
                                '#': Style(
                                  color: const Color(0xff66788C),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Montserrat',
                                  padding: EdgeInsets.zero,
                                  margin: const EdgeInsets.only(bottom: 8),
                                ),
                              },
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 16),
                    if (homeProvider.pageList[index].description6 != null)
                      Container(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                          bottom: 28,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Html(
                          data: homeProvider.pageList[index].description6,
                          style: {
                            '#': Style(
                              fontFamily: 'Montserrat',
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero,
                            ),
                            'h4': Style(
                              color: const Color(0xff66788C),
                              fontSize: const FontSize(23),
                              fontWeight: FontWeight.w600,
                              margin: const EdgeInsets.only(bottom: 21),
                            ),
                            'p': Style(
                              color: const Color(0xff66788C),
                              fontSize: const FontSize(14),
                              fontWeight: FontWeight.w400,
                            ),
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }
}

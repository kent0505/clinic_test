import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sadykova_app/core/compoents/appBar/custom_app_bar.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/utils/date_converter.dart';
import 'package:sadykova_app/core/utils/path_converter.dart';
import 'package:sadykova_app/features/auth/domain/state/user_provider.dart';
import 'package:sadykova_app/features/profile/domain/models/analize.dart';
import 'package:sadykova_app/features/profile/ui/screens/pdf_view_screen.dart';
import 'package:sadykova_app/features/profile/ui/widgets/date_modal_sheet.dart';

class DetailAnalisScreen extends StatefulWidget {
  const DetailAnalisScreen({
    Key? key,
    required this.analisModel,
  }) : super(key: key);

  final AnalisModel analisModel;

  @override
  State<DetailAnalisScreen> createState() => _DetailAnalisScreenState();
}

class _DetailAnalisScreenState extends State<DetailAnalisScreen> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: customAppBar(
        () {
          Navigator.pop(context);
        },
        title: Text(
          widget.analisModel.laboratory ?? '',
          style: const TextStyle(
            color: Color(0xff415164),
            fontSize: 17,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat-b',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(top: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   widget.analisModel.laboratory ?? '',
                        //   style: const TextStyle(
                        //     color: Color(0xff66788C),
                        //     fontSize: 27,
                        //     fontWeight: FontWeight.w700,
                        //     fontFamily: 'Montserrat-b',
                        //   ),
                        // ),
                        // const SizedBox(height: 4),
                        const Text(
                          "Готов результат",
                          style: TextStyle(
                            color: Color(0xff41B62E),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen: PdfViewScreen(
                                pdfPath: ImagePathConvertor.convertTopaht(
                                  path: widget.analisModel.path ?? '',
                                ),
                                tittle: widget.analisModel.laboratory ?? '',
                              ),
                            );
                          },
                          child: buildPDFCard(),
                        ),
                        const SizedBox(height: 22),
                        buildListOfItems(widget.analisModel),
                      ],
                    );
                  },
                  childCount: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListOfItems(AnalisModel model) {
    return Column(
      children: [
        buildMenuItem(
          "Дата и время забора:  ",
          DateConverter.convertStringToDate(model.analysisDate ?? ''),
        ),
        buildMenuItem(
          "Дата и время готовности:  ",
          DateConverter.convertStringToDate(model.readyDate ?? ''),
        ),
        buildMenuItem("Кто назначил:  ", model.name ?? ''),
        buildMenuItem("Лаборатория:  ", model.laboratory ?? ''),
      ],
    );
  }

  Widget buildMenuItem(String title, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xff66788C),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xff66788C),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPDFCard() {
    return Container(
      height: 80,
      width: 130,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            pdfBg,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: const Color(0xffE50052),
              ),
              child: const Padding(
                padding: EdgeInsets.all(3.0),
                child: Text(
                  "PDF",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Результат анализа",
                  style: TextStyle(
                    color: Color(0xff66788C),
                    fontSize: 10,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Text(
                  "1,5 мб", // надо указать реальный размер pdf файла
                  style: TextStyle(
                    color: const Color(0xff66788C).withOpacity(0.6),
                    fontSize: 10,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void openDateModal(UserProvider provider) async {
    var result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return const DateModalSheet();
      },
    );
    provider.changeFirsetInit();
    if (result != null) {
      provider.setSelectedCity(result.toString());
    }
  }
}

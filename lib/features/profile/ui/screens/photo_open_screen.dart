import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sadykova_app/core/compoents/appBar/custom_app_bar.dart';
import 'package:sadykova_app/core/compoents/loaders/loader.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/core/utils/path_converter.dart';
import 'package:sadykova_app/core/theme/colors.dart';

class PhotoOpenScreen extends StatefulWidget {
  final int initialIndex;
  final List<String?> photoModels;

  const PhotoOpenScreen({
    Key? key,
    required this.initialIndex,
    required this.photoModels,
  }) : super(key: key);

  @override
  State<PhotoOpenScreen> createState() => _PhotoOpenScreenState();
}

class _PhotoOpenScreenState extends State<PhotoOpenScreen> {
  final ScrollController scrollController = ScrollController();
  late int pageViewIndex;
  late PageController pageViewController;

  @override
  void initState() {
    super.initState();
    pageViewIndex = widget.initialIndex;
    pageViewController = PageController(initialPage: pageViewIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.only(bottom: 70, right: 12, left: 12),
        //   child: ElevatedFillButton(
        //     elevation: 1,
        //     height: 60,
        //     onTap: () {},
        //     title: 'Добавить фото',
        //     buttonColor: kWhiteColor,
        //     textColor: const Color(0xff66788C),
        //     // icon: addIcon,
        //   ),
        // ),
        backgroundColor: const Color(0xff373431),
        appBar: customAppBar(
          () {
            Navigator.pop(context);
          },
          title: Text(
            "${pageViewIndex + 1} из ${widget.photoModels.length}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          appBarHeight: 50,
          topPadding: 0,
          // actions: [
          //   IconButton(
          //     splashRadius: 20.0,
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.more_vert,
          //       color: kWhiteColor,
          //     ),
          //   ),
          // ],
          iconColor: kWhiteColor,
        ),
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: PageView(
              controller: pageViewController,
              onPageChanged: (value) {
                setState(() {
                  pageViewIndex = value;
                });
              },
              children: List.generate(
                widget.photoModels.length,
                (index) => pageViewItem(
                  widget.photoModels[index] ?? noIconLink,
                ),
              ),
            ),
          ),
        ));
  }

  Widget pageViewItem(String model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          imageUrl: ImagePathConvertor.convertTopaht(path: model),
          errorWidget: (context, url, error) => Container(),
          placeholder: (context, url) => const Center(
            child: Loader(),
          ),
        ),
      ],
    );
  }
}

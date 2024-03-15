import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sadykova_app/core/compoents/appBar/custom_app_bar.dart';
import 'package:sadykova_app/features/auth/domain/state/auth_provider.dart';
import 'package:sadykova_app/features/auth/ui/screens/loader_screen.dart';
import 'package:sadykova_app/features/profile/domain/models/analize.dart';
import 'package:sadykova_app/features/profile/ui/screens/detail_analis_screen.dart';
import 'package:sadykova_app/features/profile/ui/widgets/analis_menu_item.dart';

class AnalisResultScreen extends StatefulWidget {
  const AnalisResultScreen({Key? key}) : super(key: key);

  @override
  State<AnalisResultScreen> createState() => _AnalisResultScreenState();
}

class _AnalisResultScreenState extends State<AnalisResultScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.getAnalisList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.loading) {
      return const LoaderScreen();
    }

    return Scaffold(
      appBar: customAppBar(
        () {
          Navigator.pop(context);
        },
        title: const Text(
          "Результаты анализов",
          style: TextStyle(
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
              padding: const EdgeInsets.only(bottom: 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return buildListOfItems(
                      authProvider.analisList,
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

  Widget buildListOfItems(List<AnalisModel> analisModels) {
    return analisModels.isEmpty
        ? const Expanded(
            child: Center(
              child: Text('Нет элементов :('),
            ),
          )
        : Column(
            children: List.generate(
              analisModels.length,
              (index) => InkWell(
                onTap: () {
                  pushNewScreen(
                    context,
                    screen: DetailAnalisScreen(
                      analisModel: analisModels[index],
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: AnalisMenuItem(
                    model: analisModels[index],
                  ),
                ),
              ),
            ),
          );
  }

  // List<Widget> createPhotoList(
  //     List<PhotoModel> models, UserProvider userProvider) {
  //   List<Widget> newList = [];
  //   for (int index = 0; index < models.length; index++) {
  //     newList.add(
  //       InkWell(
  //         onTap: () {
  //           pushNewScreen(
  //             context,
  //             withNavBar: false,
  //             screen: PhotoOpenScreen(
  //               initialIndex: index,
  //               photoModels: userProvider.doctorDocs,
  //             ),
  //           );
  //         },
  //         child: CachedNetworkImage(
  //           imageUrl: models[index].photoPath,
  //           errorWidget: (context, url, error) => Container(),
  //           placeholder: (context, url) => const Center(
  //             child: Loader(),
  //           ),
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //     );
  //   }
  //   return newList;
  // }
}

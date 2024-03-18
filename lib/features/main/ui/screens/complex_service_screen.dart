import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadykova_app/core/compoents/appBar/custom_app_bar.dart';
import 'package:sadykova_app/core/compoents/loaders/loader_state.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/complex_service_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_modal_bottom.dart';
import 'package:sadykova_app/features/main/domain/state/home_provider.dart';
import 'package:sadykova_app/features/main/ui/widgets/all_events_screen/complex_card.dart';

class ComplexServiceScreen extends StatefulWidget {
  const ComplexServiceScreen({Key? key}) : super(key: key);

  @override
  State<ComplexServiceScreen> createState() => _ComplexServiceScreenState();
}

class _ComplexServiceScreenState extends State<ComplexServiceScreen> {
  final scrollController = ScrollController();
  final searchController = TextEditingController();

  int selectedID = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.getComplexService();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    if (homeProvider.loading) {
      return const LoaderState();
    }

    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(
          () {
            Navigator.pop(context);
          },
          title: const Text(
            "Комплексные программы",
            style: TextStyle(
              color: Color(0xff415164),
              fontSize: 17,
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat-b',
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.only(),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ComplexCard(
                          model: homeProvider.complexServiceModel[index],
                          onTap: () async {
                            selectedID =
                                homeProvider.complexServiceModel[index].id!;
                            var result = await homeProvider.getComplexDetail(
                              id: homeProvider.complexServiceModel[index].id!,
                            );

                            if (result != null) {
                              MainModalBottom.showSimpleModalBottom(
                                context: context,
                                body: ComplexServiceBody(model: result),
                              );
                            }
                          },
                          isLoading: selectedID ==
                                  homeProvider.complexServiceModel[index].id! &&
                              homeProvider.complexLoader,
                        );
                      },
                      childCount: homeProvider.complexServiceModel.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

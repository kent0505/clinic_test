import 'package:flutter/material.dart';
import 'package:sadykova_app/core/compoents/appBar/custom_app_bar.dart';
import 'package:sadykova_app/core/compoents/loaders/loader_state.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/equipment_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_modal_bottom.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/features/main/domain/state/home_provider.dart';
import 'package:sadykova_app/features/main/ui/widgets/equepment_card.dart';
import 'package:provider/provider.dart';

class EquepmentScreen extends StatefulWidget {
  const EquepmentScreen({Key? key}) : super(key: key);
  // final List<ServiceCard> listOfCard;

  @override
  State<EquepmentScreen> createState() => _EquepmentScreenState();
}

class _EquepmentScreenState extends State<EquepmentScreen> {
  final scrollController = ScrollController();
  final searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) {
        var homeProvider = Provider.of<HomeProvider>(context, listen: false);
        homeProvider.getEquipments();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);

    if (homeProvider.loading) {
      return const LoaderState();
    }

    return Scaffold(
      backgroundColor: kBgColor,
      appBar: customAppBar(
        () {
          Navigator.pop(context);
        },
        title: const Text(
          "Оборудование",
          style: TextStyle(
            color: Color(0xff66788C),
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
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return topInfo();
                  },
                  childCount: 1,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 25, bottom: 64),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 22,
                  childAspectRatio: 0.55,
                  children: createEquepment(homeProvider),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> createEquepment(HomeProvider homeProvider) {
    List<Widget> list = [];

    for (var element in homeProvider.equipmentModelList) {
      list.add(
        EquepmantCard(
          isLoading: homeProvider.equipmentLoader,
          model: element,
          onTapCard: () async {
            var result = await homeProvider.getEquipmentDetail(id: element.id!);
            if (result != null) {
              MainModalBottom.showSimpleModalBottom(
                isNeddPaddingBottom: false,
                context: context,
                body: EquipModalBody(
                  model: result,
                  onAcept: () {},
                ),
              );
            }
          },
        ),
      );
    }
    return list;
  }

  Widget topInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: 16),
        Text(
          "Оборудование клиники \nDr. Sadykova",
          style: TextStyle(
            color: Color(0xff66788C),
            fontSize: 27,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat-b',
          ),
        ),
        SizedBox(height: 16),
        Text(
          "Наша клиника закупает только ОРИГИНАЛЬНЫЕ аппараты – лучшие решения косметологической терапии для клиентов. Наши врачи проходят специальное обучение у поставщиков и представительств, чтобы максимально эффективно использовать все возможности имеющегося оборудования и оказывать услуги на уровне ведущих косметологических центров.",
          style: TextStyle(
            color: Color(0xff66788C),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: 'Montserrat',
          ),
        ),
      ],
    );
  }
}

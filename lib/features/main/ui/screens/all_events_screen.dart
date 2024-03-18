import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadykova_app/core/compoents/appBar/custom_app_bar.dart';
import 'package:sadykova_app/core/compoents/appBar/no_data_widget.dart';
import 'package:sadykova_app/core/compoents/loaders/loader.dart';
import 'package:sadykova_app/core/compoents/loaders/loader_state.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/action_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/event_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/news_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_modal_bottom.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/features/main/domain/models/contact_model.dart';
import 'package:sadykova_app/features/main/domain/state/home_provider.dart';
import 'package:sadykova_app/features/main/ui/widgets/all_events_screen/actions_card.dart';
import 'package:sadykova_app/features/main/ui/widgets/all_events_screen/event_cart.dart';
import 'package:sadykova_app/features/main/ui/widgets/all_events_screen/news_card.dart';

class AllEvents extends StatefulWidget {
  const AllEvents({Key? key}) : super(key: key);

  @override
  State<AllEvents> createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents>
    with SingleTickerProviderStateMixin {
  final scrollController = ScrollController();
  late TabController _tabController;
  int groupValue = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.getActions();
      homeProvider.getNews();
      homeProvider.getEvents();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    if (homeProvider.eventLoader) {
      return const LoaderState();
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: kBgColor,
        appBar: customAppBar(
          () {
            Navigator.pop(context);
          },
          title: const Text(
            "Новости и акции",
            style: TextStyle(
              color: Color(0xff415164),
              fontSize: 17,
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat-b',
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TabBar(
                  controller: _tabController,
                  padding: const EdgeInsets.all(3),
                  indicator: BoxDecoration(
                    color: const Color(0xffFAF9F4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelColor: const Color(0xff66788C).withOpacity(0.8),
                  labelStyle: TextStyle(
                    color: const Color(0xff66788C).withOpacity(0.8),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelColor:
                      const Color(0xff66788C).withOpacity(0.8),
                  unselectedLabelStyle: TextStyle(
                    color: const Color(0xff66788C).withOpacity(0.8),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Montserrat',
                  ),
                  tabs: const [
                    Tab(text: 'Акции'),
                    Tab(text: 'Новости'),
                    Tab(text: 'События'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  buildActionsCards(homeProvider: homeProvider),
                  buildNewsCards(homeProvider: homeProvider),
                  buildEventsCard(homeProvider: homeProvider)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActionsCards({required HomeProvider homeProvider}) {
    if (homeProvider.actionList.isEmpty) {
      return const NoDataWidget();
    }

    if (homeProvider.loading) {
      return const Center(
        child: Loader(),
      );
    }

    return RefreshIndicator(
      color: const Color(0xff66788C),
      onRefresh: () async {
        await homeProvider.getActions();
        await homeProvider.getNews();
        await homeProvider.getEvents();
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 58, top: 8, left: 16, right: 16),
        itemCount: homeProvider.actionList.length,
        itemBuilder: (context, index) {
          return CupertinoButton(
            padding: const EdgeInsets.symmetric(vertical: 8),
            onPressed: () {
              MainModalBottom.showSimpleModalBottom(
                context: context,
                body: ActionModalBody(
                  model: homeProvider.actionList[index],
                ),
              );
            },
            child: ActionCard(
              model: homeProvider.actionList[index],
            ),
          );
        },
      ),
    );
  }

  Widget buildNewsCards({required HomeProvider homeProvider}) {
    if (homeProvider.newsList.isEmpty) {
      return const NoDataWidget();
    }

    if (homeProvider.loading) {
      return const Center(
        child: Loader(),
      );
    }

    return RefreshIndicator(
      color: const Color(0xff66788C),
      onRefresh: () async {
        await homeProvider.getActions();
        await homeProvider.getNews();
        await homeProvider.getEvents();
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 58, top: 8, left: 16, right: 16),
        itemCount: homeProvider.newsList.length,
        itemBuilder: (context, index) {
          return CupertinoButton(
            padding: const EdgeInsets.symmetric(vertical: 8),
            onPressed: () {
              MainModalBottom.showSimpleModalBottom(
                context: context,
                body: NewsModalBody(
                  model: homeProvider.newsList[index],
                ),
              );
            },
            child: NewsCard(
              model: homeProvider.newsList[index],
            ),
          );
        },
      ),
    );
  }

  Widget buildEventsCard({required HomeProvider homeProvider}) {
    if (homeProvider.eventList.isEmpty) {
      return const NoDataWidget();
    }

    if (homeProvider.loading) {
      return const Center(
        child: Loader(),
      );
    }

    ContactMdel whatsApp = homeProvider.contactsList
        .firstWhere((element) => element.type == 'whatsapp');

    return RefreshIndicator(
      color: const Color(0xff66788C),
      onRefresh: () async {
        await homeProvider.getActions();
        await homeProvider.getNews();
        await homeProvider.getEvents();
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 58, top: 8, left: 16, right: 16),
        itemCount: homeProvider.eventList.length,
        itemBuilder: (context, index) {
          return CupertinoButton(
            padding: const EdgeInsets.symmetric(vertical: 8),
            onPressed: () {
              MainModalBottom.showSimpleModalBottom(
                context: context,
                body: EventModalBody(
                  model: homeProvider.eventList[index],
                  whatsApp: whatsApp,
                ),
              );
            },
            child: EventCard(
              model: homeProvider.eventList[index],
            ),
          );
        },
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadykova_app/core/compoents/loaders/loader_state.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/about_us_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/action_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/article_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/event_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/news_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_modal_bottom.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/features/auth/domain/state/user_provider.dart';
import 'package:sadykova_app/features/main/domain/models/action_model.dart';
import 'package:sadykova_app/features/main/domain/models/contact_model.dart';
import 'package:sadykova_app/features/main/domain/models/event_model.dart';
import 'package:sadykova_app/features/main/domain/models/news_model.dart';
import 'package:sadykova_app/features/main/domain/state/home_provider.dart';
import 'package:sadykova_app/features/main/ui/screens/all_events_screen.dart';
import 'package:sadykova_app/features/main/ui/screens/complex_service_screen.dart';
import 'package:sadykova_app/features/main/ui/screens/equirpment_screen.dart';
import 'package:sadykova_app/features/main/ui/screens/notification_screen.dart';
import 'package:sadykova_app/features/main/ui/widgets/main_screen/about_us_widget.dart';
import 'package:sadykova_app/features/main/ui/widgets/main_screen/article_list_widget.dart';
import 'package:sadykova_app/features/main/ui/widgets/main_screen/contact_widget.dart';
import 'package:sadykova_app/features/main/ui/widgets/main_screen/see_all_widget.dart';
import 'package:sadykova_app/features/main/ui/widgets/main_screen/slider_widget.dart';
import 'package:sadykova_app/features/main/ui/widgets/main_screen/top_widget.dart';
import 'package:sadykova_app/features/main/ui/widgets/city_select_modal.dart';
import 'package:sadykova_app/features/profile/ui/widgets/menu_widget.dart';
import 'package:sadykova_app/features/services/domain/state/service_provider.dart';
import 'package:sadykova_app/features/services/ui/screens/sub_group_screen.dart';
import 'package:sadykova_app/features/services/ui/widgets/group_service_card.dart';
import 'package:sadykova_app/navigation/main_swiper_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final scrollController = ScrollController();
  late PageController pageController;

  // late YandexMapController controller;
  // final completer = Completer<YandexMapController>();
  // final List<MapObject> mapObjectss = [];
  // late Point _point = const Point(latitude: 55.8304307, longitude: 49.0660806);
  // final animation = const MapAnimation(
  //   type: MapAnimationType.smooth,
  //   duration: 1.0,
  // );
  // final MapObjectId placemarkId = const MapObjectId('normal_icon_placemark');

  int groupValue = 0;
  ContactMdel? whatsApp;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) {
        final serviceProvider =
            Provider.of<ServiceProvider>(context, listen: false);
        final homeProvider = Provider.of<HomeProvider>(context, listen: false);
        final _userProvider = Provider.of<UserProvider>(context, listen: false);

        if (_userProvider.isFirstInit) {
          WidgetsBinding.instance!.addPostFrameCallback(
            (timeStamp) {
              openCityModal(_userProvider);
            },
          );
        }
        try {
          whatsApp = homeProvider.contactsList.firstWhere(
            (element) => element.type == 'whatsapp',
          );
        } catch (error) {
          log("error $error");
        }

        homeProvider.getContacts().then((value) {
          // createMapObjects(homeProvider);
        });
        homeProvider.getArticles();
        homeProvider.getTopEvents();
        serviceProvider.getGroupList();
      },
    );
  }

  // void createMapObjects(HomeProvider homeProvider) {
  //   ContactMdel adress = homeProvider.contactsList.firstWhere(
  //     (element) => element.type == 'address',
  //   );
  //   List<String> pointList = adress.map!.split(",");
  //   if (pointList.isNotEmpty) {
  //     _point = Point(
  //       latitude: double.parse(pointList[0]),
  //       longitude: double.parse(pointList[1]),
  //     );
  //   }
  //   final placemark = PlacemarkMapObject(
  //     mapId: placemarkId,
  //     point: _point,
  //     // point: Point(latitude: item.lon, longitude: item.lat),
  //     onTap: (PlacemarkMapObject self, Point point) {
  //       setState(() {});
  //     },
  //     opacity: 1,
  //     icon: PlacemarkIcon.single(
  //       PlacemarkIconStyle(
  //         image: BitmapDescriptor.fromAssetImage(mapIconPath),
  //         rotationType: RotationType.rotate,
  //         scale: 0.4,
  //       ),
  //     ),
  //   );
  //   mapObjectss.add(placemark);
  // }

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);
    final swiperProvider = Provider.of<MainSwiperProvider>(context);

    if (serviceProvider.loading || homeProvider.loading) {
      return const LoaderState();
    }

    return Scaffold(
      body: RefreshIndicator(
        color: const Color(0xff66788C),
        onRefresh: () async {
          await homeProvider.getArticles();
          await homeProvider.getTopEvents();
          await serviceProvider.getGroupList();
        },
        child: ListView(
          children: [
            TopScreenWidget(
              notificationList: homeProvider.notificationModels,
              onTapNotification: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return NotificationScreen(
                        notifications: homeProvider.notificationModels,
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            SeeAllWidget(
              mainText: "Новости и акции",
              onTapAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return const AllEvents();
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 11),
            SliderListWidget(
              topEvents: homeProvider.topEventList,
              onTapSlider: (int index) {
                if (homeProvider.topEventList[index] is ActionsModel) {
                  MainModalBottom.showSimpleModalBottom(
                    context: context,
                    body: ActionModalBody(
                      model: homeProvider.topEventList[index] as ActionsModel,
                    ),
                  );
                }

                if (homeProvider.topEventList[index] is NewsModel) {
                  MainModalBottom.showSimpleModalBottom(
                    context: context,
                    body: NewsModalBody(
                      model: homeProvider.topEventList[index] as NewsModel,
                    ),
                  );
                }

                if (homeProvider.topEventList[index] is EventModel) {
                  MainModalBottom.showSimpleModalBottom(
                    context: context,
                    body: EventModalBody(
                      model: homeProvider.topEventList[index] as EventModel,
                      whatsApp: whatsApp,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 32),
            SeeAllWidget(
              mainText: "Услуги и цены",
              onTapAll: () {
                swiperProvider.swithBottomNavBar(2);
              },
            ),
            const SizedBox(height: 11),
            GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: List.generate(
                serviceProvider.groupServices.length > 6
                    ? 6
                    : serviceProvider.groupServices.length,
                (index) {
                  return GroupServiceCard(
                    model: serviceProvider.groupServices[index],
                    onCardTap: () {
                      serviceProvider.groupId =
                          serviceProvider.groupServices[index].id!;

                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return const SubGroupScreen(
                              fromAppointment: false,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            AboutUsWidget(
              text: "О нас",
              onTap: () {
                MainModalBottom.showSimpleModalBottom(
                  context: context,
                  body: const AboutUsModalBody(),
                );
              },
            ),
            const SizedBox(height: 32),
            SeeAllWidget(
              mainText: "Полезная информация",
              onTapAll: () {},
              showAll: false,
            ),
            const SizedBox(height: 16),
            ArticleListWidget(
              listOfArticle: homeProvider.articleList,
              onTap: (index) {
                MainModalBottom.showSimpleModalBottom(
                  context: context,
                  body: ArticleModalBody(
                    model: homeProvider.articleList[index],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: MenuWidget(
                        showCount: false,
                        icon: newEquipmentIcon,
                        count: 2,
                        title: "Наше \nоборудование",
                        subtitle: 'Узнайте какие аппараты использует клиника ',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const EquepmentScreen();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: MenuWidget(
                        showCount: false,
                        icon: complexServiceIcon,
                        count: 2,
                        title: "Комплексные \nуслуги",
                        subtitle: 'Выгодные \nпредложения',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const ComplexServiceScreen();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (homeProvider.contactsList.isNotEmpty) ...[
              const SizedBox(height: 32),
              SeeAllWidget(
                mainText: "Контакты",
                onTapAll: () {},
                showAll: false,
              ),
              const SizedBox(height: 16),
              ContactsWidget(
                contactModel: homeProvider.contactsList,
                mapWidget: Column(
                  children: const [
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: 200,
                    //   child: YandexMap(
                    //     zoomGesturesEnabled: true,
                    //     mapObjects: mapObjectss,
                    //     onMapCreated: (controller) async {
                    //       completer.complete(controller);

                    //       await controller.moveCamera(
                    //         CameraUpdate.newCameraPosition(
                    //           CameraPosition(target: _point),
                    //         ),
                    //         animation: animation,
                    //       );
                    //       // await controller.move(point: _point, zoom: kDefaultZoomFactor);
                    //     },
                    //   ),
                    // ),
                    // ButtonWithText(
                    //   text: "Проложить маршрут",
                    //   onTap: () {},
                    //   fontSize: 14,
                    // ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 66),
          ],
        ),
      ),
    );
  }

  void openCityModal(UserProvider provider) async {
    var result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return const CitySelectModal();
      },
    );
    provider.changeFirsetInit();
    if (result != null) {
      provider.setSelectedCity(result.toString());
    }
  }
}

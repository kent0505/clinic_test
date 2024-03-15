import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sadykova_app/core/compoents/loaders/loader_state.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/service_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/webview_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_modal_bottom.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/web_view_modal_bottom.dart';
import 'package:sadykova_app/core/compoents/text_fields/search_text_field.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/theme/text_styles.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/features/services/domain/state/service_provider.dart';
import 'package:sadykova_app/features/services/ui/screens/sub_group_screen.dart';
import 'package:sadykova_app/features/services/ui/widgets/group_service_card.dart';
import 'package:sadykova_app/features/services/ui/widgets/service_with_price.dart';
import 'package:sadykova_app/features/staffs/domain/state/staff_provider.dart';

class GroupServicesScreen extends StatefulWidget {
  const GroupServicesScreen({Key? key}) : super(key: key);

  @override
  State<GroupServicesScreen> createState() => _GroupServicesScreenState();
}

class _GroupServicesScreenState extends State<GroupServicesScreen> {
  final scrollController = ScrollController();
  final searchController = TextEditingController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      var staffProvider = Provider.of<ServiceProvider>(context, listen: false);
      staffProvider.getGroupList();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final staffProvider = Provider.of<StaffProvider>(context);

    if (serviceProvider.loading) {
      return const LoaderState();
    }

    return Scaffold(
      backgroundColor: kBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(darkLogo),
                        ],
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Услуги и цены",
                            style: mainBoldTextStyle.copyWith(
                              color: kGreyScale900Color,
                              fontSize: 27,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Montserrat-b',
                            ),
                          ),
                        ],
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return SearchTextField(
                        controller: searchController,
                        onChanged: (String value) {
                          _debounce = Timer(
                            const Duration(milliseconds: 500),
                            () {
                              if (value.isNotEmpty) {
                                serviceProvider.searchServiceByText(
                                  text: value,
                                );
                              } else {
                                serviceProvider.searchServiceList = [];
                              }
                            },
                          );

                          // serviceProvider.filterGroupService(filter: value);
                        },
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ),
              if (searchController.text.isEmpty)
                SliverPadding(
                  padding: const EdgeInsets.only(top: 25, bottom: 70),
                  sliver: SliverGrid.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: List.generate(
                      serviceProvider.groupServices.length,
                      (index) => GroupServiceCard(
                        model: serviceProvider.groupServices[index],
                        onCardTap: () {
                          serviceProvider.groupId =
                              serviceProvider.groupServices[index].id!;

                          pushNewScreen(
                            context,
                            screen: const SubGroupScreen(
                              fromAppointment: false,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 70),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return listOfService(
                          serviceProvider: serviceProvider,
                          staffProvider: staffProvider,
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ),
              if (serviceProvider.groupServices.isEmpty &&
                      searchController.text.isEmpty ||
                  searchController.text.isNotEmpty &&
                      serviceProvider.searchServiceList.isEmpty)
                const SliverToBoxAdapter(
                    child: Center(
                  child: Text(
                    'Результаты не найдены :(',
                  ),
                )),
            ],
          ),
        ),
      ),
    );
  }

  Widget listOfService(
      {required ServiceProvider serviceProvider,
      required StaffProvider staffProvider}) {
    return Column(
      children: List.generate(
        serviceProvider.searchServiceList.length,
        (index) => InkWell(
          onTap: () async {
            var result = await serviceProvider.getServiceDetailInfo(
              serviceId: serviceProvider.searchServiceList[index].id!,
            );
            if (result) {
              MainModalBottom.showSimpleModalBottom(
                context: context,
                isNeddPaddingBottom: false,
                body: ServiceModalBody(
                  model: serviceProvider.selectService,
                  advantages: serviceProvider.advantageList,
                  onAccept: (BuildContext newContext) {
                    staffProvider.creteOrderBySttaffAndId(serviceIds: [
                      serviceProvider.searchServiceList[index].yclientsId!
                    ]).then(
                      (value) async {
                        if (staffProvider.orderLink.isNotEmpty) {
                          WebViewModalBotom.showSimpleModalBottom(
                            isNeddPaddingBottom: false,
                            expanded: true,
                            backGroundColor: kWhiteColor,
                            context: newContext,
                            body: WebViewModalBody(
                              url: staffProvider.orderLink,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              );
            }
          },
          child: ServiceCardWithPrice(
            isSelected: false,
            serviceModel: serviceProvider.searchServiceList[index],
          ),
        ),
      ),
    );
  }
}

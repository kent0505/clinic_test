import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sadykova_app/core/compoents/appBar/custom_app_bar.dart';
import 'package:sadykova_app/core/compoents/loaders/loader_state.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/theme/text_styles.dart';
import 'package:sadykova_app/features/services/domain/state/service_provider.dart';
import 'package:sadykova_app/features/services/ui/screens/services_screen.dart';
import 'package:sadykova_app/features/services/ui/widgets/sub_group_service_menu_item.dart';

class SubGroupScreen extends StatefulWidget {
  const SubGroupScreen({
    Key? key,
    required this.fromAppointment,
  }) : super(key: key);

  final bool fromAppointment;

  @override
  State<SubGroupScreen> createState() => _SubGroupScreenState();
}

class _SubGroupScreenState extends State<SubGroupScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) {
        var staffProvider =
            Provider.of<ServiceProvider>(context, listen: false);
        staffProvider.getSubGroupById();
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var serviceProvider = Provider.of<ServiceProvider>(context);
    var groupService = serviceProvider.getSelectedGroupModel();

    return Scaffold(
      backgroundColor: kBgColor,
      appBar: customAppBar(
        () {
          Navigator.pop(context);
        },
        title: Text(
          groupService.name ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: mainBoldTextStyle.copyWith(
            color: const Color(0xff415164),
            fontSize: 17,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat-b',
          ),
        ),
      ),
      body: serviceProvider.loading
          ? const LoaderState()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 66, top: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return listOfSubGroups(
                            serviceProvider: serviceProvider,
                          );
                        },
                        childCount: 1,
                      ),
                    ),
                  ),
                  if (serviceProvider.subGroupService.isEmpty)
                    const SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'Нет элементов :(',
                          style: TextStyle(
                            color: Color(0xff66788C),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Widget listOfSubGroups({required ServiceProvider serviceProvider}) {
    return Column(
      children: List.generate(
        serviceProvider.subGroupService.length,
        (index) => CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            serviceProvider.subGroupId =
                serviceProvider.subGroupService[index].id!;

            pushNewScreen(
              context,
              screen: const ServicesScreen(),
            );

            // if (!widget.fromAppointment) {
            //   openServiceBottom(models[index]);
            // } else {
            //   pushNewScreen(
            //     context,
            //     screen: SelectServicePriceScreen(
            //       serviceModel: models[index],
            //     ),
            //   );
            // }
          },
          child: SubGroupServiceMenuItem(
            service: serviceProvider.subGroupService[index],
          ),
        ),
      ),
    );
  }
}

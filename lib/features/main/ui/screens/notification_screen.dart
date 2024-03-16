import 'package:flutter/material.dart';
import 'package:sadykova_app/core/compoents/appBar/custom_app_bar.dart';
import 'package:sadykova_app/core/compoents/appBar/no_data_widget.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/theme/text_styles.dart';
import 'package:sadykova_app/features/auth/domain/state/user_provider.dart';
import 'package:sadykova_app/features/main/domain/models/notifications_model.dart';
import 'package:sadykova_app/features/main/ui/widgets/notification_menu_item.dart';
import 'package:sadykova_app/features/profile/ui/widgets/date_modal_sheet.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    Key? key,
    required this.notifications,
  }) : super(key: key);

  final List<NotificationsModels> notifications;
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        () {
          Navigator.pop(context);
        },
        title: Text(
          "Уведомления",
          style: mainBoldTextStyle.copyWith(
            color: const Color(0xff415164),
            fontSize: 17,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat-b',
          ),
        ),
      ),
      body: widget.notifications.isEmpty
          ? const NoDataWidget()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: widget.notifications.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        if (widget.notifications[index].isNew)
                          Positioned(
                            top: 6,
                            left: 6,
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: kPrimaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: NotificationMenuItem(
                            model: widget.notifications[index],
                            iconBgColor: kGreyScale500Color,
                            showDate: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      // body:  CustomScrollView(
      //   controller: scrollController,
      //   slivers: [
      //     if (widget.notifications.isEmpty)
      //       const SliverToBoxAdapter(
      //         child: Center(
      //           child: Text(
      //             'У вас пока нет уведомлений',
      //             style: TextStyle(
      //               color: Color(0xff66788C),
      //               fontSize: 14,
      //               fontWeight: FontWeight.w600,
      //             ),
      //           ),
      //         ),
      //       ),
      //     SliverPadding(
      //       padding: const EdgeInsets.only(
      //         top: 16,
      //         right: 16,
      //         left: 16,
      //       ),
      //       sliver: SliverList(
      //         delegate: SliverChildBuilderDelegate(
      //           (BuildContext context, int index) {
      //             return buildListOfItems();
      //           },
      //           childCount: 1,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget buildListOfItems() {
    return Column(
      children: List.generate(
        widget.notifications.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                if (widget.notifications[index].isNew)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: kPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: NotificationMenuItem(
                    model: widget.notifications[index],
                    iconBgColor: kGreyScale500Color,
                    showDate: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///

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

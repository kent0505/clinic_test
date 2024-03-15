import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/features/main/domain/models/notifications_model.dart';
import 'package:sadykova_app/features/main/domain/state/home_provider.dart';
import 'package:sadykova_app/features/main/ui/widgets/close_widget.dart';
import 'package:sadykova_app/features/main/ui/widgets/notification_menu_item.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({
    Key? key,
    required this.models,
  }) : super(key: key);

  final List<NotificationsModels> models;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff433812).withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 17,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          right: 7,
          left: 12,
          bottom: 18,
          top: 7,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Text(
                      "Важные уведомления",
                      style: TextStyle(
                        color: const Color(0xff66788C).withOpacity(0.6),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  widget.models.isNotEmpty
                      ? Column(
                          children: List.generate(
                            widget.models.length,
                            (index) => NotificationMenuItem(
                              model: widget.models[index],
                            ),
                          ),
                        )
                      : const Text(
                          'У вас нет уведомлений',
                          style: TextStyle(
                            color: Color(0xff66788C),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ],
              ),
            ),
            CloseWidget(
              onTap: () {
                homeProvider.closeNotification();
              },
            )
          ],
        ),
      ),
    );
  }
}

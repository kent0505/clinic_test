import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sadykova_app/core/compoents/image/oval_avatar.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/features/main/domain/models/notifications_model.dart';

class NotificationMenuItem extends StatelessWidget {
  const NotificationMenuItem({
    Key? key,
    required this.model,
    this.iconBgColor = kWhiteColor,
    this.showDate = false,
  }) : super(key: key);

  final NotificationsModels model;
  final Color iconBgColor;
  final bool showDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        model.notificationType == "doctor"
            ? OvalAvatar(imgPath: model.photo!)
            : Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xff66788C).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    fileIcon,
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
        const SizedBox(width: 16),
        Expanded(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: const TextStyle(
                    color: Color(0xff66788C),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  child: Text(
                    model.message,
                    style: const TextStyle(
                      color: Color(0xff66788C),
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // const Spacer(),
        const SizedBox(width: 16),
        if (showDate)
          Text(
            model.date,
            style: const TextStyle(
              color: Color(0xff66788C),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: 'Montserrat',
            ),
          ),
      ],
    );
  }
}

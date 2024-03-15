import 'package:flutter/cupertino.dart';
import 'package:sadykova_app/core/compoents/image/oval_avatar.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/utils/path_converter.dart';
import 'package:sadykova_app/features/services/domain/models/group_service_model.dart';

class GroupServiceCard extends StatelessWidget {
  const GroupServiceCard({
    Key? key,
    required this.model,
    required this.onCardTap,
  }) : super(key: key);

  final GroupServiceModel model;
  final Function() onCardTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onCardTap,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Column(
            children: [
              const SizedBox(height: 10),
              OvalAvatar(
                height: 60,
                width: 60,
                imgPath: ImagePathConvertor.convertTopaht(
                  path: model.path ?? '',
                ),
              ),
              const Spacer(),
              Text(
                model.name ?? '',
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xff66788C),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

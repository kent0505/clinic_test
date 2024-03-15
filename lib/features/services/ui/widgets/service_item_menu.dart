import 'package:flutter/material.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/theme/text_styles.dart';
import 'package:sadykova_app/features/services/domain/models/service_model.dart';

class SubServiceMenuItem extends StatelessWidget {
  final ServiceModel service;
  const SubServiceMenuItem({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        width: double.infinity,
        // height: 54,
        decoration: BoxDecoration(
            color: kWhiteColor, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(right: 12, left: 12, bottom: 16, top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  
                  service.name??'',
                  style: mainMediumTexttStyle.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: kGreyScale900Color),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 17,
                color: kGreyScale600Color,
              )
            ],
          ),
        ),
      ),
    );
  }
}

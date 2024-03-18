import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sadykova_app/core/compoents/loaders/loader.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/core/utils/path_converter.dart';
import 'package:sadykova_app/features/staffs/domain/models/staff_model.dart.dart';

class StaffCard extends StatelessWidget {
  const StaffCard({
    Key? key,
    required this.model,
    required this.onTapStaff,
  }) : super(key: key);

  final StaffModel model;
  final Function() onTapStaff;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.45;

    return InkWell(
      onTap: onTapStaff,
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                if (model.path != null && model.path!.isNotEmpty) ...[
                  CachedNetworkImage(
                    imageUrl: ImagePathConvertor.convertTopaht(
                      path: model.path ?? '',
                    ),
                    placeholder: (context, url) => const Center(
                      child: Loader(),
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      width: width,
                      height: width * 1.22,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imageProvider,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    errorWidget: (context, string, error) {
                      return Container(
                        width: width,
                        height: width * 1.22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(doctorPlaceHolder),
                          ),
                        ),
                      );
                    },
                  )
                ] else ...[
                  Container(
                    width: width,
                    height: width * 1.22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(doctorPlaceHolder),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Color(0xff66788C),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  model.position ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xff66788C),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

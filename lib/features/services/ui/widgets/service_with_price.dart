import 'package:flutter/material.dart';
import 'package:sadykova_app/features/services/domain/models/service_model.dart';

class ServiceCardWithPrice extends StatelessWidget {
  const ServiceCardWithPrice({
    Key? key,
    required this.isSelected,
    required this.serviceModel,
    this.isComplexService = false,
  }) : super(key: key);

  final bool isSelected;
  final ServiceModel serviceModel;
  final bool isComplexService;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: isSelected ? 12 : 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  serviceModel.name!,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xff66788C),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Container(
                    //   width: 32,
                    //   height: 32,
                    //   decoration: BoxDecoration(
                    //       color: isSelected ? kWhiteColor : kPrimaryColor,
                    //       shape: BoxShape.circle,
                    //       border: Border.all(
                    //           color: isSelected
                    //               ? kGreyScale900Color
                    //               : kPrimaryColor)),
                    //   child: CupertinoButton(
                    //     padding: EdgeInsets.zero,
                    //     onPressed: () {
                    //       if (isSelected) {
                    //         appointmentProvider.removeService(serviceModel);
                    //       } else {
                    //         appointmentProvider.addMiniService(serviceModel);
                    //         appointmentProvider
                    //             .selectSubService(serviceModel);
                    //       }
                    //     },
                    //     child: isSelected
                    //         ? const Icon(
                    //             Icons.remove,
                    //             color: kGreyScale900Color,
                    //           )
                    //         : const Icon(
                    //             Icons.add,
                    //             color: kGreyScale900Color,
                    //           ),
                    //   ),
                    // ),
                    // const SizedBox(width: 12),
                    isComplexService
                        ? Text(
                            '${serviceModel.totalPrice} ₽',
                            style: const TextStyle(
                              color: Color(0xff66788C),
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Text(
                            '${serviceModel.price} ₽',
                            style: const TextStyle(
                              color: Color(0xff66788C),
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    const Spacer(),
                    if (serviceModel.duration != null)
                      Text(
                        serviceModel.duration!,
                        style: const TextStyle(
                          color: Color(0xff66788C),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

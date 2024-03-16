import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadykova_app/core/compoents/appBar/custom_app_bar.dart';
import 'package:sadykova_app/core/compoents/appBar/no_data_widget.dart';
import 'package:sadykova_app/core/compoents/loaders/loader.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/service_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/webview_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_modal_bottom.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/web_view_modal_bottom.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/features/appointment/domain/state/appointment_provider.dart';
import 'package:sadykova_app/features/services/domain/state/service_provider.dart';
import 'package:sadykova_app/features/services/ui/widgets/service_with_price.dart';
import 'package:sadykova_app/features/staffs/domain/state/staff_provider.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) {
        final staffProvider =
            Provider.of<ServiceProvider>(context, listen: false);
        staffProvider.getServiceById();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appointmemtProvider = Provider.of<AppointmemtProvider>(context);
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final staffProvider = Provider.of<StaffProvider>(context);
    final subGroup = serviceProvider.getSelectSubGroupModel();

    return Scaffold(
      appBar: customAppBar(
        () {
          Navigator.pop(context);
        },
        title: Text(
          subGroup.name!,
          style: const TextStyle(
            color: Color(0xff415164),
            fontSize: 17,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat-b',
          ),
        ),
      ),
      body: serviceProvider.loading
          ? const Center(
              child: Loader(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: serviceProvider.serviceList.isEmpty
                  ? const NoDataWidget()
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 66),
                      itemCount: serviceProvider.serviceList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: InkWell(
                            onTap: () async {
                              await serviceProvider.getServiceDetailInfo(
                                serviceId:
                                    serviceProvider.serviceList[index].id!,
                              );
                              // if (result) {

                              // }
                              MainModalBottom.showSimpleModalBottom(
                                context: context,
                                isNeddPaddingBottom: false,
                                body: ServiceModalBody(
                                  model: serviceProvider.selectService,
                                  advantages: serviceProvider.advantageList,
                                  onAccept: (BuildContext newContext) {
                                    staffProvider.creteOrderBySttaffAndId(
                                      serviceIds: [
                                        serviceProvider
                                            .serviceList[index].yclientsId!
                                      ],
                                    ).then(
                                      (value) async {
                                        if (staffProvider
                                            .orderLink.isNotEmpty) {
                                          WebViewModalBotom
                                              .showSimpleModalBottom(
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
                            },
                            child: ServiceCardWithPrice(
                              isSelected:
                                  appointmemtProvider.seletServices.contains(
                                serviceProvider.serviceList[index],
                              ),
                              serviceModel: serviceProvider.serviceList[index],
                            ),
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}

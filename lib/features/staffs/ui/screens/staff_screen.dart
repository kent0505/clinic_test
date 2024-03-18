import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sadykova_app/core/compoents/loaders/loader.dart';
import 'package:sadykova_app/core/compoents/loaders/loader_state.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/staff_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/webview_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_modal_bottom.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/web_view_modal_bottom.dart';
import 'package:sadykova_app/core/compoents/text_fields/search_text_field.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/features/staffs/domain/models/staff_model.dart.dart';
import 'package:sadykova_app/features/staffs/domain/state/staff_provider.dart';
import 'package:sadykova_app/features/staffs/ui/screens/staff_category_screen.dart';
import 'package:sadykova_app/features/staffs/ui/widgets/staff_card.dart';
import 'package:sadykova_app/features/staffs/ui/widgets/staff_type_container.dart';

class StaffsScreen extends StatefulWidget {
  const StaffsScreen({Key? key}) : super(key: key);

  @override
  State<StaffsScreen> createState() => _StaffsScreenState();
}

class _StaffsScreenState extends State<StaffsScreen> {
  final scrollController = ScrollController();
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      var staffProvider = Provider.of<StaffProvider>(context, listen: false);
      staffProvider.getListOfStaffGroups();
      staffProvider.getStaffList();
    });
  }

  List<Widget> createStaffs(
    List<StaffModel> staffList,
    StaffProvider staffProvider,
  ) {
    List<Widget> list = [];
    for (var element in staffList.reversed) {
      list.add(StaffCard(
        model: element,
        onTapStaff: () {
          onSelectStaff(staffProvider, context, element);
        },
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final staffProvider = Provider.of<StaffProvider>(context);

    if (staffProvider.loading) {
      return const LoaderState();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: staffProvider.filteredStaffList.isEmpty
            ? const Center(child: Loader())
            : RefreshIndicator(
                color: const Color(0xff66788C),
                onRefresh: () async {
                  await staffProvider.getListOfStaffGroups();
                  await staffProvider.getStaffList();
                },
                child: ListView(
                  children: [
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        SvgPicture.asset(darkLogo),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Направления \nи специалисты",
                      style: TextStyle(
                        color: Color(0xff66788C),
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat-b',
                      ),
                    ),
                    const SizedBox(height: 14),
                    SearchTextField(
                      controller: searchController,
                      onChanged: (String value) {
                        staffProvider.filterStaff(filter: value);
                      },
                    ),
                    const SizedBox(height: 20),
                    filterCategoryWidget(staffProvider),
                    const SizedBox(height: 32),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.6,
                      children: createStaffs(
                        staffProvider.filteredStaffList,
                        staffProvider,
                      ),
                    ),
                    const SizedBox(height: 66),
                  ],
                ),
              ),
      ),
    );
  }

  Widget filterCategoryWidget(StaffProvider staffProvider) {
    return Wrap(
      spacing: 5,
      runSpacing: 3,
      children: List.generate(staffProvider.staffGroupList.length, (index) {
        return StaffTypeContainer(
          text: staffProvider.staffGroupList[index].name ?? 'Без названия',
          onTap: () {
            staffProvider.groupId = staffProvider.staffGroupList[index].id!;
            staffProvider.getStaffListById();
            pushNewScreen(
              context,
              withNavBar: true,
              screen: StaffCategory(
                staffGrouModel: staffProvider.staffGroupList[index],
              ),
            );
          },
        );
      }),
    );
  }

  Future<void> onSelectStaff(
    StaffProvider staffProvider,
    BuildContext context,
    StaffModel model,
  ) async {
    staffProvider.selectedStaffModel = model;
    var result = await staffProvider.getDetailStaff(staffID: model.id!);

    if (result) {
      MainModalBottom.showSimpleModalBottom(
        isNeddPaddingBottom: false,
        context: context,
        body: StaffModalBody(
          model: staffProvider.selectedStaffModel!,
          onAcept: (contextView) async {
            staffProvider
                .creteOrderBySttaffAndId(staffId: model.yClientsID)
                .then(
              (value) async {
                if (staffProvider.orderLink.isNotEmpty) {
                  WebViewModalBotom.showSimpleModalBottom(
                    isNeddPaddingBottom: false,
                    expanded: true,
                    backGroundColor: kWhiteColor,
                    context: contextView,
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
  }
}

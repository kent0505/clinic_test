import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadykova_app/core/compoents/appBar/custom_app_bar.dart';
import 'package:sadykova_app/core/compoents/appBar/no_data_widget.dart';
import 'package:sadykova_app/core/compoents/loaders/loader_state.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/body_components/staff_modal_body.dart';
import 'package:sadykova_app/core/compoents/modal_bottoms/main_modal_bottom.dart';
import 'package:sadykova_app/features/staffs/domain/models/staff_group_model.dart';
import 'package:sadykova_app/features/staffs/domain/models/staff_model.dart.dart';
import 'package:sadykova_app/features/staffs/domain/state/staff_provider.dart';
import 'package:sadykova_app/features/staffs/ui/widgets/staff_card.dart';

class StaffCategory extends StatefulWidget {
  const StaffCategory({
    Key? key,
    required this.staffGrouModel,
  }) : super(key: key);

  final StaffGroupModel staffGrouModel;

  @override
  State<StaffCategory> createState() => _StaffCategoryState();
}

class _StaffCategoryState extends State<StaffCategory> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      var staffProvider = Provider.of<StaffProvider>(context, listen: false);
      staffProvider.getStaffListById();
    });
  }

  @override
  Widget build(BuildContext context) {
    final staffProvider = Provider.of<StaffProvider>(context);

    if (staffProvider.loading2) {
      return const LoaderState();
    }

    return Scaffold(
      appBar: customAppBar(
        () {
          Navigator.pop(context);
        },
        title: Text(
          widget.staffGrouModel.name ?? '',
          style: const TextStyle(
            color: Color(0xff415164),
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!staffProvider.loading2 &&
              staffProvider.staffListById.isEmpty) ...[
            const NoDataWidget()
          ] else ...[
            Expanded(
              child: GridView.count(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                  bottom: 66,
                ),
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.6,
                children: createStaffs(staffProvider),
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> createStaffs(StaffProvider staffProvider) {
    List<Widget> list = [];
    for (var element in staffProvider.staffListById) {
      list.add(
        StaffCard(
          model: element,
          onTapStaff: () {
            onSelectStaff(staffProvider, context, element);
          },
        ),
      );
    }
    return list;
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
                  Navigator.pop(context, true);
                }
              },
            );
          },
        ),
      );
    }
  }
}

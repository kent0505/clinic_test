import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadykova_app/core/compoents/appBar/custom_app_bar.dart';
import 'package:sadykova_app/core/compoents/appBar/no_data_widget.dart';
import 'package:sadykova_app/features/auth/domain/state/auth_provider.dart';
import 'package:sadykova_app/features/auth/domain/state/user_provider.dart';
import 'package:sadykova_app/features/auth/ui/screens/loader_screen.dart';
import 'package:sadykova_app/features/profile/ui/widgets/date_modal_sheet.dart';
import 'package:sadykova_app/features/profile/ui/widgets/record_card.dart';

class HistoryRecordScreen extends StatefulWidget {
  const HistoryRecordScreen({Key? key}) : super(key: key);

  @override
  State<HistoryRecordScreen> createState() => _HistoryRecordScreenState();
}

class _HistoryRecordScreenState extends State<HistoryRecordScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.getOldREcordModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.loading) {
      return const LoaderScreen();
    }

    return Scaffold(
      appBar: customAppBar(
        () {
          Navigator.pop(context);
        },
        title: const Text(
          "История записей",
          style: TextStyle(
            color: Color(0xff415164),
            fontSize: 17,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat-b',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: authProvider.orldRecordModel.isEmpty
            ? const NoDataWidget()
            : ListView.builder(
                itemCount: authProvider.orldRecordModel.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: RecordCard(
                        model: authProvider.orldRecordModel[index],
                        isCurrent: false,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

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

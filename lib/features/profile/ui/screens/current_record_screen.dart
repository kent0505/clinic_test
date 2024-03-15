import 'package:flutter/material.dart';
import 'package:sadykova_app/core/compoents/appBar/custom_app_bar.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/features/auth/domain/state/auth_provider.dart';
import 'package:sadykova_app/features/auth/domain/state/user_provider.dart';
import 'package:sadykova_app/features/auth/ui/screens/loader_screen.dart';
import 'package:sadykova_app/features/profile/domain/models/record_model.dart';
import 'package:sadykova_app/features/profile/ui/widgets/date_modal_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sadykova_app/features/profile/ui/widgets/record_card.dart';

class CurrentRecordScreen extends StatefulWidget {
  const CurrentRecordScreen({Key? key}) : super(key: key);

  @override
  State<CurrentRecordScreen> createState() => _CurrentRecordScreenState();
}

class _CurrentRecordScreenState extends State<CurrentRecordScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.getNewRecords();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.loading) {
      return const LoaderScreen();
    }

    return Scaffold(
      backgroundColor: kBgColor,
      appBar: customAppBar(
        () {
          Navigator.pop(context);
        },
        title: const Text(
          "Предстоящие записи",
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
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return buildListOfItems(
                      authProvider.newRecordmodel,
                    );
                  },
                  childCount: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListOfItems(List<RecordModel> recordModels) {
    return recordModels.isEmpty
        ? const Expanded(
            child: Center(
              child: Text('Нет элементов :('),
            ),
          )
        : Column(
            children: List.generate(
              recordModels.length,
              (index) => InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: RecordCard(
                    model: recordModels[index],
                    isCurrent: true,
                  ),
                ),
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

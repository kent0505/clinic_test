import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:sadykova_app/core/compoents/appBar/custom_app_bar.dart';
import 'package:sadykova_app/core/compoents/appBar/no_data_widget.dart';
import 'package:sadykova_app/features/auth/domain/state/auth_provider.dart';
import 'package:sadykova_app/features/auth/ui/screens/loader_screen.dart';
import 'package:sadykova_app/features/profile/ui/screens/detail_analis_screen.dart';
import 'package:sadykova_app/features/profile/ui/widgets/analis_menu_item.dart';

class AnalisResultScreen extends StatefulWidget {
  const AnalisResultScreen({Key? key}) : super(key: key);

  @override
  State<AnalisResultScreen> createState() => _AnalisResultScreenState();
}

class _AnalisResultScreenState extends State<AnalisResultScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.getAnalisList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.loading) {
      return const LoaderScreen();
    }

    return Scaffold(
      appBar: customAppBar(
        () {
          Navigator.pop(context);
        },
        title: const Text(
          "Результаты анализов",
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
        child: authProvider.analisList.isEmpty
            ? const NoDataWidget()
            : ListView.builder(
                itemCount: authProvider.analisList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      pushNewScreen(
                        context,
                        screen: DetailAnalisScreen(
                          analisModel: authProvider.analisList[index],
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: AnalisMenuItem(
                        model: authProvider.analisList[index],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sadykova_app/core/compoents/buttons/loading_button.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/theme/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:sadykova_app/features/auth/domain/state/user_provider.dart';
import 'package:sadykova_app/features/auth/ui/screens/login_screen.dart';

class NeedAuthScreen extends StatefulWidget {
  const NeedAuthScreen({Key? key}) : super(key: key);

  @override
  State<NeedAuthScreen> createState() => _NeedAuthScreenState();
}

class _NeedAuthScreenState extends State<NeedAuthScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: kGreyScale300Color,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/error.json',
              width: 150,
              height: 150,
            ),
            const Text(
              "Для этого раздела \nнеобходимо авторизоваться",
              style: TextStyle(
                color: Color(0xff66788C),
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            LoadingButton(
              title: 'Авторизоваться',
              onPressed: () async {
                userProvider.openLogin();
                Navigator.of(context, rootNavigator: true).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
                // swiperProvider.swithBottomNavBar(0);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget listOfTextWidgets() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Забили логин или пароль?",
              style: mainRegulartTextStyle.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () {},
              child: Text("Восстановить", style: mainRegulartTextStyle),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Нет аккаунта?",
              style: mainRegulartTextStyle.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () {},
              child: Text("Зарегистрироваться", style: mainRegulartTextStyle),
            ),
          ],
        ),
      ],
    );
  }
}

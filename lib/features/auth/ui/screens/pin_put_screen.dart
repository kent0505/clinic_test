import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sadykova_app/core/compoents/buttons/loading_button.dart';
import 'package:sadykova_app/core/compoents/top_snackbar/top_alert.dart';
import 'package:sadykova_app/core/theme/text_styles.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/features/auth/domain/state/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:sadykova_app/features/auth/domain/state/user_provider.dart';
import 'package:sadykova_app/features/auth/ui/widgets/pinput_widget.dart';
import 'package:sadykova_app/navigation/main_swiper.dart';
import 'package:sadykova_app/navigation/main_swiper_provider.dart';

class PinPutScreen extends StatefulWidget {
  const PinPutScreen({Key? key}) : super(key: key);

  @override
  State<PinPutScreen> createState() => _PinPutScreenState();
}

class _PinPutScreenState extends State<PinPutScreen> {
  final passwordKey = GlobalKey<FormState>();
  int secondsRemaining = 60;
  bool enableResend = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (secondsRemaining != 1) {
          setState(() {
            secondsRemaining--;
          });
        } else {
          setState(
            () {
              enableResend = true;
              secondsRemaining = 0;
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final swiperProvider = Provider.of<MainSwiperProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 162),
            Center(
              child: SvgPicture.asset(bigLogo),
            ),
            const SizedBox(height: 48),
            const Text(
              "Введите код из SMS",
              style: TextStyle(
                color: Color(0xff66788C),
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Мы отправили код на номер ${userProvider.phoneController.text}",
              style: const TextStyle(
                color: Color(0xff66788C),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Изменить номер",
                style: TextStyle(
                  color: Color(0x66E50052),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: PinPutWidget(
                controller: userProvider.codeController,
                isEroor: authProvider.isErrorPincode,
                onSubmitPinPut: (value) async {
                  // await authProvider.login().then((value) {
                  //   if (!value) {
                  //     showTopAlertError(context, authProvider.error!.message);
                  //   } else {
                  //     userProvider.startPinPutPage = false;
                  //     Navigator.pushAndRemoveUntil(
                  //       context,
                  //       MaterialPageRoute<void>(
                  //         builder: (BuildContext context) {
                  //           return const MainSwiper(page: 0);
                  //         },
                  //       ),
                  //       (route) => false,
                  //     );
                  //   }
                  //   return null;
                  // });
                },
                onChangePinPut: (value) {
                  authProvider.isErrorPincode = false;
                },
              ),
            ),
            const SizedBox(height: 24),
            LoadingButton(
              title: 'Войти',
              onPressed: () async {
                FocusScope.of(context).unfocus();

                await authProvider.login().then((value) {
                  if (!value) {
                    showTopAlertError(context, authProvider.error!.message);
                  } else {
                    userProvider.startPinPutPage = false;
                    swiperProvider.bottomBarController!.index = 0;
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return const MainSwiper();
                        },
                      ),
                      (route) => false,
                    );
                  }
                  return null;
                });
              },
              loading: authProvider.loading,
            ),
            const SizedBox(height: 24),
            Center(
              child: InkWell(
                onTap: () {
                  if (secondsRemaining < 1) {
                    authProvider.confirmPhone();
                    setState(
                      () {
                        secondsRemaining = 60;
                      },
                    );
                  }
                },
                child: Text(
                  secondsRemaining < 1
                      ? "Отправить код повторно"
                      : "Отправить код повторно можно через $secondsRemaining сек.",
                  style: const TextStyle(
                    color: Color(0xff66788C),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
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
              "Забыли логин или пароль?",
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
        const SizedBox(
          height: 12,
        ),
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

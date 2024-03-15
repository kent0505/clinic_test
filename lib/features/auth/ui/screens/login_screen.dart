import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sadykova_app/core/compoents/buttons/loading_button.dart';
import 'package:sadykova_app/core/compoents/text_fields/custom_text_field.dart';
import 'package:sadykova_app/core/compoents/top_snackbar/top_alert.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/features/auth/domain/state/auth_provider.dart';
import 'package:sadykova_app/features/auth/domain/state/user_provider.dart';
import 'package:sadykova_app/features/auth/ui/screens/pin_put_screen.dart';
import 'package:sadykova_app/navigation/main_swiper.dart';
import 'package:sadykova_app/navigation/main_swiper_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final swiperProvider = Provider.of<MainSwiperProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 143),
              SizedBox(
                height: 125,
                child: SvgPicture.asset(bigLogo),
              ),
              const SizedBox(height: 57),
              CustomTextField(
                title: 'Номер телефона',
                hintText: 'Введите номер телефона',
                formKey: loginKey,
                controller: userProvider.phoneController,
                inputType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty || value.length != 19) {
                    return '* Обязательное поле';
                  }
                  return null;
                },
                formatters: [
                  TextInputMask(mask: '\\+ 7 (999) 999-99-99', reverse: false),
                ],
              ),
              const SizedBox(height: 24),
              LoadingButton(
                title: 'Получить код',
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  if (loginKey.currentState!.validate()) {
                    final result = await authProvider.confirmPhone();
                    if (result) {
                      userProvider.startPinPutPage = true;

                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return const PinPutScreen();
                          },
                        ),
                      );
                    } else {
                      showTopAlertError(context, authProvider.error!.message);
                    }
                  }
                },
                loading: authProvider.loading,
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  userProvider.skipLogin();
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
                },
                child: const Text(
                  'Пропустить этот шаг',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xff66788C),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

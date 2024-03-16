import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sadykova_app/core/compoents/buttons/elevated_fill_button.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/core/utils/constants.dart';
import 'package:sadykova_app/features/auth/domain/state/user_provider.dart';
import 'package:sadykova_app/features/auth/ui/screens/login_screen.dart';
import 'package:sadykova_app/features/main/domain/models/notifications_model.dart';
import 'package:sadykova_app/features/main/ui/screens/store_screen.dart';
import 'package:sadykova_app/navigation/main_swiper_provider.dart';

class TopScreenWidget extends StatelessWidget {
  const TopScreenWidget({
    Key? key,
    required this.onTapNotification,
    required this.notificationList,
  }) : super(key: key);

  final Function() onTapNotification;
  final List<NotificationsModels> notificationList;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    // final homeProvider = Provider.of<HomeProvider>(context);
    final swiperProvider = Provider.of<MainSwiperProvider>(context);

    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(mainScreenBg),
              colorFilter: ColorFilter.mode(
                const Color(0xff66788C).withOpacity(0.2),
                BlendMode.color,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(lightLogo),
                  // NotificationIcon(
                  //   notifications: homeProvider.notificationModels,
                  // ),
                ],
              ),
              const SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      userProvider.user != null &&
                              userProvider.user!.name != null &&
                              userProvider.user!.name!.isNotEmpty
                          ? "Привет, ${userProvider.user!.name}!"
                          : "Привет!",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat-b',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              // userProvider.user != null &&
              //         userProvider.user!.name != null &&
              //         userProvider.user!.name!.isNotEmpty &&
              //         homeProvider.notificationVisible
              //     ? NotificationCard(models: notificationList)
              //     : Container(),
              // const SizedBox(height: 12),
              Row(
                children: [
                  userProvider.user != null &&
                          userProvider.user!.name != null &&
                          userProvider.user!.name!.isNotEmpty
                      ? Expanded(
                          child: ElevatedFillButton(
                            title: 'Запись на прием',
                            height: 48,
                            onTap: () {
                              swiperProvider.swithBottomNavBar(1);
                            },
                          ),
                        )
                      : Expanded(
                          child: ElevatedFillButton(
                            title: 'Авторизоваться',
                            height: 48,
                            onTap: () {
                              userProvider.openLogin();
                              Navigator.of(context, rootNavigator: true)
                                  .pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedFillButton(
                      title: 'Онлайн магазин',
                      height: 48,
                      buttonColor: kWhiteColor,
                      textColor: kGreyScale900Color,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              return const StoreScreen(url: onLineShopLink);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/core/utils/constants.dart';
import 'package:sadykova_app/features/main/ui/screens/main_screen.dart';
import 'package:sadykova_app/features/main/ui/screens/web_view_screen.dart';
import 'package:sadykova_app/features/profile/ui/screens/profile_screen.dart';
import 'package:sadykova_app/features/services/ui/screens/group_service_screen.dart';
import 'package:sadykova_app/features/staffs/ui/screens/staff_screen.dart';
import 'package:sadykova_app/navigation/main_swiper_provider.dart';

class MainSwiper extends StatefulWidget {
  const MainSwiper({Key? key}) : super(key: key);

  @override
  _MainSwiperState createState() => _MainSwiperState();
}

class _MainSwiperState extends State<MainSwiper> {
  FocusNode? keyboardFocusNode;
  bool getLocale = false;

  @override
  void initState() {
    super.initState();
    keyboardFocusNode = FocusNode();
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      prisistenceBottomBartItem(mainIcon, "Главная"),
      prisistenceBottomBartItem(appointmentIcon, "Записаться"),
      prisistenceBottomBartItem(servicesIcon, "Услуги"),
      prisistenceBottomBartItem(doctorIcon, "Врачи"),
      prisistenceBottomBartItem(userIcon, "Аккаунт"),
    ];
  }

  PersistentBottomNavBarItem prisistenceBottomBartItem(
    String icon,
    String title,
  ) {
    return PersistentBottomNavBarItem(
      inactiveIcon: buildIcon(
        kGreyScale900Color.withOpacity(0.40),
        icon,
        title,
        Colors.transparent,
      ),
      iconSize: 24,
      icon: buildIcon(kGreyScale900Color, icon, title, kPrimaryColor),
      textStyle: const TextStyle(),
      activeColorPrimary: kGreyScale900Color,
      inactiveColorPrimary: kGreyScale900Color.withOpacity(0.64),
    );
  }

  AnimatedContainer buildIcon(
    Color color,
    String icon,
    String tittle,
    Color textColor,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 80.0,
      width: 80.0,
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 4),
          SvgPicture.asset(
            icon,
            color: color,
            height: 24,
            width: 24,
            fit: BoxFit.fitHeight,
          ),
          Text(
            tittle,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 11,
              color: color,
            ),
          ),
          const SizedBox(height: 7)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final swiperProvider = Provider.of<MainSwiperProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            setState(() {
              keyboardFocusNode!.unfocus();
            });
            return true;
          },
          child: PersistentTabView(
            context,
            controller: swiperProvider.bottomBarController,
            bottomScreenMargin: 0,
            backgroundColor: kBgColor,
            navBarHeight: 50,
            screens: _buildScreens(),
            stateManagement: true,
            items: navBarItems(),
            padding: const NavBarPadding.all(0),
            navBarStyle: NavBarStyle.simple,
            decoration: NavBarDecoration(
              border: Border(
                top: BorderSide(color: kGreyScale900Color.withOpacity(0.1)),
              ),
            ),
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            confineInSafeArea: false,
            hideNavigationBarWhenKeyboardShows: true,
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            selectedTabScreenContext: (context) {},
            onItemSelected: (index) async {
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const MainScreen(),
      const WebViewScreen(url: orederLink),
      const GroupServicesScreen(),
      const StaffsScreen(),
      const ProfileScreen()
    ];
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:sadykova_app/core/compoents/image/oval_avatar.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/core/utils/path_converter.dart';
import 'package:sadykova_app/features/auth/domain/state/auth_provider.dart';
import 'package:sadykova_app/features/auth/domain/state/user_provider.dart';
import 'package:sadykova_app/features/auth/ui/screens/loader_screen.dart';
import 'package:sadykova_app/features/auth/ui/screens/need_auth_screer.dart';
import 'package:sadykova_app/features/profile/ui/screens/analis_result_screen.dart';
import 'package:sadykova_app/features/profile/ui/screens/current_record_screen.dart';
import 'package:sadykova_app/features/profile/ui/screens/history_record_screen.dart';
import 'package:sadykova_app/features/profile/ui/screens/prescription_screen.dart';
import 'package:sadykova_app/features/profile/ui/screens/profile_setting_screen.dart';
import 'package:sadykova_app/features/profile/ui/screens/tax_request_screen.dart';
import 'package:sadykova_app/features/profile/ui/widgets/gallery_container.dart';
import 'package:sadykova_app/features/profile/ui/widgets/menu_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final scrollController = ScrollController();
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      if (userProvider.user!.token != null) {
        authProvider.getUserInfo();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    if (userProvider.user == null || userProvider.user!.token == null) {
      return const NeedAuthScreen();
    }

    if (authProvider.loading) {
      return const LoaderScreen();
    }

    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          color: const Color(0xff66788C),
          onRefresh: () async {
            await authProvider.getUserInfo();
          },
          child: ListView(
            children: [
              topInfo(userProvider),
              const SizedBox(height: 16),
              GridView.count(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.4,
                children: [
                  MenuWidget(
                    icon: currentIcon,
                    title: "Текущие \nзаписи",
                    onTap: () {
                      pushNewScreen(
                        context,
                        screen: const CurrentRecordScreen(),
                      );
                    },
                    count: authProvider.newRecordmodel.length,
                  ),
                  MenuWidget(
                    icon: resultIcon,
                    title: "Результаты \nанализов",
                    onTap: () {
                      pushNewScreen(
                        context,
                        screen: const AnalisResultScreen(),
                      );
                    },
                    count: authProvider.analisList.length,
                    isActive: true,
                  ),
                  MenuWidget(
                    icon: doctorViewIcon,
                    title: "Назначения \nврача",
                    onTap: () {
                      pushNewScreen(
                        context,
                        screen: const PrescriptionScreen(),
                      );
                    },
                  ),
                  MenuWidget(
                    icon: historyIcon,
                    title: "История \nзаписей",
                    onTap: () {
                      pushNewScreen(
                        context,
                        screen: const HistoryRecordScreen(),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const GalleryContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget requestForTask() {
    return InkWell(
      onTap: () {
        pushNewScreen(
          context,
          screen: const TexRequestScreen(),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(procentIcon),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      "Запрос справки в налоговую инспекцию",
                      style: TextStyle(
                        color: Color(0xff66788C),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget topInfo(UserProvider userProvider) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.width * 0.75,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(profileBg),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 0.75,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 40,
              right: 16,
              left: 16,
              bottom: 18,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(lightLogo),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        pushNewScreen(
                          context,
                          screen: const ProfileSettingScreen(),
                        );
                      },
                      child: SvgPicture.asset(
                        settingIcon,
                        width: 32,
                        height: 32,
                        fit: BoxFit.fitHeight,
                        color: kWhiteColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    OvalAvatar(
                      imgPath: userProvider.user!.path != null &&
                              userProvider.user!.path!.isNotEmpty
                          ? ImagePathConvertor.convertTopaht(
                              path: userProvider.user!.path!,
                            )
                          : noImageLink,
                      height: 110,
                      width: 110,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      userProvider.user!.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userProvider.user!.phone ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

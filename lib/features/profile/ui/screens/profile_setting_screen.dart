import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sadykova_app/core/compoents/appBar/custom_app_bar.dart';
import 'package:sadykova_app/core/compoents/dialog/dialogs/dialogs.dart';
import 'package:sadykova_app/core/compoents/dialog/dialogs/info_dialog.dart';
import 'package:sadykova_app/core/compoents/image/oval_avatar.dart';
import 'package:sadykova_app/core/compoents/text_fields/custom_text_field.dart';
import 'package:sadykova_app/core/logger/logger_impl.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/utils/path_converter.dart';
import 'package:sadykova_app/features/auth/domain/state/auth_provider.dart';
import 'package:sadykova_app/features/auth/domain/state/user_provider.dart';
import 'package:sadykova_app/features/auth/ui/screens/login_screen.dart';
import 'package:sadykova_app/features/main/ui/widgets/city_select_modal.dart';
import 'package:sadykova_app/features/profile/ui/widgets/date_modal_sheet.dart';
import 'package:provider/provider.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  final scrollController = ScrollController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  final nameKey = GlobalKey<FormState>();
  final cityKey = GlobalKey<FormState>();
  final phoneKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();

  int groupValue = 0;
  String city = '';
  String sexType = '';

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (userProvider.user != null) {
      nameController.text = userProvider.user!.name ?? '';
      phoneController.text = userProvider.user!.phone ?? '';
      emailController.text = userProvider.user!.email ?? '';
      groupValue = userProvider.user!.gender != null &&
              userProvider.user!.gender == "Мужской"
          ? 1
          : 0;
    }
  }

  Future pickImage(AuthProvider authProvider, BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      log("image $image");
      if (image != null) {
        await authProvider.updateAvatar(File(image.path)).then((value) async {
          await authProvider.getUserInfo().then((value) {
            Navigator.pop(context);
          });
          return null;
        });
        return;
      }
    } on PlatformException {
      logger.e("Error upload image");
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(
        () {
          Navigator.pop(context);
        },
        title: const Text(
          "Настройки",
          style: TextStyle(
            color: Color(0xff415164),
            fontSize: 17,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat-b',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 70),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return buildInfo(userProvider, authProvider);
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

  Widget buildAvatarEditidget(AuthProvider authProvider, String photo) {
    return Stack(
      children: [
        OvalAvatar(
          imgPath: photo,
          height: 90,
          width: 90,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              pickImage(authProvider, context);
            },
            borderRadius: BorderRadius.circular(50),
            child: Container(
              height: 36,
              width: 36,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset(
                  cameraIcon,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildSegmentSliderSex() {
    return SizedBox(
      width: double.infinity,
      child: CupertinoSlidingSegmentedControl<int>(
        groupValue: groupValue,
        backgroundColor: const Color(0xff66788C).withOpacity(0.2),
        thumbColor: kWhiteColor,
        children: {
          0: buildSegment("Женский"),
          1: buildSegment("Мужской"),
        },
        padding: const EdgeInsets.all(4),
        onValueChanged: (value) {
          setState(() {
            groupValue = value!;
          });
        },
      ),
    );
  }

  Widget buildSegment(String text) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xff66788C),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildInfo(UserProvider userProvider, AuthProvider authProvider) {
    return Column(
      children: [
        const SizedBox(height: 4),
        if (userProvider.user != null)
          buildAvatarEditidget(
            authProvider,
            userProvider.user!.path == null || userProvider.user!.path!.isEmpty
                ? noImageLink
                : ImagePathConvertor.convertTopaht(
                    path: userProvider.user!.path!,
                  ),
          ),
        const SizedBox(height: 8),
        CustomTextField(
          title: "Имя",
          formKey: nameKey,
          controller: nameController,
          hintText: 'Ваше имя',
          validator: (value) {
            if (value.isEmpty) {
              return "* Обязательное поле";
            }
            return null;
          },
          formatters: const [],
        ),
        const SizedBox(height: 16),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Пол",
              style: TextStyle(
                color: Color(0xff66788C),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            buildSegmentSliderSex(),
          ],
        ),
        const SizedBox(height: 16),
        CustomTextField(
          // isOnlyReady: true,
          title: "Номер телефона",
          formKey: phoneKey,
          controller: phoneController,
          inputType: TextInputType.number,
          hintText: 'Номер телефона',
          validator: (value) {
            if (value.isEmpty) {
              return "* Обязательное поле";
            }
            return null;
          },
          isOnlyReady: true,
          formatters: const [
            // TextInputMask(mask: '\\+ 7 (999) 999-99-99', reverse: false),
          ],
        ),
        const SizedBox(height: 16),
        CustomTextField(
          title: "Электронная почта",
          formKey: emailKey,
          controller: emailController,
          hintText: 'Электронная почта',
          validator: (value) {
            return null;

            // if (value.isEmpty) {
            //   return "* Обязательное поле";
            // }
          },
          formatters: const [
            // TextInputMask(mask: '\\+ 7 (999) 999-99-99', reverse: false),
          ],
        ),
        const SizedBox(height: 32),
        changePasswordButton(authProvider),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget changePasswordButton(AuthProvider authProvider) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 36,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    await authProvider
                        .updateUserInfo(
                            nameController.text,
                            groupValue == 0 ? "Женский" : "Мужской",
                            emailController.text)
                        .then((value) {
                      authProvider.getUserInfo();
                      Navigator.pop(context);
                      return null;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: const Center(
                    child: Text(
                      "Сохранить",
                      style: TextStyle(
                        color: Color(0xff66788C),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 36,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    context.read<UserProvider>().deleteUserFromStorage();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: const Center(
                    child: Text(
                      "Выйти из аккаунта",
                      style: TextStyle(
                        color: Color(0xff66788C),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 36,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    Dialogs.showUnmodal(
                      context,
                      InfoDialog(
                        title: "Удаление аккаунта",
                        onAcept: () async {
                          await context
                              .read<AuthProvider>()
                              .deleteUserAccount()
                              .then((value) {
                            if (value) {
                              context
                                  .read<UserProvider>()
                                  .deleteUserFromStorage();
                            }
                          });
                        },
                        text: "Вы точно хотите удалить аккаунт ?",
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: const Center(
                    child: Text(
                      "Удалить аккаунт",
                      style: TextStyle(
                        color: Color(0xff66788C),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void openCityModal(UserProvider provider) async {
    var result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return const CitySelectModal();
      },
    );
    provider.changeFirsetInit();
    if (result != null) {
      provider.setSelectedCity(result.toString());
    }
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

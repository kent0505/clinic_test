import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sadykova_app/core/compoents/appBar/custom_app_bar.dart';
import 'package:sadykova_app/core/compoents/buttons/elevated_fill_button.dart';
import 'package:sadykova_app/core/compoents/text_fields/custom_text_field.dart';
import 'package:sadykova_app/core/compoents/top_snackbar/top_alert.dart';
import 'package:sadykova_app/core/logger/logger_impl.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/features/auth/domain/state/auth_provider.dart';
import 'package:sadykova_app/features/auth/domain/state/user_provider.dart';
import 'package:sadykova_app/features/main/ui/widgets/city_select_modal.dart';
import 'package:sadykova_app/features/profile/ui/widgets/date_modal_sheet.dart';
import 'package:provider/provider.dart';

class TexRequestScreen extends StatefulWidget {
  const TexRequestScreen({Key? key}) : super(key: key);

  @override
  State<TexRequestScreen> createState() => _TexRequestScreenState();
}

class _TexRequestScreenState extends State<TexRequestScreen> {
  final scrollController = ScrollController();
  final fioTaxerController = TextEditingController();
  final innTaxerController = TextEditingController();
  final fioClientController = TextEditingController();
  final dateController = TextEditingController();
  final yearController = TextEditingController();
  final commentController = TextEditingController();

  final fioTaxerKey = GlobalKey<FormState>();
  final cityKey = GlobalKey<FormState>();
  final innTaxerKey = GlobalKey<FormState>();
  final dateKey = GlobalKey<FormState>();
  final phoneKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();

  bool isSelected = false;
  int groupValue = 0;

  @override
  void initState() {
    super.initState();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
    } on PlatformException {
      logger.e("Error upload image");
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: customAppBar(
        () {
          Navigator.pop(context);
        },
        title: const Text(
          "Запрос справки в налоговую \nинспекцию",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xff415164),
            fontSize: 17,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat-b',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 12, left: 12, top: 16),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 70),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return buildInfo(userProvider);
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

  Widget buildInfo(UserProvider userProvider) {
    return Column(
      children: [
        const SizedBox(height: 9),
        CustomTextField(
          title: "Ф.И.О налогоплательщика",
          formKey: innTaxerKey,
          controller: fioTaxerController,
          hintText: 'Ф.И.О',
          validator: (value) {
            if (value.isEmpty) {
              return "* Обязательное поле";
            }
            return null;
          },
          formatters: const [],
        ),
        const SizedBox(height: 16),
        CustomTextField(
          title: "ИНН налогоплательщика",
          formKey: cityKey,
          controller: innTaxerController,
          hintText: 'ИНН',
          inputType: TextInputType.number,
          validator: (value) {
            if (value.isEmpty) {
              return "* Обязательное поле";
            }
            return null;
          },
          formatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        const SizedBox(height: 16),
        CustomTextField(
          title: "Ф.И.О пациента",
          formKey: fioTaxerKey,
          controller: fioClientController,
          hintText: 'Ф.И.О',
          validator: (value) {
            if (value.isEmpty) {
              return "* Обязательное поле";
            }
            return null;
          },
          formatters: const [],
        ),
        const SizedBox(height: 16),
        CustomTextField(
          title: "День рождения",
          formKey: dateKey,
          controller: dateController,
          hintText: 'День рождения',
          inputType: TextInputType.number,
          validator: (value) {
            if (value.isEmpty) {
              return "* Обязательное поле";
            }
            return null;
          },
          formatters: [
            TextInputMask(mask: '99.99.9999', reverse: false),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        CustomTextField(
          title: "Отчетный год",
          formKey: phoneKey,
          controller: yearController,
          hintText: 'Отчетный год',
          inputType: TextInputType.number,
          validator: (value) {
            if (value.isEmpty) {
              return "* Обязательное поле";
            }
            return null;
          },
          formatters: [
            TextInputMask(mask: '9999', reverse: false),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        CustomTextField(
          maxLines: 5,
          title: "Комментарии",
          formKey: emailKey,
          controller: commentController,
          hintText: 'Напишите комментарии',
          validator: (value) {
            if (value.isEmpty) {
              return "* Обязательное поле";
            }
            return null;
          },
          formatters: const [],
        ),
        const SizedBox(height: 32),
        checkBoxWidget(),
        const SizedBox(height: 32),
        changePasswordButton(),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget checkBoxWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isSelected = !isSelected;
            });
          },
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff66788C),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: isSelected
                ? const Icon(
                    Icons.done_rounded,
                    size: 16,
                    color: Color(0xff66788C),
                  )
                : Container(),
          ),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              "Подтвеждаю согласие на обработку персональных данных",
              style: TextStyle(
                color: Color(0xff66788C),
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget changePasswordButton() {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return ElevatedFillButton(
      title: "Отправить запрос",
      fontSize: 17,
      onTap: () async {
        if (!isSelected) {
          showTopAlertError(
            context,
            "Дайте согласия на обработку персональных данных",
            topPadding: 40,
          );
          return;
        }
        if (innTaxerKey.currentState!.validate() &&
            cityKey.currentState!.validate() &&
            fioTaxerKey.currentState!.validate() &&
            dateKey.currentState!.validate() &&
            phoneKey.currentState!.validate() &&
            emailKey.currentState!.validate()) {
          await authProvider
              .sendNaloginspection(
            dateController.text,
            commentController.text,
            fioClientController.text,
            fioTaxerController.text,
            yearController.text,
            int.parse(
              innTaxerController.text,
            ),
          )
              .then(
            (value) {
              if (value) {
                showTopAlertSucces(
                  context,
                  "Запрос успешно отправлен",
                  topPadding: 40,
                );
                Navigator.pop(context);
              } else {
                showTopAlertError(
                  context,
                  "Ошибка отправки запроса",
                  topPadding: 40,
                );
              }
            },
          );
        }
      },
      height: 55,
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

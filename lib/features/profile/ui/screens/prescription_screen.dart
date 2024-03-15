import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sadykova_app/core/compoents/appBar/custom_app_bar.dart';
import 'package:sadykova_app/core/compoents/buttons/elevated_fill_button.dart';
import 'package:sadykova_app/core/compoents/loaders/loader.dart';
import 'package:sadykova_app/core/logger/logger_impl.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/core/utils/path_converter.dart';
import 'package:sadykova_app/features/auth/domain/state/auth_provider.dart';
import 'package:sadykova_app/features/auth/domain/state/user_provider.dart';
import 'package:sadykova_app/features/auth/ui/screens/loader_screen.dart';
import 'package:sadykova_app/features/profile/domain/models/prescription.dart';
import 'package:sadykova_app/features/profile/ui/screens/photo_open_screen.dart';
import 'package:provider/provider.dart';

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({Key? key}) : super(key: key);

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.getPrescription();
    });
  }

  Future pickImage(AuthProvider authProvider, BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      log("image $image");
      if (image != null) {
        await authProvider
            .updatePhotoPrescription(File(image.path))
            .then((value) {
          authProvider.getPrescription();
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
    var authProvider = Provider.of<AuthProvider>(context);
    var userProvder = Provider.of<UserProvider>(context);

    if (authProvider.loading) {
      return const LoaderScreen();
    }
    return Scaffold(
      appBar: customAppBar(
        () {
          Navigator.pop(context);
        },
        title: const Text(
          "Назначения врача",
          style: TextStyle(
            color: Color(0xff415164),
            fontSize: 17,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat-b',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 12, left: 12),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            if (authProvider.prescriptionModel.isEmpty)
              const SliverToBoxAdapter(
                child: Center(
                  child: Text('Нет элементов :('),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.only(top: 16, bottom: 70),
                sliver: SliverGrid.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  children: createPhotoList(
                    authProvider.prescriptionModel,
                    userProvder,
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 70, right: 12, left: 12),
        child: ElevatedFillButton(
          elevation: 1,
          height: 60,
          onTap: () {
            pickImage(authProvider, context);
          },
          title: 'Добавить назначение',
          fontSize: 15,
          buttonColor: Colors.white,
          textColor: const Color(0xff66788C),
          icon: addIcon,
        ),
      ),
    );
  }

  List<String?> convertToListPath(List<PrescriptionModel> models) {
    List<String?> list = [];
    for (var model in models) {
      list.add(model.path);
    }
    return list;
  }

  List<Widget> createPhotoList(
    List<PrescriptionModel> models,
    UserProvider userProvider,
  ) {
    List<Widget> newList = [];
    for (int index = 0; index < models.length; index++) {
      newList.add(
        InkWell(
          onTap: () {
            pushNewScreen(
              context,
              withNavBar: false,
              screen: PhotoOpenScreen(
                initialIndex: index,
                photoModels: convertToListPath(models),
              ),
            );
          },
          child: CachedNetworkImage(
            imageUrl: ImagePathConvertor.convertTopaht(
              path: models[index].path ?? '',
            ),
            errorWidget: (context, url, error) => Container(),
            placeholder: (context, url) => const Center(
              child: Loader(),
            ),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return newList;
  }
}

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sadykova_app/core/compoents/buttons/elevated_fill_button.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/utils/asset_paths.dart';
import 'package:sadykova_app/features/profile/ui/screens/galley_photo_screen.dart';
import 'package:sadykova_app/features/profile/ui/screens/image_creater_screen.dart';

class GalleryContainer extends StatefulWidget {
  const GalleryContainer({Key? key}) : super(key: key);

  @override
  State<GalleryContainer> createState() => _GalleryContainerState();
}

class _GalleryContainerState extends State<GalleryContainer> {
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return ImageCreaterScreen(fileName: imageTemporary);
          },
        ),
      );
    } on PlatformException {
      log("Error upload image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Галерея фото",
                          style: TextStyle(
                            color: Color(0xff66788C),
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat-b',
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Добавляйте фото с пройденных процедур, отслеживая ваш прогресс",
                          maxLines: 2,
                          style: TextStyle(
                            color: Color(0xff66788C),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   height: 60,
                  //   width: 60,
                  //   decoration: const BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     image: DecorationImage(
                  //       fit: BoxFit.cover,
                  //       image: AssetImage(
                  //         profileAvatarWomanPng,
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              const SizedBox(height: 17),
              Row(
                children: [
                  Expanded(
                    child: ElevatedFillButton(
                      elevation: 0,
                      height: 55,
                      onTap: () {
                        pickImage();
                      },
                      title: 'Добавить',
                      buttonColor: kBgColor,
                      textColor: const Color(0xff66788C),
                      icon: addIcon,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedFillButton(
                      elevation: 0,
                      height: 55,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              return const GalleyPhotoScreen();
                            },
                          ),
                        );
                      },
                      title: 'Все фото',
                      buttonColor: kBgColor,
                      textColor: const Color(0xff66788C),
                      icon: galleryIcon,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

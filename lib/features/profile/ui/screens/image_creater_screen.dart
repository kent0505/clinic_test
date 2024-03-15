import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sadykova_app/core/compoents/text_fields/custom_text_field.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/features/auth/domain/state/auth_provider.dart';
import 'package:provider/provider.dart';

class ImageCreaterScreen extends StatefulWidget {
  const ImageCreaterScreen({
    Key? key,
    required this.fileName,
  }) : super(key: key);

  final File fileName;

  @override
  State<ImageCreaterScreen> createState() => _ImageCreaterScreenState();
}

class _ImageCreaterScreenState extends State<ImageCreaterScreen> {
  final signatureController = TextEditingController();
  final signatureKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: kBlack,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          size: 32,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                    Center(
                      child: Image.file(
                        widget.fileName,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Container()
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12, left: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              formKey: signatureKey,
                              controller: signatureController,
                              hintText: 'Добавить подпись...',
                              validator: (value) {
                                return null;
                              },
                              formatters: const [
                                // TextInputMask(mask: '\\+ 7 (999) 999-99-99', reverse: false),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: InkWell(
                              onTap: () async {
                                authProvider
                                    .updatePhotoGallery(widget.fileName);

                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 48,
                                width: 48,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kPrimaryColor,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.done_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

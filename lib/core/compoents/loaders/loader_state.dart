import 'package:flutter/material.dart';
import 'package:sadykova_app/core/compoents/loaders/loader.dart';
import 'package:sadykova_app/core/theme/colors.dart';

class LoaderState extends StatelessWidget {
  const LoaderState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBgColor,
      body: Center(
        child: Loader(),
      ),
    );
  }
}

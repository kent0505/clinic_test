import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StaticImageHeader extends StatelessWidget {
  const StaticImageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.56,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color(0xff66788C),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/logo/logo_without_text2.svg',
        ),
      ),
    );
  }
}

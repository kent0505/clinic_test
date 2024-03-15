import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialItemWidget extends StatelessWidget {
  const SocialItemWidget({
    Key? key,
    required this.onTap,
    required this.icon,
  }) : super(key: key);
  final Function() onTap;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Ink(
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xffFAF9F4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SvgPicture.asset(icon),
            ),
          ),
        ),
      ),
    );
  }
}

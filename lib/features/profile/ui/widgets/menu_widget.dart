import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sadykova_app/core/theme/colors.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.count = 0,
    this.subtitle = '',
    this.isActive = false,
    this.showCount = true,
  }) : super(key: key);

  final String icon;
  final String title;
  final Function() onTap;
  final int? count;
  final bool isActive;
  final String subtitle;
  final bool showCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(icon),
                    if (count! > 0 && showCount)
                      Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive ? kPrimaryColor : kBgColor,
                        ),
                        child: Center(
                          child: Text(
                            "$count",
                            style: TextStyle(
                              color: isActive
                                  ? Colors.white
                                  : const Color(0xff66788C),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xff66788C),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                if (subtitle.isNotEmpty)
                  SizedBox(
                    height: 45,
                    child: Text(
                      subtitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xff66788C),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sadykova_app/core/theme/colors.dart';

class CloseModalWidget extends StatelessWidget {
  const CloseModalWidget({Key? key, this.onClose}) : super(key: key);
  final Function()? onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            right: 12,
            top: 12,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: onClose ??
                  () {
                    Navigator.pop(context);
                  },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff331F07).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.close_rounded,
                    color: kWhiteColor,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 95,
            height: 5,
            margin: const EdgeInsets.only(bottom: 10, top: 6),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ],
      ),
    );
  }
}

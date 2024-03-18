import 'package:flutter/material.dart';
import 'package:sadykova_app/core/compoents/buttons/main_button.dart';
import 'package:sadykova_app/core/compoents/dialog/main_dialog.dart';
import 'package:sadykova_app/core/theme/colors.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({
    Key? key,
    required this.title,
    required this.text,
    required this.onAcept,
  }) : super(key: key);

  final String title;
  final String text;
  final Function onAcept;

  @override
  Widget build(BuildContext context) {
    return MainDialog(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 30, bottom: 30),
            child: Text(
              text,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: kGreyScale700Color,
                  ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainButton(
                width: MediaQuery.of(context).size.width * 0.3,
                onPressed: () {
                  Navigator.pop(context);
                },
                title: 'Отмена',
              ),
              const SizedBox(width: 8),
              MainButton(
                width: MediaQuery.of(context).size.width * 0.3,
                onPressed: () {
                  Navigator.pop(context);
                  onAcept();
                },
                title: 'Удалить',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

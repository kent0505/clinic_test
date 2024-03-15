import 'package:flutter/cupertino.dart';
import 'package:sadykova_app/core/compoents/loaders/loader.dart';
import 'package:sadykova_app/core/theme/text_styles.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.loading = false,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(18),
      borderRadius: BorderRadius.circular(10.0),
      onPressed: onPressed,
      color: const Color(0xffE50052),
      child: loading
          ? const SizedBox(
              width: double.infinity,
              child: Loader(white: true),
            )
          : SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  title,
                  style: boldButtonTexStyle,
                ),
              ),
            ),
    );
  }
}

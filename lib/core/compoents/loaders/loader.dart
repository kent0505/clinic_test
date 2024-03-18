import 'package:flutter/cupertino.dart';

class Loader extends StatelessWidget {
  const Loader({
    Key? key,
    this.radius = 10,
    this.white = false,
  }) : super(key: key);

  final double radius;
  final bool white;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoTheme(
        data: CupertinoTheme.of(context).copyWith(brightness: Brightness.light),
        child: CupertinoActivityIndicator(
          radius: radius,
          color: white ? const Color(0xffffffff) : const Color(0xff66788C),
        ),
      ),
    );
  }
}

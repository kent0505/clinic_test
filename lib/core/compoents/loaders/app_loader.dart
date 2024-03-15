import 'package:flutter/cupertino.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({Key? key, this.radius = 10}) : super(key: key);

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      radius: radius,
    );
  }
}

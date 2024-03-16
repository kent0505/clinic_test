import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Нет данных',
        style: TextStyle(
          color: Color(0xff66788C),
        ),
      ),
    );
  }
}

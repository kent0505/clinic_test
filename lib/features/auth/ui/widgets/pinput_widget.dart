import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sadykova_app/core/theme/colors.dart';

class PinPutWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isEroor;
  final Function(String value) onSubmitPinPut;
  final Function(String value) onChangePinPut;

  const PinPutWidget({
    Key? key,
    required this.controller,
    required this.isEroor,
    required this.onSubmitPinPut,
    required this.onChangePinPut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      height: 48,
      textStyle: Theme.of(context).textTheme.subtitle2!,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
    );

    final focusedPinTheme = submittedPinTheme.copyDecorationWith();
    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Theme.of(context).errorColor.withOpacity(0.1),
        border: Border.all(
          color: Theme.of(context).errorColor,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
    );
    return Pinput(
      // preFilledWidget: Text(
      //   '0',
      //   style: Theme.of(context).textTheme.subtitle2!.copyWith(
      //         color: Theme.of(context).canvasColor.withOpacity(0.5),
      //       ),
      // ),
      forceErrorState: isEroor,
      controller: controller,
      autofocus: false,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      errorPinTheme: controller.length == 4 ? errorPinTheme : null,
      validator: (s) {
        return null;
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      cursor: Container(
        height: 28,
        width: 1,
        color: const Color(0xff66788C),
      ),
      onCompleted: onSubmitPinPut,
      onChanged: onChangePinPut,
      errorText: 'Неверный код подтверждения.',
      errorBuilder: (errorText, pin) {
        if (controller.length == 4) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Icon(
                    Icons.close,
                    color: Theme.of(context).errorColor,
                    size: 16,
                  ),
                ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/theme/text_styles.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final MaskTextInputFormatter? inputFormatter;
  final String hintText;
  final FormFieldValidator? validator;
  final GlobalKey<FormState> formKey;
  final List<TextInputFormatter> formatters;
  final bool isPassword;
  final TextInputType inputType;
  final bool isOnlyReady;
  final Widget? suffix;
  final int maxLines;

  const CustomTextField({
    Key? key,
    this.title = '',
    required this.controller,
    this.inputFormatter,
    required this.hintText,
    required this.validator,
    required this.formKey,
    required this.formatters,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    this.isOnlyReady = false,
    this.suffix,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _textFieldFocus = FocusNode();
  bool _obscureText = true;
  void _toggle() {
    setState(
      () {
        _obscureText = !_obscureText;
      },
    );
  }

  @override
  void initState() {
    if (!widget.isPassword) {
      _obscureText = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              widget.title,
              style: mainMediumTexttStyle.copyWith(
                color: const Color(0xff66788C),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        Form(
          key: widget.formKey,
          child: TextFormField(
            maxLines: widget.maxLines,
            obscureText: _obscureText,
            keyboardType: widget.inputType,
            inputFormatters: widget.formatters,
            controller: widget.controller,
            validator: widget.validator,
            scrollPadding: EdgeInsets.zero,
            focusNode: _textFieldFocus,
            style: inputTextStyle,
            readOnly: widget.isOnlyReady,
            decoration: InputDecoration(
              suffixIcon: widget.isPassword
                  ? IconButton(
                      color: kGreyScale600Color,
                      onPressed: _toggle,
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                    )
                  : widget.suffix ?? const SizedBox(),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 16,
              ),
              hintText: widget.hintText,
              hintStyle: inputTextStyle.copyWith(
                  color: kGreyScale900Color.withOpacity(0.45)),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: kWhiteColor,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: !widget.isOnlyReady ? kPrimaryColor : Colors.white,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: kRedColor,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: kRedColor,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusColor: kWhiteColor,
              filled: true,
              fillColor: kWhiteColor,
            ),
          ),
        ),
      ],
    );
  }
}

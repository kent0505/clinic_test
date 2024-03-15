import 'package:flutter/material.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/theme/text_styles.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String value) onChanged;

  const SearchTextField({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: widget.onChanged,
          obscureText: false,
          controller: widget.controller,
          scrollPadding: EdgeInsets.zero,
          style: inputTextStyle,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            prefixIcon: const Icon(
              Icons.search,
              color: kGreyScale700Color,
            ),
            hintText: "Поиск",
            hintStyle: inputTextStyle.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: kGreyScale700Color,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xff66788C),
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}

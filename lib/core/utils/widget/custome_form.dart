import 'package:flutter/material.dart';
import 'package:univs/core/resources/theme/app_style.dart';

class CustomFormField extends StatelessWidget {
  final String title;
  final bool obscureText;
  final TextEditingController? controller;
  final bool isShowTitle;
  final TextInputType? keyboardType;
  final Function(String)? onFieldSubmitted;

  const CustomFormField(
      {super.key,
      required this.title,
      this.obscureText = false,
      this.controller,
      this.isShowTitle = true,
      this.keyboardType,
      this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isShowTitle)
          Text(
            title,
            style: AppStyle.body2(
                fontWeight: FontWeight.w400, color: Colors.black),
          ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: !isShowTitle ? title : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
          onFieldSubmitted: onFieldSubmitted,
          validator: (input) => input == '' ? "Don't empty" : null,
        ),
      ],
    );
  }
}

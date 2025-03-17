// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:univs/core/resources/theme/colors.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final bool? obscureText;
  final int? maxLines;
  final bool required;
  final int? maxLength;
  final bool enable;
  final TextInputType? textInputType;

  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.label,
    this.hintText,
    this.inputFormatters,
    this.onChanged,
    this.suffixIcon,
    this.validator,
    this.prefixIcon,
    this.maxLength,
    this.obscureText,
    this.textInputType = TextInputType.text,
    this.maxLines = 1,
    this.enable = true,
    this.required = true,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: AppColors.colorGrey),
            children: <TextSpan>[
              TextSpan(text: widget.label),
              TextSpan(
                  text: widget.required ? '*' : ' (Opsional)',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: widget.required ? Colors.red : Colors.grey)),
            ],
          ),
        ),
        TextFormField(
          enabled: widget.enable,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.words,
          keyboardType: widget.textInputType,
          onChanged: widget.onChanged,
          controller: widget.controller,
          cursorColor: Colors.white,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          obscureText: widget.obscureText == true
              ? !_showPassword
              : (widget.obscureText ?? false),
          style: TextStyle(color: widget.enable ? Colors.black : Colors.grey),
          validator: widget.required
              ? widget.validator ??
                  (value) {
                    if (value?.isEmpty ?? false) {
                      return "${widget.label} Wajib diisi";
                    }
                    return null;
                  }
              : (value) => null,
          decoration: InputDecoration(
            suffixIcon: widget.obscureText == true
                ? buildSuffixIcon()
                : widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            contentPadding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
            isDense: true,
            hintText: widget.hintText ?? "",
          ),
        ),
      ],
    );
  }

  Widget buildSuffixIcon() {
    return IconButton(
      icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
      onPressed: () {
        setState(() {
          _showPassword = !_showPassword;
        });
      },
    );
  }
}

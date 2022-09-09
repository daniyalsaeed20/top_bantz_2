// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  bool obscureText;
  bool isEnabled;
  TextInputType keyboardType;
  final TextEditingController controller;
  int maxLines;
  bool isAutoValidate;
  bool isReadOnly;
  bool isPassword;
  final void Function() onTap;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;

  CustomTextField({
    required this.title,
    required this.controller,
    required this.validator,
    this.keyboardType = TextInputType.name,
    this.obscureText = false,
    this.isEnabled = true,
    this.maxLines = 1,
    this.onChanged,
    this.isAutoValidate = false,
    required this.onTap,
    this.isReadOnly = false,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: isAutoValidate
          ? AutovalidateMode.always
          : AutovalidateMode.onUserInteraction,
      maxLines: maxLines,
      controller: controller,
      validator: validator,
      style: const TextStyle(
        color: CustomColors.textMediumColor,
      ),
      readOnly: isReadOnly,
      enabled: isEnabled,
      onChanged: onChanged,
      onEditingComplete: () {},
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: CustomColors.textMediumColor,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? InkWell(
                splashColor: CustomColors.transparentColor,
                onTap: onTap,
                child: Icon(
                  Icons.visibility_outlined,
                  color: !obscureText
                      ? CustomColors.buttonDarkColor
                      : CustomColors.buttonLightColor,
                ),
              )
            : null,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: const BorderSide(
            color: CustomColors.buttonDarkColor,
          ),
        ),
        isDense: true,
        hintText: title,
        hintStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: CustomColors.textLightColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

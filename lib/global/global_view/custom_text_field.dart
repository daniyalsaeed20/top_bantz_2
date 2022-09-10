// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/constants/design.dart';

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
  final IconData prefixIcon;
  final bool hasFormatter;
  final bool isFillBlack;

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
    required this.prefixIcon,
    this.hasFormatter = false,
    this.isFillBlack = false,
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
      maxLength: hasFormatter ? 8 : null,
      inputFormatters: hasFormatter
          ? [
              FilteringTextInputFormatter.digitsOnly,
              CardNumberFormatter(controller: controller),
            ]
          : null,
      readOnly: isReadOnly,
      enabled: isEnabled,
      onChanged: onChanged,
      onEditingComplete: () {},
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: CustomColors.textMediumColor,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: CustomColors.textMediumColor,
          size: 30.r,
        ),
        suffixIcon: isPassword
            ? InkWell(
                splashColor: CustomColors.transparentColor,
                onTap: onTap,
                child: Icon(
                  !obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: CustomColors.textMediumColor,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Design.radius),
        ),
        fillColor: isFillBlack
            ? CustomColors.blackColor
            : CustomColors.foreGroundColor,
        filled: true,
        isDense: true,
        hintText: title,
        hintStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: CustomColors.textMediumColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  CardNumberFormatter({required this.controller});
  TextEditingController controller;
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 2 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write('-');
      }
    }

    var string = bufferString.toString();
    controller.text = newValue
        .copyWith(
          text: string,
          selection: TextSelection.collapsed(
            offset: string.length,
          ),
        )
        .text;
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

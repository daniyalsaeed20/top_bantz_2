// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  Color color;
  double fontSize;
  int maxLines;
  FontWeight fontWeight;
  TextAlign alignment;

  CustomText({
    required this.text,
    this.color = CustomColors.textDarkColor,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w300,
    this.maxLines = 1,
    this.alignment = TextAlign.center,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: color,
          fontSize: fontSize == 16 ? 28.sp : fontSize,
          fontWeight: fontWeight,
        ),
      ),
      textAlign: alignment,
    );
  }
}

// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/constants/design.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';

class CustomButton extends StatelessWidget {
  Color buttonColor;
  Color textColor;
  final void Function() onTap;
  double height;
  double fontSize;
  String text;
  FontWeight fontWeight;

  CustomButton({
    required this.text,
    required this.onTap,
    this.buttonColor = CustomColors.buttonDarkColor,
    this.height = 50,
    this.fontSize = 18,
    this.fontWeight = FontWeight.normal,
    this.textColor = CustomColors.textWhiteColor,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(
                  Design.radius,
                ),
              ),
              height: height == 50 ? 50.h : height,
              child: Center(
                child: CustomText(
                  text: text,
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

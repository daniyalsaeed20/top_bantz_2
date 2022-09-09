import 'package:flutter/material.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: CustomColors.backGroundColor,
        color: CustomColors.foreGroundColor,
      ),
    );
  }
}

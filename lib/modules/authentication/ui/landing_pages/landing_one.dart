import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';

class LandingOne extends StatelessWidget {
  const LandingOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backGroundColor,
        body: Center(
          child: Container(
            height: 223.h,
            width: 280.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/landing_images/logo.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/custom_colors.dart';
import '../../global/global_view/custom_button.dart';

class ExplaorePage extends StatelessWidget {
  const ExplaorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 67.w,
        child: CustomButton(
          height: 24.h,
          text: 'Join',
          fontSize: 14.sp,
          onTap: () {},
          hasGradient: false,
          buttonColor: CustomColors.foreGroundColor,
          textColor: CustomColors.textWhiteColor,
        ),
      ),
    );
  }
}
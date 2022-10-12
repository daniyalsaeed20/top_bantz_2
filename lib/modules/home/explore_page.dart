import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';

import '../../constants/custom_colors.dart';

class ExplaorePage extends StatelessWidget {
  const ExplaorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.foreGroundColor,
      body: Column(
        children: [
          const LinearProgressIndicator(
            backgroundColor: CustomColors.backGroundColor,
            color: CustomColors.textYellowColor,
          ),
          const Spacer(),
          CustomText(
            text: 'Coming Soon',
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: CustomColors.textWhiteColor,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

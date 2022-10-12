import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';

class MultiMediaOption extends StatelessWidget {
  MultiMediaOption({
    required this.icon,
    required this.title,
    this.onTap,
    Key? key,
  }) : super(key: key);

  IconData icon;
  String title;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80.w,
        height: 120.h,
        padding: EdgeInsets.all(3.r),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: CustomColors.blackColor.withOpacity(0.5),
              blurRadius: 0,
              spreadRadius: 0,
              offset: const Offset(0, 0),
            )
          ],
          border: Border.all(
            width: 2,
            color: CustomColors.backGroundColor,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: CustomColors.textWhiteColor,
            ),
            CustomText(
              text: title,
              fontSize: 16.sp,
              color: CustomColors.textWhiteColor,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/constants/design.dart';
import 'package:top_bantz_2/global/global_view/custom_button.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/modules/authentication/auth_controller.dart';
import 'dart:math' as math;

class CreateAvatar extends StatefulWidget {
  const CreateAvatar({Key? key}) : super(key: key);

  @override
  _CreateAvatarState createState() => _CreateAvatarState();
}

class _CreateAvatarState extends State<CreateAvatar> {
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Design.horizontalPadding),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 45.h,
                  ),
                  CustomText(
                    text: "Select Your \nAvatar",
                    color: CustomColors.textWhiteColor,
                    maxLines: 2,
                    alignment: TextAlign.left,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 27.h,
                  ),
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: 13.h,
                      spacing: 13.w,
                      children: [
                        for (int i = 0; i < _authController.feature.length; i++)
                          InkWell(
                            splashColor: CustomColors.transparentColor,
                            onTap: () {
                              _authController
                                  .currentSelectedAvatarFeature.value = i;
                            },
                            child: AvatarFeatureTile(
                              title: _authController.feature[i],
                              index: i,
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  AvatarFeatureOptions(),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 28.h),
                      child: Container(
                        height: 358.h,
                        width: 257.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Design.radius),
                          color: CustomColors.textYellowColor,
                          image: const DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(
                                'assets/images/avatar/avatar_temp.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  CustomButton(
                    text: 'Continue',
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 46.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AvatarFeatureTile extends StatelessWidget {
  AvatarFeatureTile({
    Key? key,
    required this.title,
    required this.index,
  }) : super(key: key);

  String title;
  int index;

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      builder: (_) {
        return index == _authController.currentSelectedAvatarFeature.value
            ? SizedBox(
                width: 100.w,
                child: CustomButton(
                  height: 40.h,
                  text: title,
                  onTap: () {},
                ),
              )
            : CustomText(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                text: title,
                color: CustomColors.textMediumColor,
              );
      },
    );
  }
}

class AvatarFeatureOptions extends StatelessWidget {
  AvatarFeatureOptions({Key? key}) : super(key: key);
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(builder: (authController) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < 10; i++)
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Container(
                    height: 50.h,
                    width: 50.w,
                    color: Color((math.Random().nextDouble() * 0xFFFFFF +
                                _authController
                                    .currentSelectedAvatarFeature.value)
                            .toInt())
                        .withOpacity(1.0)),
              ),
          ],
        ),
      );
    });
  }
}

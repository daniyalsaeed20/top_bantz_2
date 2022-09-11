// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/constants/design.dart';
import 'package:top_bantz_2/global/global_view/custom_button.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/modules/authentication/auth_controller.dart';
import 'package:top_bantz_2/modules/authentication/ui/sign_up/create_avatar.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';
import 'package:top_bantz_2/services/user_services.dart';

class SelectSubscriptionScreen extends StatefulWidget {
  const SelectSubscriptionScreen({Key? key}) : super(key: key);

  @override
  _SelectSubscriptionScreenState createState() =>
      _SelectSubscriptionScreenState();
}

class _SelectSubscriptionScreenState extends State<SelectSubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Design.horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 45.h,
                ),
                CustomText(
                  text: "Select Subscription",
                  color: CustomColors.textWhiteColor,
                  maxLines: 2,
                  alignment: TextAlign.left,
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: 27.h,
                ),
                for (int i = 0; i < 2; i++) SubscriptionTypeTile(index: i),
                SizedBox(
                  height: 27.h,
                ),
                CustomButton(
                  text: 'Continue',
                  onTap: () {
                    Get.to(() => const CreateAvatar());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubscriptionTypeTile extends StatelessWidget {
  SubscriptionTypeTile({
    Key? key,
    required this.index,
  }) : super(key: key);

  final AuthController _authController = Get.put(AuthController(
      userRepository: UserRepository(userServices: UserServices())));
  int index;

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(builder: (_) {
      return Padding(
        padding: EdgeInsets.only(bottom: 19.h),
        child: InkWell(
          onTap: () {
            _authController.selectedSubscription.value = index;
            index == 0
                ? _authController.userModel.isPremium = false
                : _authController.userModel.isPremium = true;
          },
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              if (index == _authController.selectedSubscription.value)
                Container(
                  height: 180.h,
                  width: 327.w,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xffF1E291),
                        Color(0xffDFAE00),
                        Color(0xffF1E291),
                        Color(0xffE0B108),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(Design.radius),
                  ),
                ),
              Container(
                height: index == _authController.selectedSubscription.value
                    ? 175.h
                    : 180.h,
                width: index == _authController.selectedSubscription.value
                    ? 322.w
                    : 327.w,
                decoration: BoxDecoration(
                  color: CustomColors.foreGroundColor,
                  borderRadius: BorderRadius.circular(Design.radius),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24.r),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: index == 0 ? 'Free' : 'Premium',
                            color: CustomColors.textWhiteColor,
                            maxLines: 2,
                            alignment: TextAlign.left,
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          const Spacer(),
                          if (index == 1)
                            CustomText(
                              text: '£20 / mo',
                              color: CustomColors.textYellowColor,
                              maxLines: 4,
                              alignment: TextAlign.left,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                        ],
                      ),
                      CustomText(
                        text: index == 0
                            ? 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.'
                            : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
                        color: CustomColors.textWhiteColor,
                        maxLines: 3,
                        alignment: TextAlign.left,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

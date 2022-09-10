// ignore_for_file: must_be_immutable, deprecated_member_use, avoid_print, use_build_context_synchronously, no_logic_in_create_state

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/constants/design.dart';
import 'package:top_bantz_2/global/global_view/custom_button.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/modules/home/home_navifation_page.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({
    Key? key,
    required this.userRepository,
  }) : super(key: key);
  UserRepository userRepository;
  @override
  Widget build(BuildContext context) {
    return Ui(userRepository: userRepository);
  }
}

class Ui extends StatefulWidget {
  Ui({
    Key? key,
    required this.userRepository,
  }) : super(key: key);
  UserRepository userRepository;
  @override
  State<Ui> createState() => _UiState(userRepository: userRepository);
}

class _UiState extends State<Ui> {
  _UiState({required this.userRepository});
  UserRepository userRepository;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backGroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Design.horizontalPadding),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 52.w, right: 52.w, bottom: 7.h, top: 30.h),
                child: CustomText(
                  alignment: TextAlign.left,
                  text: 'Verify Email',
                  color: CustomColors.textDarkColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 40.sp,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 52.w, right: 52.w, bottom: 33.h),
                child: CustomText(
                  alignment: TextAlign.center,
                  maxLines: 3,
                  text:
                      'A verification email has been sent to ${FirebaseAuth.instance.currentUser!.email}',
                  color: CustomColors.textYellowColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 25.h),
                child: InkWell(
                  onTap: () {
                    // BlocProvider.of<AuthBloc>(context)
                    //     .add(const VerifyEmailEvent());
                  },
                  child: CustomText(
                    text: 'Resend',
                    color: CustomColors.textYellowColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 100.h),
                child: CustomButton(
                  text: "Confirm",
                  onTap: () {
                    // BlocProvider.of<AuthBloc>(context)
                    //     .add(const CheckEmailVerificationEvent());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

emailNotVerified(BuildContext context) {
  return Scaffold.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[CustomText(text: 'Verification Failed')],
        ),
        backgroundColor: CustomColors.foreGroundColor,
      ),
    );
  ;
}

emailVerified(BuildContext context, UserRepository userRepository) {
  Get.off(HomeNavigationPage(
          userRepository: userRepository,
        ));
}

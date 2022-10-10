// ignore_for_file: deprecated_member_use, avoid_print, use_build_context_synchronously, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/constants/design.dart';
import 'package:top_bantz_2/global/global_view/custom_button.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/modules/authentication/auth_controller.dart';
import 'package:top_bantz_2/modules/authentication/ui/login/login_screen.dart';
import 'package:top_bantz_2/modules/authentication/ui/sign_up/sign_up_screen.dart';
import 'package:top_bantz_2/modules/home/main_navigation_page.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';
import 'package:top_bantz_2/services/user_services.dart';

class AuthenticationHome extends StatelessWidget {
  AuthenticationHome({Key? key, required this.userRepository})
      : super(key: key);

  UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return Ui(userRepository: userRepository);
  }
}

class Ui extends StatelessWidget {
  Ui({Key? key, required this.userRepository})
      : super(
          key: key,
        );

  UserRepository userRepository;
  late bool isOnlineChecker;

  _onBackPressed() {}

  final AuthController _authController = Get.put(
    AuthController(
      userRepository: UserRepository(
        userServices: UserServices(),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(),
      child: SafeArea(
        child: GetBuilder<AuthController>(initState: (_) async {
          isOnlineChecker = _authController.checkIsUserSignedIn();
          if (_authController.checkIsUserSignedIn() == true) {
            try {
              Future.delayed(const Duration(milliseconds: 100), () {
                openSnackbar(
                    title: 'Attempting auto-login', text: 'Please hold on...');
              });
              _authController.userModel =
                  await userRepository.getUserDocument();
              if (_authController.userModel.userName == '') {
                isOnlineChecker = false;
                _authController.update();
              }
              if (_authController.userModel.userName != '') {
                Get.to(
                  () => MainNavigationPage(
                    userRepository: UserRepository(
                      userServices: UserServices(),
                    ),
                  ),
                );
              }
            } catch (e) {
              openSnackbar(title: 'Error', text: e.toString());
            }
          }
        }, builder: (_) {
          return Scaffold(
            backgroundColor: CustomColors.backGroundColor,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 338.h,
                    width: 278.w,
                    decoration: BoxDecoration(
                      // color: CustomColors.foreGroundColor,
                      borderRadius: BorderRadius.circular(Design.radius),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/auth_bg.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 77.h,
                  ),
                  SizedBox(
                    width: 300,
                    child: CustomText(
                      text: 'Best Football Community',
                      color: CustomColors.textWhiteColor,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w600,
                      maxLines: 2,
                      alignment: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  SizedBox(
                    width: 253.w,
                    child: CustomText(
                      text:
                          'Discuss your favorite football teams with fellow supporters and receive the latest game updates.',
                      color: CustomColors.textMediumColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      maxLines: 4,
                      alignment: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  if (!isOnlineChecker)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 199.w,
                          child: CustomButton(
                            text: 'Login',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(
                                      userRepository: userRepository),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 39.w,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(
                                    userRepository: userRepository),
                              ),
                            );
                          },
                          child: CustomText(
                            text: 'Sign Up',
                            color: CustomColors.textMediumColor,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  if (isOnlineChecker)
                    LinearProgressIndicator(
                      color: CustomColors.textYellowColor,
                      backgroundColor: CustomColors.foreGroundColor,
                    )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void openSnackbar({
    required String title,
    required String text,
  }) {
    Get.snackbar(
      title,
      text,
      snackPosition: SnackPosition.TOP,
      backgroundColor: CustomColors.foreGroundColor,
      colorText: CustomColors.textWhiteColor,
    );
  }
}

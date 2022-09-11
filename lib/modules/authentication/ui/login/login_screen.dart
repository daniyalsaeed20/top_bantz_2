// ignore_for_file: deprecated_member_use, use_build_context_synchronously, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/constants/design.dart';
import 'package:top_bantz_2/constants/validators.dart';
import 'package:top_bantz_2/global/global_view/custom_button.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/global/global_view/custom_text_field.dart';
import 'package:top_bantz_2/modules/authentication/auth_controller.dart';
import 'package:top_bantz_2/modules/authentication/ui/sign_up/sign_up_screen.dart';
import 'package:top_bantz_2/modules/authentication/ui/verification_screen.dart';
import 'package:top_bantz_2/modules/home/home_navigation_page.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';
import 'package:top_bantz_2/services/user_services.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key, required this.userRepository}) : super(key: key);

  UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return Ui(userRepository: userRepository);
  }
}

class Ui extends StatelessWidget {
  Ui({Key? key, required this.userRepository}) : super(key: key);
  UserRepository userRepository;
  /* -------------------------------------------------------------------------- */
  /*                                  Variables                                 */
  /* -------------------------------------------------------------------------- */
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  final AuthController _authController = Get.put(
    AuthController(
      userRepository: UserRepository(
        userServices: UserServices(),
      ),
    ),
  );

  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backGroundColor,
        body: GetBuilder<AuthController>(initState: (_) {
          _authController.attemptLogin.value = false;
          _authController.successLogin.value = false;
          _authController.failedLogin.value = false;
          _authController.addListener(() {});
          _authController.attemptLogin.listen((value) async {
            if (value) {
              openSnackbar(
                  title: 'Attempting Login', text: 'Please hold on...');
              await _authController.loginUser(
                email: emailController.text,
                password: passwordController.text,
              );
              _authController.successLogin.value = true;
              _authController.attemptLogin.value = false;
            }
          });
          _authController.successLogin.listen(
            (value) {
              if (value) {
                openSnackbar(
                    title: 'Login Successful', text: 'You are all set...');
                _authController.successLogin.value = false;
                Get.to(
                  () => HomeNavigationPage(
                    userRepository: UserRepository(
                      userServices: UserServices(),
                    ),
                  ),
                );
              }
            },
          );
          _authController.failedLogin.listen((value) {
            if (value) {
              openSnackbar(
                  title: 'Login Failed', text: 'Oops... Something went wrong!');
              _authController.failedLogin.value = false;
            }
          });
        }, builder: (_) {
          return Stack(
            children: [
              Center(
                child: Column(
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
                    const SizedBox.shrink()
                  ],
                ),
              ),
              Column(
                children: [
                  const Spacer(),
                  Container(
                    height: 499.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(42.r),
                          topRight: Radius.circular(42.r),
                        ),
                        color: CustomColors.foreGroundColor),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Design.horizontalPadding),
                      child: Form(
                        key: _loginKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 39.h,
                              ),
                              CustomText(
                                text: "Welcome",
                                color: CustomColors.textWhiteColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 28.sp,
                                alignment: TextAlign.left,
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                              CustomTextField(
                                isFillBlack: true,
                                title: "Email",
                                controller: emailController,
                                validator: CustomValidators().emailValidator,
                                keyboardType: TextInputType.emailAddress,
                                onTap: () {},
                                prefixIcon: Icons.email_outlined,
                              ),
                              SizedBox(
                                height: (24).h,
                              ),
                              CustomTextField(
                                isFillBlack: true,
                                title: "Password",
                                controller: passwordController,
                                validator: CustomValidators().passwordValidator,
                                isPassword: true,
                                onTap: () {
                                  // _obscureText(
                                  //   context: context,
                                  //   state: state,
                                  // );
                                },
                                obscureText: true,
                                prefixIcon: Icons.password_outlined,
                              ),
                              SizedBox(
                                height: 26.h,
                              ),
                              SizedBox(
                                height: 41.h,
                              ),
                              CustomButton(
                                text: 'Sign in',
                                onTap: () async {
                                  if (_loginKey.currentState!.validate()) {
                                    _authController.attemptLogin.value = true;
                                  }
                                },
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 25.h, bottom: 100.h),
                                    child: CustomText(
                                      text: 'Don\'t have an account? ',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: CustomColors.textMediumColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 25.h, bottom: 100.h),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                SignUpScreen(
                                              userRepository: userRepository,
                                            ),
                                          ),
                                        );
                                      },
                                      child: CustomText(
                                        text: 'Sign up',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: CustomColors.textYellowColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
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

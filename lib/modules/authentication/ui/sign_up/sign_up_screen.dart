// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/constants/design.dart';
import 'package:top_bantz_2/constants/validators.dart';
import 'package:top_bantz_2/global/global_view/custom_button.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/global/global_view/custom_text_field.dart';
import 'package:top_bantz_2/models/user_model.dart';
import 'package:top_bantz_2/modules/authentication/auth_controller.dart';
import 'package:top_bantz_2/modules/authentication/ui/sign_up/select_team_screen.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';
import 'package:top_bantz_2/services/user_services.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key, required this.userRepository}) : super(key: key);
  UserRepository userRepository;
  @override
  Widget build(BuildContext context) {
    return Ui(userRepository: userRepository);
  }
}

class Ui extends StatefulWidget {
  Ui({Key? key, required this.userRepository}) : super(key: key);

  UserRepository userRepository;

  @override
  State<Ui> createState() => _UiState();
}

class _UiState extends State<Ui> {
  /* -------------------------------------------------------------------------- */
  final GlobalKey<FormState> _signupKey = GlobalKey<FormState>();

  final TextEditingController contactNumberController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController dateOfBirthController = TextEditingController();

  final AuthController _authController = Get.put(
    AuthController(
      userRepository: UserRepository(
        userServices: UserServices(),
      ),
    ),
  );

  /* -------------------------------------------------------------------------- */

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(initState: (_) {
      _authController.attemptRegistration.value = false;
      _authController.successRegistration.value = false;
      _authController.failedRegistration.value = false;
      _authController.addListener(() {});
      _authController.attemptRegistration.listen((value) async {
        if (value) {
          openSnackbar(
              title: 'Attempting Registration', text: 'Please hold on...');
          _getRegistrationData(
            contactNumber: contactNumberController.text,
            dateOfBirth: dateOfBirthController.text,
            email: emailController.text,
            userName: userNameController.text,
            password: passwordController.text,
          );
          await _authController.registerUser();
          _authController.successRegistration.value = true;
          _authController.attemptRegistration.value = false;
        }
      });
      _authController.successRegistration.listen((value) {
        if (value) {
          openSnackbar(
              title: 'Registration Successful',
              text: 'You are all set, onto next step...');
          _authController.successRegistration.value = false;
          Get.to(() => const SelectTeamScreen());
        }
      });
      _authController.failedRegistration.listen((value) {
        if (value) {
          openSnackbar(
              title: 'Registration Failed',
              text: 'Oops... Something went wrong!');
          _authController.failedRegistration.value = false;
        }
      });
    }, builder: (_) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: CustomColors.backGroundColor,
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Design.horizontalPadding,
            ),
            child: Form(
              key: _signupKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      alignment: TextAlign.left,
                      text: "Register New Account",
                      color: CustomColors.textWhiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 36.sp,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: (24).h,
                    ),
                    CustomTextField(
                      title: "Full Name",
                      controller: userNameController,
                      validator: CustomValidators().userNameValidator,
                      keyboardType: TextInputType.name,
                      onTap: () {},
                      prefixIcon: Icons.account_circle_outlined,
                    ),
                    SizedBox(
                      height: (24).h,
                    ),
                    CustomTextField(
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
                      hasFormatter: true,
                      title: "Date of Birth",
                      controller: dateOfBirthController,
                      validator: CustomValidators().fieldValidator,
                      keyboardType: TextInputType.number,
                      onTap: () {},
                      prefixIcon: Icons.date_range,
                    ),
                    CustomTextField(
                        title: "Contact Number",
                        controller: contactNumberController,
                        validator: CustomValidators().fieldValidator,
                        keyboardType: TextInputType.number,
                        onTap: () {},
                        prefixIcon: Icons.phone_enabled_outlined),
                    SizedBox(
                      height: (24).h,
                    ),
                    Column(
                      children: [
                        CustomTextField(
                          title: "Password",
                          controller: passwordController,
                          validator: CustomValidators().passwordValidator,
                          isPassword: true,
                          onTap: () {
                            _changePasswordVisibility();
                          },
                          obscureText: _authController.isPasswordVisible.value,
                          prefixIcon: Icons.password_outlined,
                        ),
                        SizedBox(
                          height: (24).h,
                        ),
                        CustomTextField(
                          title: "Confirm Password",
                          controller: confirmPasswordController,
                          validator: CustomValidators().passwordValidator,
                          isPassword: true,
                          onTap: () {
                            _changePasswordVisibility();
                          },
                          obscureText: _authController.isPasswordVisible.value,
                          prefixIcon: Icons.password_outlined,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: (65).h,
                    ),
                    if (!_authController.attemptRegistration.value)
                      CustomButton(
                          text: 'Continue',
                          onTap: () {
                            if (_signupKey.currentState!.validate()) {
                              _authController.attemptRegistration.value = true;
                            }
                          }),
                    if (_authController.attemptRegistration.value)
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  Design.radius,
                                ),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xffF1E291),
                                    Color(0xffDFAE00),
                                    Color(0xffF1E291),
                                    Color(0xffE0B108),
                                  ],
                                ),
                              ),
                              height: 63.h,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: CustomColors.foreGroundColor,
                                ),
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
      );
    });
  }

  _changePasswordVisibility() {
    _authController.isPasswordVisible.value =
        !_authController.isPasswordVisible.value;
  }

  _getRegistrationData({
    required String userName,
    required String email,
    required String dateOfBirth,
    required String contactNumber,
    required String password,
  }) {
    _authController.userModel = UserModel(
      contactNumber: contactNumber,
      dateOfBirth: dateOfBirth,
      email: email,
      userId: '',
      userName: userName,
    );
    _authController.password = password;
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

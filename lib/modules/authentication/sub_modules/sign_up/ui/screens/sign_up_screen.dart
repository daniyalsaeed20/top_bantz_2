// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/constants/design.dart';
import 'package:top_bantz_2/constants/validators.dart';
import 'package:top_bantz_2/global/global_blocs/password_bloc/password_bloc.dart';
import 'package:top_bantz_2/global/global_view/custom_button.dart';
import 'package:top_bantz_2/global/global_view/custom_loader.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/global/global_view/custom_text_field.dart';
import 'package:top_bantz_2/modules/authentication/sub_modules/login/ui/screens/login_screen.dart';
import 'package:top_bantz_2/modules/authentication/sub_modules/sign_up/sign_up_bloc/sign_up_bloc.dart';
import 'package:top_bantz_2/modules/authentication/ui/screens/verification_screen.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key, required this.userRepository}) : super(key: key);
  UserRepository userRepository;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(userRepository: userRepository),
      child: Ui(userRepository: userRepository),
    );
  }
}

class Ui extends StatelessWidget {
  Ui({Key? key, required this.userRepository}) : super(key: key);

  UserRepository userRepository;

  /* -------------------------------------------------------------------------- */
  /*                                  VARIABLES                                 */
  /* -------------------------------------------------------------------------- */

  final GlobalKey<FormState> _signupKey = GlobalKey<FormState>();

  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backGroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Design.horizontalPadding,
          ),
          child: BlocListener<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is SignUpCredentialsState) {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => VerificationScreen(
                      userRepository: userRepository,
                    ),
                  ),
                );
              }
            },
            child: BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                if (state is SignUpCreateAccountProcessState) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: const CustomLoader(),
                  );
                }
                return BlocProvider(
                  create: (context) => PasswordBloc(),
                  child: Form(
                    key: _signupKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 226.h,
                          ),
                          CustomText(
                            text: "Sign Up",
                            color: CustomColors.textDarkColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 40.sp,
                          ),
                          CustomText(
                            text: "First create your account",
                            color: CustomColors.textLightColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                          ),
                          SizedBox(
                            height: (7.5).h,
                          ),
                          CustomTextField(
                            title: "Full Name",
                            controller: fullNameController,
                            validator: CustomValidators().fullNameValidator,
                            keyboardType: TextInputType.name,
                            onTap: () {},
                          ),
                          SizedBox(
                            height: (7.5).h,
                          ),
                          CustomTextField(
                            title: "Email",
                            controller: emailController,
                            validator: CustomValidators().emailValidator,
                            keyboardType: TextInputType.emailAddress,
                            onTap: () {},
                          ),
                          SizedBox(
                            height: (7.5).h,
                          ),
                          CustomTextField(
                            title: "Contact Number",
                            controller: contactNumberController,
                            validator: CustomValidators().fieldValidator,
                            keyboardType: TextInputType.number,
                            onTap: () {},
                          ),
                          SizedBox(
                            height: (7.5).h,
                          ),
                          BlocBuilder<PasswordBloc, PasswordState>(
                            builder: (context, state) {
                              return Column(
                                children: [
                                  CustomTextField(
                                    title: "Password",
                                    controller: passwordController,
                                    validator:
                                        CustomValidators().passwordValidator,
                                    isPassword: true,
                                    onTap: () {
                                      _obscureText(
                                        context: context,
                                        state: state,
                                      );
                                    },
                                    obscureText: state.obscureText,
                                  ),
                                  SizedBox(
                                    height: (7.5).h,
                                  ),
                                  CustomTextField(
                                    title: "Confirm Password",
                                    controller: confirmPasswordController,
                                    validator:
                                        CustomValidators().passwordValidator,
                                    isPassword: true,
                                    onTap: () {
                                      _obscureText(
                                        context: context,
                                        state: state,
                                      );
                                    },
                                    obscureText: state.obscureText,
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: (65).h,
                          ),
                          CustomButton(
                              text: 'Continue',
                              onTap: () {
                                _signUpCredentialsToLicense(context: context);
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 25.h, bottom: 100.h),
                                child: CustomText(
                                  text: 'Already have an account? ',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: CustomColors.textDarkColor,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 25.h, bottom: 100.h),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              LoginScreen(
                                                userRepository:
                                                    userRepository,
                                              )),
                                    );
                                  },
                                  child: CustomText(
                                    text: 'Login',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: CustomColors.textMediumColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _signUpCredentialsToLicense({required BuildContext context}) {
    BlocProvider.of<SignUpBloc>(context).add(
      SignUpCredentialsEvent(
        confirmPassword: confirmPasswordController.text,
        contactNumber: contactNumberController.text,
        email: emailController.text,
        fullName: fullNameController.text,
        password: passwordController.text,
      ),
    );
  }

  void _obscureText(
      {required PasswordState state, required BuildContext context}) {
    if (state.obscureText == false) {
      BlocProvider.of<PasswordBloc>(context)
          .add(HidePasswordEvent(obscureText: true));
    } else if (state.obscureText == true) {
      BlocProvider.of<PasswordBloc>(context)
          .add(ShowPasswordEvent(obscureText: false));
    }
  }
}

// ignore_for_file: deprecated_member_use, use_build_context_synchronously, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/constants/design.dart';
import 'package:top_bantz_2/constants/validators.dart';
import 'package:top_bantz_2/global/global_blocs/password_bloc/password_bloc.dart';
import 'package:top_bantz_2/global/global_view/custom_button.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/global/global_view/custom_text_field.dart';
import 'package:top_bantz_2/modules/authentication/sub_modules/login/login_bloc/login_bloc.dart';
import 'package:top_bantz_2/modules/authentication/sub_modules/sign_up/ui/screens/sign_up_screen.dart';
import 'package:top_bantz_2/modules/authentication/ui/screens/verification_screen.dart';
import 'package:top_bantz_2/modules/home/home_navifation_page.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key, required this.userRepository}) : super(key: key);

  UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(userRepository: userRepository),
      child: Ui(userRepository: userRepository),
    );
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
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state is LoginEmailVerifiedState) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => HomeNavigationPage(
                        userRepository: userRepository,
                      ),
                    ),
                    (Route<dynamic> route) => false);
              } else if (state is LoginEmailNotVerifiedState) {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => VerificationScreen(
                      userRepository: userRepository,
                    ),
                  ),
                );
              } else if (state is LoginFailedState) {
                Scaffold.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomText(
                            text: 'Login Failed',
                            fontSize: 16.sp,
                          )
                        ],
                      ),
                      backgroundColor: CustomColors.foreGroundColor,
                    ),
                  );
              } else if (state is AttemptLoginState) {
                Scaffold.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomText(
                            text: 'Logging in',
                            fontSize: 16.sp,
                          ),
                          const CircularProgressIndicator(
                            color: CustomColors.foreGroundColor,
                            backgroundColor: CustomColors.backGroundColor,
                          )
                        ],
                      ),
                      backgroundColor: CustomColors.foreGroundColor,
                    ),
                  );
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return BlocProvider(
                  create: (context) => PasswordBloc(),
                  child: Form(
                    key: _loginKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 226.h,
                          ),
                          CustomText(
                            text: "Login",
                            color: CustomColors.textDarkColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 40.sp,
                          ),
                          CustomText(
                            text: "Enter your email and password",
                            color: CustomColors.textLightColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
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
                          BlocBuilder<PasswordBloc, PasswordState>(
                            builder: (context, state) {
                              return CustomTextField(
                                title: "Password",
                                controller: passwordController,
                                validator: CustomValidators().passwordValidator,
                                isPassword: true,
                                onTap: () {
                                  _obscureText(
                                    context: context,
                                    state: state,
                                  );
                                },
                                obscureText: state.obscureText,
                              );
                            },
                          ),
                          SizedBox(
                            height: (65).h,
                          ),
                          CustomButton(
                            text: 'Login',
                            onTap: () async {
                              if (_loginKey.currentState!.validate()) {
                                BlocProvider.of<LoginBloc>(context)
                                    .add(AttemptLoginEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ));
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 25.h, bottom: 100.h),
                                child: CustomText(
                                  text: 'Don\'t have an account? ',
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
                                            SignUpScreen(
                                          userRepository: userRepository,
                                        ),
                                      ),
                                    );
                                  },
                                  child: CustomText(
                                    text: 'Sign up',
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

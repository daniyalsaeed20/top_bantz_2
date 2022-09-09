// ignore_for_file: deprecated_member_use, avoid_print, use_build_context_synchronously, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/constants/design.dart';
import 'package:top_bantz_2/global/global_view/custom_button.dart';
import 'package:top_bantz_2/global/global_view/custom_loader.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/modules/authentication/auth_bloc/auth_bloc.dart';
import 'package:top_bantz_2/modules/authentication/sub_modules/login/ui/screens/login_screen.dart';
import 'package:top_bantz_2/modules/authentication/sub_modules/sign_up/ui/screens/sign_up_screen.dart';
import 'package:top_bantz_2/modules/home/home_navifation_page.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';

class AuthenticationHome extends StatelessWidget {
  AuthenticationHome({Key? key, required this.userRepository})
      : super(key: key);

  UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        userRepository: userRepository,
      )..add(const AuthStartedEvent()),
      child: Ui(userRepository: userRepository),
    );
  }
}

class Ui extends StatelessWidget {
  Ui({Key? key, required this.userRepository})
      : super(
          key: key,
        );

  UserRepository userRepository;

  _onBackPressed(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => AuthenticationHome(
            userRepository: userRepository,
          ),
        ),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: CustomColors.backGroundColor,
          body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) async {
              if (state is AuthStartedState) {
                Scaffold.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomText(
                            text: 'Attempting auto-login',
                            fontSize: 16.sp,
                          ),
                          const Spacer(),
                          const CircularProgressIndicator(
                            color: CustomColors.foreGroundColor,
                            backgroundColor: CustomColors.backGroundColor,
                          ),
                        ],
                      ),
                      backgroundColor: CustomColors.foreGroundColor,
                    ),
                  );
              }
              if (state is AuthSuccessState) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => HomeNavigationPage(
                        userRepository: userRepository,
                      ),
                    ),
                    (Route<dynamic> route) => false);
              }
              if (state is AuthFailedState) {
                Scaffold.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomText(
                            text: 'Auto-login attempt failed',
                            fontSize: 16.sp,
                          ),
                          const Spacer(),
                          const Icon(Icons.not_interested)
                        ],
                      ),
                      backgroundColor: CustomColors.foreGroundColor,
                    ),
                  );
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthStartedState) {
                  return const CustomLoader();
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 225.h,
                      width: 350.w,
                      decoration: BoxDecoration(
                        color: CustomColors.foreGroundColor,
                        borderRadius: BorderRadius.circular(Design.radius),
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          colorFilter: ColorFilter.mode(
                              CustomColors.buttonLightColor, BlendMode.color),
                          image: const AssetImage('assets/images/card_bg.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 117.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Design.horizontalPadding),
                      child: CustomButton(
                        text: 'Login',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LoginScreen(userRepository: userRepository),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 31.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Design.horizontalPadding),
                      child: CustomButton(
                        text: 'Sign Up',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SignUpScreen(userRepository: userRepository),
                            ),
                          );
                        },
                        buttonColor: CustomColors.buttonLightColor,
                        textColor: CustomColors.textMediumColor,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

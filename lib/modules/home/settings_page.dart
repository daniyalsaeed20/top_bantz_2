import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:top_bantz_2/constants/validators.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/global/global_view/custom_text_field.dart';
import 'package:top_bantz_2/modules/home/send_email_screen.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';

import '../../constants/custom_colors.dart';
import '../../global/global_view/custom_button.dart';
import '../authentication/ui/authentication_home.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key, required this.userRepository}) : super(key: key);

  final UserRepository userRepository;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backGroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              Container(
                height: 100.h,
                width: 100.w,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/landing_images/logo.png'),
                  ),
                ),
              ),
              CircleAvatar(
                backgroundColor: CustomColors.textYellowColor,
                radius: 50.r,
                backgroundImage: NetworkImage(UserRepository.userModel.image),
              ),
              CustomText(
                text: UserRepository.userModel.userName,
                color: CustomColors.textWhiteColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                alignment: TextAlign.left,
              ),
              SizedBox(
                height: 25.h,
              ),
              ListTile(
                // tileColor: CustomColors.foreGroundColor,
                leading: const Icon(
                  Icons.currency_pound,
                  color: CustomColors.textWhiteColor,
                ),
                title: CustomText(
                  text: "Your coins",
                  color: CustomColors.textWhiteColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  alignment: TextAlign.left,
                ),
                trailing: CustomText(
                  text: UserRepository.userModel.points.toString(),
                  color: CustomColors.textYellowColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  alignment: TextAlign.left,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100.w,
                    child: CustomButton(
                      height: 50.h,
                      text: 'My Profile',
                      fontSize: 14.sp,
                      onTap: () {
                        setState(() {
                          _selectedIndex = 0;
                        });
                      },
                      hasGradient: _selectedIndex == 0 ? true : false,
                      buttonColor: _selectedIndex != 0
                          ? CustomColors.transparentColor
                          : CustomColors.transparentColor,
                      textColor: CustomColors.textWhiteColor,
                    ),
                  ),
                  SizedBox(
                    width: 100.w,
                    child: CustomButton(
                      height: 50.h,
                      text: 'Activity',
                      fontSize: 14.sp,
                      onTap: () {
                        setState(() {
                          _selectedIndex = 1;
                        });
                      },
                      hasGradient: _selectedIndex == 1 ? true : false,
                      buttonColor: _selectedIndex != 1
                          ? CustomColors.transparentColor
                          : CustomColors.transparentColor,
                      textColor: CustomColors.textWhiteColor,
                    ),
                  ),
                  SizedBox(
                    width: 100.w,
                    child: CustomButton(
                      height: 50.h,
                      text: 'Settings',
                      fontSize: 14.sp,
                      onTap: () {
                        setState(() {
                          _selectedIndex = 2;
                        });
                      },
                      hasGradient: _selectedIndex == 2 ? true : false,
                      buttonColor: _selectedIndex != 2
                          ? CustomColors.transparentColor
                          : CustomColors.transparentColor,
                      textColor: CustomColors.textWhiteColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              if (_selectedIndex == 0)
                Expanded(
                    child: ProfileView(
                  userRepository: widget.userRepository,
                )),
              if (_selectedIndex == 1) const Expanded(child: ActivityView()),
              if (_selectedIndex == 2) Expanded(child: SettingsView()),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Get.offAll(AuthenticationHome(
                    userRepository: widget.userRepository,
                  ));
                },
                child: ListTile(
                  tileColor: CustomColors.foreGroundColor,
                  leading: const Icon(
                    Icons.logout,
                    color: CustomColors.textYellowColor,
                  ),
                  title: CustomText(
                    text: "Logout",
                    color: CustomColors.textYellowColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    alignment: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  ProfileView({Key? key, required this.userRepository}) : super(key: key);
  ExpandedTileController _controllerOne = ExpandedTileController();
  ExpandedTileController _controllerTwo = ExpandedTileController();
  ExpandedTileController _controllerThree = ExpandedTileController();
  ExpandedTileController _controllerFour = ExpandedTileController();

  UserRepository userRepository;

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _addressKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ExpandedTile(
            theme: ExpandedTileThemeData(
              headerColor: CustomColors.foreGroundColor,
              headerRadius: 0.0,
              headerSplashColor: Colors.red,
              contentBackgroundColor:
                  CustomColors.foreGroundColor.withOpacity(0.5),
              contentRadius: 0.0,
            ),
            controller: _controllerOne,
            leading: const Icon(
              Icons.account_box_outlined,
              color: CustomColors.textWhiteColor,
            ),
            title: CustomText(
              text: "Name: ${UserRepository.userModel.userName}",
              color: CustomColors.textWhiteColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              alignment: TextAlign.left,
            ),
            content: Form(
              key: _nameKey,
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      title: 'New Name',
                      controller: nameController,
                      validator: CustomValidators().userNameValidator,
                      onTap: () {},
                      prefixIcon: Icons.account_box,
                    ),
                  ),
                  SizedBox(
                    width: 50.w,
                    height: 55.h,
                    child: CustomButton(
                        onTap: () async {
                          if (_nameKey.currentState!.validate()) {
                            userRepository.getUserDocument().userName =
                                nameController.text;
                            await userRepository.updateUserData();
                          }
                        },
                        text: ''),
                  )
                ],
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            tileColor: CustomColors.foreGroundColor,
            leading: const Icon(
              Icons.mark_email_read_outlined,
              color: CustomColors.textWhiteColor,
            ),
            title: CustomText(
              text: 'Email: ${UserRepository.userModel.email}',
              color: CustomColors.textWhiteColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              alignment: TextAlign.left,
            ),
          ),
          SizedBox(height: 7.h),
          ExpandedTile(
            theme: ExpandedTileThemeData(
              headerColor: CustomColors.foreGroundColor,
              headerRadius: 0.0,
              headerSplashColor: Colors.red,
              contentBackgroundColor:
                  CustomColors.foreGroundColor.withOpacity(0.5),
              contentRadius: 0.0,
            ),
            controller: _controllerThree,
            leading: const Icon(
              Icons.account_box_outlined,
              color: CustomColors.textWhiteColor,
            ),
            title: CustomText(
              text: "Phone: ${UserRepository.userModel.contactNumber}",
              color: CustomColors.textWhiteColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              alignment: TextAlign.left,
            ),
            content: Form(
              key: _phoneKey,
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      title: 'New Number',
                      controller: numberController,
                      validator: CustomValidators().userNameValidator,
                      onTap: () {},
                      prefixIcon: Icons.account_box,
                    ),
                  ),
                  SizedBox(
                    width: 50.w,
                    height: 55.h,
                    child: CustomButton(
                        onTap: () async {
                          if (_phoneKey.currentState!.validate()) {
                            userRepository.getUserDocument().contactNumber =
                                numberController.text;
                            await userRepository.updateUserData();
                          }
                        },
                        text: ''),
                  )
                ],
              ),
            ),
            onTap: () {},
          ),
          ExpandedTile(
            theme: ExpandedTileThemeData(
              headerColor: CustomColors.foreGroundColor,
              headerRadius: 0.0,
              headerSplashColor: Colors.red,
              contentBackgroundColor:
                  CustomColors.foreGroundColor.withOpacity(0.5),
              contentRadius: 0.0,
            ),
            controller: _controllerFour,
            leading: const Icon(
              Icons.account_box_outlined,
              color: CustomColors.textWhiteColor,
            ),
            title: CustomText(
              text: "Address: ${UserRepository.userModel.address}",
              color: CustomColors.textWhiteColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              alignment: TextAlign.left,
            ),
            content: Form(
              key: _addressKey,
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      title: 'New Address',
                      controller: addressController,
                      validator: CustomValidators().userNameValidator,
                      onTap: () {},
                      prefixIcon: Icons.account_box,
                    ),
                  ),
                  SizedBox(
                    width: 50.w,
                    height: 55.h,
                    child: CustomButton(
                        onTap: () async {
                          if (_addressKey.currentState!.validate()) {
                            userRepository.getUserDocument().address =
                                addressController.text;
                            await userRepository.updateUserData();
                          }
                        },
                        text: ''),
                  )
                ],
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class ActivityView extends StatelessWidget {
  const ActivityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SettingsView extends StatelessWidget {
  SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(
            Icons.payment,
            color: CustomColors.textWhiteColor,
          ),
          title: CustomText(
            text: "Change Payment Options",
            color: CustomColors.textWhiteColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            alignment: TextAlign.left,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: CustomColors.textWhiteColor,
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(EmailSender());
          },
          child: ListTile(
            leading: const Icon(
              Icons.mark_email_read_outlined,
              color: CustomColors.textWhiteColor,
            ),
            title: CustomText(
              text: "Email Support",
              color: CustomColors.textWhiteColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              alignment: TextAlign.left,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: CustomColors.textWhiteColor,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.support_agent,
            color: CustomColors.textWhiteColor,
          ),
          title: CustomText(
            text: "Chat Support",
            color: CustomColors.textWhiteColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            alignment: TextAlign.left,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: CustomColors.textWhiteColor,
          ),
        ),
        ListTile(
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: CustomColors.textWhiteColor,
          ),
          leading: const Icon(
            Icons.foundation,
            color: CustomColors.textWhiteColor,
          ),
          title: CustomText(
            text: "Donate",
            color: CustomColors.textWhiteColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            alignment: TextAlign.left,
          ),
        ),
      ],
    );
  }
}

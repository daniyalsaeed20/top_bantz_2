// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/constants/design.dart';
import 'package:top_bantz_2/global/global_view/custom_button.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/modules/authentication/auth_controller.dart';
import 'package:top_bantz_2/modules/authentication/ui/sign_up/select_subscription_screen.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';
import 'package:top_bantz_2/services/user_services.dart';

class SelectTeamScreen extends StatefulWidget {
  const SelectTeamScreen({Key? key, required this.userRepository})
      : super(key: key);
  final UserRepository userRepository;
  @override
  _SelectTeamScreenState createState() => _SelectTeamScreenState();
}

class _SelectTeamScreenState extends State<SelectTeamScreen> {
  late AuthController _authController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authController =
        Get.put(AuthController(userRepository: widget.userRepository));
  }

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
                  text: "Select The Team \nYou Support",
                  color: CustomColors.textWhiteColor,
                  maxLines: 2,
                  alignment: TextAlign.left,
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  text: "You can choose any one",
                  color: CustomColors.textMediumColor,
                  maxLines: 2,
                  alignment: TextAlign.left,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 27.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: 13.h,
                      spacing: 13.w,
                      children: [
                        for (int i = 0;
                            i < _authController.teamImages.length;
                            i++)
                          InkWell(
                            splashColor: CustomColors.transparentColor,
                            onTap: () {
                              _authController.teamIndex.value = i;
                               UserRepository.userModel.groupId =
                                  _authController.teamGroups[i];
                            },
                            child: TeamLogoCard(
                              image: _authController.teamImages[i],
                              index: i,
                              userRepository: widget.userRepository,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  text: 'Continue',
                  onTap: () {
                    UserServices().updateUserDocument(
                      userId: FirebaseAuth.instance.currentUser!.uid,
                      toMap:  UserRepository.userModel.toMap(),
                    );
                    Get.to(
                      () => SelectSubscriptionScreen(
                        userRepository: widget.userRepository,
                      ),
                    );
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

class TeamLogoCard extends StatefulWidget {
  TeamLogoCard({
    Key? key,
    required this.image,
    required this.index,
    required this.userRepository,
  }) : super(key: key);

  String image;
  int index;
  UserRepository userRepository;

  @override
  State<TeamLogoCard> createState() => _TeamLogoCardState();
}

class _TeamLogoCardState extends State<TeamLogoCard> {
  late AuthController _authController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authController =
        Get.put(AuthController(userRepository: widget.userRepository));
  }

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      builder: (_) {
        return Container(
          height: 71.h,
          width: 71.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Design.radius),
            color: widget.index != _authController.teamIndex.value
                ? CustomColors.foreGroundColor
                : CustomColors.textYellowColor,
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(
                widget.image,
              ),
            ),
          ),
        );
      },
    );
  }
}

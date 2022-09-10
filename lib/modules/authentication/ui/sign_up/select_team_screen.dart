import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/constants/design.dart';
import 'package:top_bantz_2/global/global_view/custom_button.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/modules/authentication/auth_controller.dart';
import 'package:top_bantz_2/modules/authentication/ui/sign_up/create_avatar.dart';
import 'package:top_bantz_2/modules/authentication/ui/sign_up/select_subscription_screen.dart';

class SelectTeamScreen extends StatefulWidget {
  const SelectTeamScreen({Key? key}) : super(key: key);

  @override
  _SelectTeamScreenState createState() => _SelectTeamScreenState();
}

class _SelectTeamScreenState extends State<SelectTeamScreen> {
  final AuthController _authController = Get.put(AuthController());

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
                  text: "You can choose more than one",
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
                            },
                            child: TeamLogoCard(
                              image: _authController.teamImages[i],
                              index: i,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  text: 'Continue',
                  onTap: () {
                    Get.to(() => SelectSubscriptionScreen());
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

class TeamLogoCard extends StatelessWidget {
  TeamLogoCard({
    Key? key,
    required this.image,
    required this.index,
  }) : super(key: key);

  String image;
  int index;

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      builder: (_) {
        return Container(
          height: 71.h,
          width: 71.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Design.radius),
            color: index != _authController.teamIndex.value
                ? CustomColors.foreGroundColor
                : CustomColors.textYellowColor,
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(
                image,
              ),
            ),
          ),
        );
      },
    );
  }
}

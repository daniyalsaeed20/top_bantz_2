// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/constants/design.dart';
import 'package:top_bantz_2/global/global_view/custom_button.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';

class HomeNavigationPage extends StatelessWidget {
  HomeNavigationPage({
    Key? key,
    required this.userRepository,
  }) : super(key: key);
  UserRepository userRepository;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backGroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              HomePageAppBar(),
              const HomeNotificationCard(),
              const HomeTabBar(),
              const LeagueCard(),
              const HomeTabBar(),
              const BattleRoomCard(),
              const HomeTabBar(),
              const Lobbies(),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageAppBar extends StatelessWidget {
  HomePageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      color: CustomColors.backGroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 64.h,
            width: 83.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/landing_images/logo.png'),
              ),
            ),
          ),
          const Spacer(),
          Icon(
            Icons.search,
            color: CustomColors.textWhiteColor,
            size: 30.r,
          ),
          SizedBox(
            width: 12.w,
          ),
          Icon(
            Icons.notifications_none_outlined,
            color: CustomColors.textWhiteColor,
            size: 30.r,
          ),
          SizedBox(
            width: 12.w,
          ),
          Container(
            width: 95.w,
            height: 28.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xffF1E291),
                  Color(0xffDFAE00),
                  Color(0xffF1E291),
                  Color(0xffE0B108),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(90.r),
                bottomLeft: Radius.circular(90.r),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 4.w,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: CustomColors.backGroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(90.r)),
                  ),
                  child: Icon(
                    Icons.currency_pound,
                    color: CustomColors.textYellowColor,
                    size: 20.r,
                  ),
                ),
                SizedBox(
                  width: 7.w,
                ),
                CustomText(
                  text: '100',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeNotificationCard extends StatelessWidget {
  const HomeNotificationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 319.w,
      height: 200.h,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage('assets/images/notification_banner.png'),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 68.h,
            ),
            CustomText(
              text: 'Liverpool UEFA\nChampion League\nCelebration',
              maxLines: 3,
              color: CustomColors.textWhiteColor,
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              alignment: TextAlign.start,
            ),
            CustomText(
              text: 'Yesterday, 06.30 PM',
              color: CustomColors.textWhiteColor,
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              alignment: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: 28.w, right: 28.w, top: 20.h, bottom: 13.h),
      child: Row(
        children: [
          CustomText(
            text: 'Leagues',
            fontSize: 24.sp,
            fontWeight: FontWeight.w400,
            color: CustomColors.textWhiteColor,
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: CustomText(
              text: 'See All',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: CustomColors.textYellowColor,
            ),
          ),
        ],
      ),
    );
  }
}

class LeagueCard extends StatelessWidget {
  const LeagueCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.h,
      width: 319.w,
      decoration: BoxDecoration(
        color: CustomColors.foreGroundColor,
        borderRadius: BorderRadius.circular(Design.radius),
      ),
      child: Row(
        children: [
          SizedBox(width: 12.w),
          Container(
            height: 44.h,
            width: 51.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/landing_images/logo.png'),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          CustomText(
            text: 'Premier League',
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: CustomColors.textWhiteColor,
          ),
          const Spacer(),
          Container(
            height: 68.h,
            width: 59.w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xffF1E291),
                  Color(0xffDFAE00),
                  Color(0xffF1E291),
                  Color(0xffE0B108),
                ],
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Design.radius),
                bottomRight: Radius.circular(Design.radius),
              ),
            ),
            child: Center(
              child: CustomText(
                text: 'Join',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BattleRoomCard extends StatelessWidget {
  const BattleRoomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.h,
      width: 319.w,
      decoration: BoxDecoration(
        color: CustomColors.foreGroundColor,
        borderRadius: BorderRadius.circular(Design.radius),
      ),
      child: Row(
        children: [
          SizedBox(width: 12.w),
          SizedBox(
            width: 67.w,
            child: CustomButton(
              height: 24.h,
              text: 'Join',
              fontSize: 14.sp,
              onTap: () {},
              hasGradient: false,
              buttonColor: const Color(0xffDB0030),
              textColor: CustomColors.textWhiteColor,
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            height: 44.h,
            width: 51.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/landing_images/logo.png'),
              ),
            ),
          ),
          const Spacer(),
          CustomText(
            text: 'VS',
            fontSize: 24.sp,
            fontWeight: FontWeight.w400,
            color: CustomColors.textWhiteColor,
          ),
          const Spacer(),
          Container(
            height: 44.h,
            width: 51.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/landing_images/logo.png'),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          SizedBox(
            width: 67.w,
            child: CustomButton(
              height: 24.h,
              text: 'Join',
              fontSize: 14.sp,
              onTap: () {},
              hasGradient: false,
              buttonColor: const Color(0xff1C66CB),
              textColor: CustomColors.textWhiteColor,
            ),
          ),
          SizedBox(width: 12.w),
        ],
      ),
    );
  }
}

class Lobbies extends StatelessWidget {
  const Lobbies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: 13.h,
      spacing: 13.w,
      children: [
        for (int i = 0; i < 10; i++)
          InkWell(
            splashColor: CustomColors.transparentColor,
            onTap: () {},
            child: Container(
              height: 71.h,
              width: 71.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Design.radius),
                color: CustomColors.foreGroundColor,
                image: const DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(
                    'assets/images/leagues/barcelona.png',
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

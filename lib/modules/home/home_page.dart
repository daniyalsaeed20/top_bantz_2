import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../constants/custom_colors.dart';
import '../../constants/design.dart';
import '../../global/global_view/custom_button.dart';
import '../../global/global_view/custom_text.dart';
import '../../repositories/user_repository.dart';
import '../chat/group_chat_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.userRepository,
  }) : super(key: key);
  final UserRepository userRepository;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomePageAppBar(),
          const HomeNotificationCard(),
          HomeTabBar(
            title: 'Leagues',
            onTap: () {},
          ),
          LeagueCard(
            image: 'assets/images/landing_images/logo.png',
            onTap: () {},
            title: 'Premier League',
          ),
          HomeTabBar(
            title: 'Battle Room',
            onTap: () {},
          ),
          const BattleRoomCard(),
          HomeTabBar(
            title: 'Lobbies',
            onTap: () {},
          ),
          Lobbies(userRepository: userRepository),
        ],
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
  HomeTabBar({Key? key, required String title, required Function() onTap})
      : _title = title,
        _onTap = onTap,
        super(key: key);

  Function() _onTap;
  String _title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: 28.w, right: 28.w, top: 20.h, bottom: 13.h),
      child: Row(
        children: [
          CustomText(
            text: _title,
            fontSize: 24.sp,
            fontWeight: FontWeight.w400,
            color: CustomColors.textWhiteColor,
          ),
          const Spacer(),
          InkWell(
            onTap: _onTap,
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
  LeagueCard(
      {Key? key,
      required void Function() onTap,
      required String title,
      required String image})
      : _onTap = onTap,
        _title = title,
        _image = image,
        super(key: key);

  String _image;
  String _title;
  void Function()? _onTap;

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
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(_image),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          CustomText(
            text: _title,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: CustomColors.textWhiteColor,
          ),
          const Spacer(),
          InkWell(
            onTap: _onTap,
            child: Container(
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
  Lobbies({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  UserRepository _userRepository;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: 13.h,
      spacing: 13.w,
      children: [
        PaginateFirestore(
          //item builder type is compulsory.
          itemBuilder: (context, documentSnapshots, index) {
            final data = documentSnapshots[index].data() as Map?;
            return InkWell(
              splashColor: CustomColors.transparentColor,
              onTap: () {
                Get.to(
                  () => GroupChatScreen(
                    groupChatId: '',
                    groupName: '',
                    userModel: _userRepository.currentUser(),
                  ),
                );
              },
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
            );
          },
          // orderBy is compulsory to enable pagination
          query: FirebaseFirestore.instance
              .collection('groups')
              .orderBy('time', descending: true),
          //Change types accordingly
          itemBuilderType: PaginateBuilderType.listView,
          // to fetch real-time data
          isLive: true,
          reverse: true,
        ),
      ],
    );
  }
}

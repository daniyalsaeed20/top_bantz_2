// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';

class HomeNavigationPage extends StatelessWidget {
  HomeNavigationPage({
    Key? key,
    required this.userRepository,
  }) : super(key: key);
  UserRepository userRepository;
  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (context) => HomeDeliveryBloc(userRepository: userRepository)
    //     ..add(const HomeDeliveryIsOffLineEvent()),
    //   child: Ui(userRepository: userRepository),
    // );
    return SafeArea(child: Scaffold());
  }
}

// class Ui extends StatelessWidget {
//   const Ui({
//     Key? key,
//     required this.userRepository,
//   }) : super(key: key);

//   final UserRepository userRepository;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: CustomColors.foreGroundColor,
//           actions: [
//             BlocBuilder<HomeDeliveryBloc, HomeDeliveryState>(
//               builder: (context, state) {
//                 if (state is HomeDeliveryIsOnlineState) {
//                   return InkWell(
//                     onTap: () {
//                       BlocProvider.of<HomeDeliveryBloc>(context)
//                           .add(const HomeDeliveryAttemptOfflineEvent());
//                     },
//                     child: const CircleAvatar(
//                       backgroundColor: Colors.green,
//                       foregroundColor: CustomColors.foreGroundColor,
//                     ),
//                   );
//                 }
//                 if (state is HomeDeliveryAttemptOfflineState) {
//                   return InkWell(
//                     onTap: () {
//                       BlocProvider.of<HomeDeliveryBloc>(context)
//                           .add(const HomeDeliveryAttemptOfflineEvent());
//                     },
//                     child: const CircleAvatar(
//                       backgroundColor: CustomColors.transparentColor,
//                       foregroundColor: CustomColors.transparentColor,
//                       child: CircularProgressIndicator(),
//                     ),
//                   );
//                 }
//                 return const CircleAvatar(
//                   backgroundColor: Colors.red,
//                   foregroundColor: CustomColors.foreGroundColor,
//                 );
//               },
//             ),
//             SizedBox(
//               width: 10.w,
//             ),
//             const CircleAvatar(
//               backgroundColor: CustomColors.backGroundColor,
//               foregroundColor: CustomColors.foreGroundColor,
//             ),
//             SizedBox(
//               width: 25.w,
//             ),
//           ],
//         ),
//         extendBody: true,
//         backgroundColor: CustomColors.foreGroundColor,
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(43.r),
//               topRight: Radius.circular(43.r),
//             ),
//             color: CustomColors.backGroundColor,
//           ),
//           height: 42.h,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 35.w),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 Icon(
//                   Icons.home_outlined,
//                   color: CustomColors.foreGroundColor,
//                 ),
//                 Icon(
//                   Icons.monetization_on_outlined,
//                   color: CustomColors.foreGroundColor,
//                 ),
//                 Icon(
//                   Icons.checklist_outlined,
//                   color: CustomColors.foreGroundColor,
//                 ),
//                 Icon(
//                   Icons.settings_outlined,
//                   color: CustomColors.foreGroundColor,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         body: HomeDeliveryScreen(userRepository: userRepository),
//         drawer: CustomDrawer(
//           userRepository: userRepository,
//         ),
//       ),
//     );
//   }
// }

// class CustomDrawer extends StatelessWidget {
//   CustomDrawer({
//     Key? key,
//     required this.userRepository,
//   }) : super(key: key);

//   UserRepository userRepository;

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: CustomColors.backGroundColor,
//       child: Column(
//         children: [
//           DrawerHeader(
//             decoration: const BoxDecoration(
//               color: CustomColors.backGroundColor,
//             ),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('assets/images/logo.png'),
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           DrawerTile(
//             icon: Icons.money,
//             text: 'Earning',
//             onTap: () {},
//           ),
//           DrawerTile(
//             icon: Icons.query_stats_outlined,
//             text: 'My History',
//             onTap: () {},
//           ),
//           DrawerTile(
//             icon: Icons.account_circle_outlined,
//             text: 'Profile',
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ProfilePage(
//                     userRepository: userRepository,
//                   ),
//                 ),
//               );
//             },
//           ),
//           DrawerTile(
//             icon: Icons.question_mark,
//             text: 'F.A.Q',
//             onTap: () {},
//           ),
//           DrawerTile(
//             icon: Icons.notifications,
//             text: 'Notifications',
//             onTap: () {},
//           ),
//           DrawerTile(
//             icon: Icons.support_agent,
//             text: 'Help',
//             onTap: () {},
//           ),
//           Spacer(),
//           DrawerTile(
//             icon: Icons.logout,
//             text: 'Log out',
//             onTap: () {},
//             hasIcon: false,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(
//                   bottom: 17.h,
//                   right: 11.w,
//                 ),
//                 child: CustomText(
//                   text: 'Version 1.1.1',
//                   fontSize: 7.sp,
//                   fontWeight: FontWeight.w200,
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

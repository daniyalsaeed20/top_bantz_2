import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:top_bantz_2/constants/bindings.dart';
import 'package:top_bantz_2/constants/variables.dart';
import 'package:top_bantz_2/modules/authentication/ui/authentication_home.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';
import 'package:top_bantz_2/services/user_services.dart';

import 'modules/authentication/ui/sign_up/select_subscription_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ConstVar().designSize,
      builder: (context, _) {
        return GetMaterialApp(
          initialBinding: HomeBinding(),
          title: "TopBantz",
          debugShowCheckedModeBanner: false,
          // home: SignalR(),
          // home: CreateAvatar(),
          home: SelectSubscriptionScreen(
            userRepository: UserRepository(
              userServices: UserServices(),
            ),
          ),
          // home: EarnCoinPage(
          //   userRepository: UserRepository(
          //     userServices: UserServices(),
          //   ),
          // ),
          // home: AuthenticationHome(
          //   userRepository: UserRepository(
          //     userServices: UserServices(),
          //   ),
          // ),
        );
      },
    );
  }
}

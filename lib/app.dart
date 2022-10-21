import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:top_bantz_2/constants/bindings.dart';
import 'package:top_bantz_2/constants/variables.dart';
import 'package:top_bantz_2/models/chat_message_model.dart';
import 'package:top_bantz_2/models/user_model.dart';
import 'package:top_bantz_2/modules/authentication/ui/authentication_home.dart';
import 'package:top_bantz_2/modules/chat/widgets/video_box.dart';
import 'package:top_bantz_2/modules/home/settings_page.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';
import 'package:top_bantz_2/services/user_services.dart';

import 'constants/custom_colors.dart';
import 'modules/authentication/ui/sign_up/select_subscription_screen.dart';
import 'modules/chat/widgets/audio_box.dart';
import 'modules/chat/widgets/image_box.dart';
import 'modules/chat/widgets/text_bubble.dart';
import 'modules/home/settings_page.dart' as s;

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
            // home: SelectSubscriptionScreen(
            //   userRepository: UserRepository(
            //     userServices: UserServices(),
            //   ),
            // ),
            home: s.Settings(
              userRepository: UserRepository(
                userServices: UserServices(),
              ),
            )
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

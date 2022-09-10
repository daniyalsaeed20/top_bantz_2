import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:top_bantz_2/constants/bindings.dart';
import 'package:top_bantz_2/constants/variables.dart';
import 'package:top_bantz_2/modules/authentication/ui/authentication_home.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';
import 'package:top_bantz_2/services/user_services.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ConstVar().designSize,
      builder: (context, _) {
        return GetMaterialApp(
          initialBinding: HomeBinding(),
          title: "Celiver - Rider",
          debugShowCheckedModeBanner: false,
          home: AuthenticationHome(
            userRepository: UserRepository(
              userServices: UserServices(),
            ),
          ),
        );
      },
    );
  }
}

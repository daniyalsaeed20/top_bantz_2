import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_bantz_2/constants/variables.dart';
import 'package:top_bantz_2/modules/authentication/ui/screens/authentication_home.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';
import 'package:top_bantz_2/services/user_services.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(userServices: UserServices()),
      child: ScreenUtilInit(
        designSize: ConstVar().designSize,
        builder: (context, _) {
          return MaterialApp(
            title: "Celiver - Rider",
            debugShowCheckedModeBanner: false,
            home: AuthenticationHome(
              userRepository: RepositoryProvider.of<UserRepository>(context),
            ),
          );
        },
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';

import '../../constants/custom_colors.dart';
import '../../global/global_view/custom_button.dart';
import '../authentication/ui/authentication_home.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key,required this.userRepository}) : super(key: key);

  final UserRepository userRepository;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 67.w,
        child: CustomButton(
          height: 24.h,
          text: 'LogOut',
          fontSize: 14.sp,
          onTap: () {
            FirebaseAuth.instance.signOut();
            Get.off(AuthenticationHome(
              userRepository: userRepository,
            ));
          },
          hasGradient: false,
          buttonColor: const Color(0xffDB0030),
          textColor: CustomColors.textWhiteColor,
        ),
      ),
    );
  }
}

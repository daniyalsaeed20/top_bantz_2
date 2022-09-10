import 'package:get/get.dart';
import 'package:top_bantz_2/modules/authentication/auth_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
  }
}

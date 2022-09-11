import 'package:get/get.dart';
import 'package:top_bantz_2/modules/authentication/auth_controller.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';
import 'package:top_bantz_2/services/user_services.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(userRepository: UserRepository(userServices: UserServices())));
  }
}

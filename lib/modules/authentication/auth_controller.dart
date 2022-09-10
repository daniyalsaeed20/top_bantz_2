import 'package:get/get.dart';
import 'package:top_bantz_2/models/user_model.dart';

class AuthController extends GetxController {
  // AuthController({required UserServices userServices})
  //     : _userServices = userServices;

  /* -------------------------------------------------------------------------- */
  /*                              Private Variables                             */
  /* -------------------------------------------------------------------------- */
  // final UserServices _userServices;

  /* -------------------------------------------------------------------------- */
  /*                              Public Variables                              */
  /* -------------------------------------------------------------------------- */
  RxBool isPasswordVisible = true.obs;
  RxInt teamIndex = 999.obs;
  UserModel userModel = UserModel();
  late String password;

  RxInt currentSelectedAvatarFeature = 999.obs;

  RxInt selectedSubscription = 2.obs;

  /* -------------------------------------------------------------------------- */
  /*                                    Lists                                   */
  /* -------------------------------------------------------------------------- */

  List<String> teamImages = [
    'assets/images/leagues/Vector.png',
    'assets/images/leagues/barcelona.png',
    'assets/images/leagues/English_Football_League_Logo.png',
    'assets/images/leagues/spain.png',
    'assets/images/leagues/LaLiga_Santander_logo.png',
    'assets/images/leagues/UEFA_Champions_League_logo_2.png',
    'assets/images/leagues/Vector.png',
    'assets/images/leagues/barcelona.png',
    'assets/images/leagues/English_Football_League_Logo.png',
    'assets/images/leagues/spain.png',
    'assets/images/leagues/LaLiga_Santander_logo.png',
    'assets/images/leagues/UEFA_Champions_League_logo_2.png'
  ];

  List<String> teamGroups = [
    'Group1',
    'Group2',
    'Group3',
    'Group4',
    'Group5',
    'Group6',
    'Group7',
    'Group8',
    'Group9',
    'Group10',
    'Group11',
    'Group12',
  ];

  List<String> feature = [
    'Face',
    'Eyes',
    'Hair',
    'Clothes',
    'Color',
    'Mouth',
    'Nose',
    'Ear',
  ];
  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */
}

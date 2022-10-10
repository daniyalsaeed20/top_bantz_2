import 'package:get/get.dart';
import 'package:top_bantz_2/models/user_model.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';

enum RegistrationEvent {
  success,
  failure,
  inprocess,
  none,
}

class AuthController extends GetxController {
  AuthController({required UserRepository userRepository})
      : _userRepository = userRepository;

  /* -------------------------------------------------------------------------- */
  /*                              Private Variables                             */
  /* -------------------------------------------------------------------------- */
  final UserRepository _userRepository;

  /* -------------------------------------------------------------------------- */
  /*                              Public Variables                              */
  /* -------------------------------------------------------------------------- */
  RxBool isPasswordVisible = true.obs;
  RxInt teamIndex = 999.obs;
  UserModel userModel = UserModel();
  late String password;

  RxInt selectedSubscription = 2.obs;

  RxBool attemptRegistration = false.obs;
  RxBool successRegistration = false.obs;
  RxBool failedRegistration = false.obs;
  RxBool attemptLogin = false.obs;
  RxBool successLogin = false.obs;
  RxBool failedLogin = false.obs;

  RegistrationEvent registrationEventHandler = RegistrationEvent.none;

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

  registerUser() async {
    await _userRepository.registerWithCredentials(
      userModel: userModel,
      password: password,
    );
  }

  loginUser({required String email, required String password}) async {
    try {
      await _userRepository.signInWithCredentials(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }

  checkIsUserSignedIn() {
    return _userRepository.isSignedIn();
  }

  getUserData() async {
    await _userRepository.getUserDocument();
    userModel = _userRepository.currentUser();
  }
}

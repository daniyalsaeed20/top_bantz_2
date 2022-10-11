import 'package:get/state_manager.dart';
import 'package:screenshot/screenshot.dart';

class AvatarController extends GetxController {
  ScreenshotController sstController = ScreenshotController();

  List<String> shirtList = [
    'assets/white_kit/shirt.png',
    'assets/white_kit/shirt_two.png'
  ];
  List<String> legsList = [
    'assets/white_kit/legs.png',
  ];
  List<String> shoeList = [
    'assets/white_kit/shoe.png',
  ];
  List<String> shortsList = [
    'assets/white_kit/shorts.png',
  ];
  List<String> leftArmList = [
    'assets/white_kit/left_arm.png',
  ];
  List<String> rightArmList = [
    'assets/white_kit/right_arm.png',
  ];
  List<String> faceList = [
    'assets/white_kit/face.png',
  ];
  List<String> hairList = [
    'assets/white_kit/hair.png',
  ];
  List<String> eyesList = [
    'assets/white_kit/eyes.png',
  ];
  List<String> noseList = [
    'assets/white_kit/nose.png',
  ];
  List<String> eyeBrowsList = [
    'assets/white_kit/eye_brows.png',
  ];
  List<String> mouthList = [
    'assets/white_kit/mouth.png',
  ];

  int selectedShirt = 0;
  int selectedShorts = 0;
  int selectedLegs = 0;
  int selectedShoes = 0;
  int selectedFace = 0;
  int selectedHair = 0;
  int selectedEyes = 0;
  int selectedNose = 0;
  int selectedEyesBrows = 0;
  int selectedMouth = 0;
}

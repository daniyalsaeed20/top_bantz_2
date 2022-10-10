// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/global/global_view/custom_button.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/modules/home/home_page.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';

import 'avatar_controller.dart';

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
AvatarController avatarController = Get.put(AvatarController());

class CreateAvatar extends StatefulWidget {
  const CreateAvatar({Key? key, required this.userRepository})
      : super(key: key);
  final UserRepository userRepository;
  @override
  _CreateAvatarState createState() => _CreateAvatarState();
}

class _CreateAvatarState extends State<CreateAvatar> {
  late int _selectedIndex;

  @override
  initState() {
    super.initState();
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvatarController>(
        init: AvatarController(),
        builder: (_) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: CustomColors.backGroundColor,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 45.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Create Your\nAvatar',
                        color: CustomColors.textWhiteColor,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w600,
                        maxLines: 2,
                        alignment: TextAlign.start,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ...[
                            InkWell(
                              splashColor: CustomColors.transparentColor,
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 0;
                                });
                              },
                              child: FeatureButton(
                                index: 0,
                                selectedIndex: _selectedIndex,
                                text: 'Shirt',
                              ),
                            ),
                            InkWell(
                              splashColor: CustomColors.transparentColor,
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 1;
                                });
                              },
                              child: FeatureButton(
                                index: 1,
                                selectedIndex: _selectedIndex,
                                text: 'Shorts',
                              ),
                            ),
                            InkWell(
                              splashColor: CustomColors.transparentColor,
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 2;
                                });
                              },
                              child: FeatureButton(
                                index: 2,
                                selectedIndex: _selectedIndex,
                                text: 'Legs',
                              ),
                            ),
                            InkWell(
                              splashColor: CustomColors.transparentColor,
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 3;
                                });
                              },
                              child: FeatureButton(
                                index: 3,
                                selectedIndex: _selectedIndex,
                                text: 'Shoes',
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ...[
                            InkWell(
                              splashColor: CustomColors.transparentColor,
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 4;
                                });
                              },
                              child: FeatureButton(
                                index: 4,
                                selectedIndex: _selectedIndex,
                                text: 'Face',
                              ),
                            ),
                            InkWell(
                              splashColor: CustomColors.transparentColor,
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 5;
                                });
                              },
                              child: FeatureButton(
                                index: 5,
                                selectedIndex: _selectedIndex,
                                text: 'Hair',
                              ),
                            ),
                            InkWell(
                              splashColor: CustomColors.transparentColor,
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 6;
                                });
                              },
                              child: FeatureButton(
                                index: 6,
                                selectedIndex: _selectedIndex,
                                text: 'Nose',
                              ),
                            ),
                            InkWell(
                              splashColor: CustomColors.transparentColor,
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 7;
                                });
                              },
                              child: FeatureButton(
                                index: 7,
                                selectedIndex: _selectedIndex,
                                text: 'Eyes',
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ...[
                            InkWell(
                              splashColor: CustomColors.transparentColor,
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 8;
                                });
                              },
                              child: FeatureButton(
                                index: 8,
                                selectedIndex: _selectedIndex,
                                text: 'Brows',
                              ),
                            ),
                            InkWell(
                              splashColor: CustomColors.transparentColor,
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 9;
                                });
                              },
                              child: FeatureButton(
                                index: 9,
                                selectedIndex: _selectedIndex,
                                text: 'Mouth',
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      featureAssets(_selectedIndex),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Center(child: AvatarBox()),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomButton(
                        text: 'Continue',
                        onTap: () {
                          Get.off(
                            HomePage(userRepository: widget.userRepository),
                          );
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class FeatureButton extends StatelessWidget {
  const FeatureButton(
      {Key? key,
      required this.index,
      required this.selectedIndex,
      required this.text})
      : super(key: key);

  final int index;
  final int selectedIndex;
  final String text;

  @override
  Widget build(Buildontext) {
    return Container(
      margin: EdgeInsets.only(right: 3.w),
      height: 40.h,
      width: 70.w,
      decoration: BoxDecoration(
          gradient: index == selectedIndex
              ? const LinearGradient(
                  colors: [
                    Color(0xFFF1E291),
                    Color(0xFFDFAE00),
                    Color(0xFFF1E291),
                    Color(0xFFDFAE00),
                  ],
                )
              : null,
          borderRadius: BorderRadius.circular(12.r)),
      child: Center(
        child: CustomText(
          text: text,
          color: index == selectedIndex
              ? CustomColors.textWhiteColor
              : CustomColors.foreGroundColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          maxLines: 2,
          alignment: TextAlign.start,
        ),
      ),
    );
  }
}

featureAssets(int index) {
  switch (index) {
    case 0:
      return const Shirt();
    case 1:
      return const Shorts();
    case 2:
      return const Legs();
    case 3:
      return const Shoe();
    case 4:
      return const Face();
    case 5:
      return const Hair();
    case 6:
      return const Nose();
    case 7:
      return const Eyes();
    case 8:
      return const EyesBrows();
    case 9:
      return const Mouth();
    default:
      return const SizedBox.shrink();
  }
}

class AssetCard extends StatelessWidget {
  const AssetCard({Key? key, required this.imageLink, required this.isSelected})
      : super(key: key);

  final String imageLink;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      padding: EdgeInsets.all(3.r),
      height: 70.h,
      width: 70.w,
      decoration: BoxDecoration(
        color: isSelected
            ? CustomColors.textYellowColor
            : CustomColors.foreGroundColor,
        borderRadius: BorderRadius.circular(12.r),
        image: DecorationImage(
          image: AssetImage(imageLink),
        ),
      ),
    );
  }
}

class AvatarBox extends StatefulWidget {
  const AvatarBox({Key? key}) : super(key: key);

  @override
  State<AvatarBox> createState() => _AvatarBoxState();
}

class _AvatarBoxState extends State<AvatarBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.r),
      height: 320.h,
      width: 200.w,
      decoration: BoxDecoration(
        color: CustomColors.foreGroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 180.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.all(3.r),
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: AssetImage(legsList[selectedLegs]),
                ),
              ),
            ),
          ),
          Positioned(
            top: 130.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.all(3.r),
              height: 70.h,
              width: 70.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: AssetImage(shortsList[selectedShorts]),
                ),
              ),
            ),
          ),
          Positioned(
            top: 80.h,
            left: 20.w,
            right: 75.w,
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.all(3.r),
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: const DecorationImage(
                  image: AssetImage('assets/white_kit/left_arm.png'),
                ),
              ),
            ),
          ),
          Positioned(
            top: 80.h,
            left: 75.w,
            right: 20.w,
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.all(3.r),
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: const DecorationImage(
                  image: AssetImage('assets/white_kit/right_arm.png'),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.all(3.r),
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: AssetImage(faceList[selectedFace]),
                ),
              ),
            ),
          ),
          Positioned(
            top: 12.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.all(3.r),
              height: 30.h,
              width: 30.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: AssetImage(hairList[selectedHair]),
                ),
              ),
            ),
          ),
          Positioned(
            top: 33.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.all(3.r),
              height: 3.h,
              width: 3.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: AssetImage(eyeBrowsList[selectedEyesBrows]),
                ),
              ),
            ),
          ),
          Positioned(
            top: 35.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.all(3.r),
              height: 4.h,
              width: 4.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: AssetImage(eyesList[selectedEyes]),
                ),
              ),
            ),
          ),
          Positioned(
            top: 38.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.all(3.r),
              height: 10.h,
              width: 10.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: AssetImage(noseList[selectedNose]),
                ),
              ),
            ),
          ),
          Positioned(
            top: 47.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.all(3.r),
              height: 7.h,
              width: 7.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: AssetImage(mouthList[selectedMouth]),
                ),
              ),
            ),
          ),
          Positioned(
            top: 60.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.all(3.r),
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: AssetImage(shirtList[selectedShirt]),
                ),
              ),
            ),
          ),
          Positioned(
            top: 270.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.all(3.r),
              height: 21.h,
              width: 30.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: AssetImage(shoeList[selectedShoes]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Shirt extends StatelessWidget {
  const Shirt({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < shirtList.length; i++)
            InkWell(
              onTap: () {
                selectedShirt = i;
                avatarController.update();
              },
              child: AssetCard(
                isSelected: selectedShirt == i,
                imageLink: shirtList[i],
              ),
            ),
        ],
      ),
    );
  }
}

class Shorts extends StatelessWidget {
  const Shorts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < shortsList.length; i++)
            InkWell(
              onTap: () {
                selectedShorts = i;
                avatarController.update();
              },
              child: AssetCard(
                isSelected: selectedShorts == i,
                imageLink: shortsList[i],
              ),
            ),
        ],
      ),
    );
  }
}

class Legs extends StatelessWidget {
  const Legs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < legsList.length; i++)
            InkWell(
              onTap: () {
                selectedLegs = i;
                avatarController.update();
              },
              child: AssetCard(
                isSelected: selectedLegs == i,
                imageLink: legsList[i],
              ),
            ),
        ],
      ),
    );
  }
}

class Shoe extends StatelessWidget {
  const Shoe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < shoeList.length; i++)
            InkWell(
              onTap: () {
                selectedShoes = i;
                avatarController.update();
              },
              child: AssetCard(
                isSelected: selectedShoes == i,
                imageLink: shoeList[i],
              ),
            ),
        ],
      ),
    );
  }
}

class Eyes extends StatelessWidget {
  const Eyes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < eyesList.length; i++)
            InkWell(
              onTap: () {
                selectedEyes = i;
                avatarController.update();
              },
              child: AssetCard(
                isSelected: selectedEyes == i,
                imageLink: eyesList[i],
              ),
            ),
        ],
      ),
    );
  }
}

class EyesBrows extends StatelessWidget {
  const EyesBrows({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < eyeBrowsList.length; i++)
            InkWell(
              onTap: () {
                selectedEyesBrows = i;
                avatarController.update();
              },
              child: AssetCard(
                isSelected: selectedEyesBrows == i,
                imageLink: eyeBrowsList[i],
              ),
            ),
        ],
      ),
    );
  }
}

class Nose extends StatelessWidget {
  const Nose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < noseList.length; i++)
            InkWell(
              onTap: () {
                selectedNose = i;
                avatarController.update();
              },
              child: AssetCard(
                isSelected: selectedNose == i,
                imageLink: noseList[i],
              ),
            ),
        ],
      ),
    );
  }
}

class Mouth extends StatelessWidget {
  const Mouth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < mouthList.length; i++)
            InkWell(
              onTap: () {
                selectedMouth = i;
                avatarController.update();
              },
              child: AssetCard(
                isSelected: selectedMouth == i,
                imageLink: mouthList[i],
              ),
            ),
        ],
      ),
    );
  }
}

class Hair extends StatelessWidget {
  const Hair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < hairList.length; i++)
            InkWell(
              onTap: () {
                selectedHair = i;
                avatarController.update();
              },
              child: AssetCard(
                isSelected: selectedHair == i,
                imageLink: hairList[i],
              ),
            ),
        ],
      ),
    );
  }
}

class Face extends StatelessWidget {
  const Face({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < faceList.length; i++)
            InkWell(
              onTap: () {
                selectedFace = i;
                avatarController.update();
              },
              child: AssetCard(
                isSelected: selectedFace == i,
                imageLink: faceList[i],
              ),
            ),
        ],
      ),
    );
  }
}

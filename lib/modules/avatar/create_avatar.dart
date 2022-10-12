// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/global/global_view/custom_button.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';

import '../home/main_navigation_page.dart';
import 'avatar_controller.dart';

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
                      Center(child: AvatarBox()),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomButton(
                        text: 'Continue',
                        onTap: () async {
                          try {
                            Uint8List? image = await avatarController
                                .sstController
                                .captureFromWidget(AvatarBox());
                            await saveImage(image);

                            print(image);
                            Get.offAll(
                              MainNavigationPage(
                                  userRepository: widget.userRepository),
                            );
                          } catch (e) {
                            log(e.toString());
                          }
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

  saveImage(Uint8List bytes) async {
    var x = await getApplicationDocumentsDirectory();
    // await Permission.storage.request();
    var y = File(
        '${x.path}/${FirebaseAuth.instance.currentUser!.uid}-${DateTime.now().millisecondsSinceEpoch}');
    y.writeAsBytesSync(bytes);
    // final result = await ImageGallerySaver.saveImage(bytes,
    //     name: FirebaseAuth.instance.currentUser!.uid);
    widget.userRepository.uploadImage(image: y.path);
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

class AvatarBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvatarController>(
        init: AvatarController(),
        builder: (_) {
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
                        image: AssetImage(avatarController
                            .legsList[avatarController.selectedLegs]),
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
                        image: AssetImage(avatarController
                            .shortsList[avatarController.selectedShorts]),
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
                        image: AssetImage(avatarController
                            .faceList[avatarController.selectedFace]),
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
                        image: AssetImage(avatarController
                            .hairList[avatarController.selectedHair]),
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
                        image: AssetImage(avatarController
                            .eyeBrowsList[avatarController.selectedEyesBrows]),
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
                        image: AssetImage(avatarController
                            .eyesList[avatarController.selectedEyes]),
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
                        image: AssetImage(avatarController
                            .noseList[avatarController.selectedNose]),
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
                        image: AssetImage(avatarController
                            .mouthList[avatarController.selectedMouth]),
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
                        image: AssetImage(avatarController
                            .shirtList[avatarController.selectedShirt]),
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
                        image: AssetImage(avatarController
                            .shoeList[avatarController.selectedShoes]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class Shirt extends StatelessWidget {
  const Shirt({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvatarController>(
        init: AvatarController(),
        builder: (_) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < avatarController.shirtList.length; i++)
                  InkWell(
                    onTap: () {
                      avatarController.selectedShirt = i;
                      avatarController.update();
                    },
                    child: AssetCard(
                      isSelected: avatarController.selectedShirt == i,
                      imageLink: avatarController.shirtList[i],
                    ),
                  ),
              ],
            ),
          );
        });
  }
}

class Shorts extends StatelessWidget {
  const Shorts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvatarController>(
        init: AvatarController(),
        builder: (_) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < avatarController.shortsList.length; i++)
                  InkWell(
                    onTap: () {
                      avatarController.selectedShorts = i;
                      avatarController.update();
                    },
                    child: AssetCard(
                      isSelected: avatarController.selectedShorts == i,
                      imageLink: avatarController.shortsList[i],
                    ),
                  ),
              ],
            ),
          );
        });
  }
}

class Legs extends StatelessWidget {
  const Legs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvatarController>(
        init: AvatarController(),
        builder: (_) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < avatarController.legsList.length; i++)
                  InkWell(
                    onTap: () {
                      avatarController.selectedLegs = i;
                      avatarController.update();
                    },
                    child: AssetCard(
                      isSelected: avatarController.selectedLegs == i,
                      imageLink: avatarController.legsList[i],
                    ),
                  ),
              ],
            ),
          );
        });
  }
}

class Shoe extends StatelessWidget {
  const Shoe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvatarController>(
        init: AvatarController(),
        builder: (_) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < avatarController.shoeList.length; i++)
                  InkWell(
                    onTap: () {
                      avatarController.selectedShoes = i;
                      avatarController.update();
                    },
                    child: AssetCard(
                      isSelected: avatarController.selectedShoes == i,
                      imageLink: avatarController.shoeList[i],
                    ),
                  ),
              ],
            ),
          );
        });
  }
}

class Eyes extends StatelessWidget {
  const Eyes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvatarController>(
        init: AvatarController(),
        builder: (_) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < avatarController.eyesList.length; i++)
                  InkWell(
                    onTap: () {
                      avatarController.selectedEyes = i;
                      avatarController.update();
                    },
                    child: AssetCard(
                      isSelected: avatarController.selectedEyes == i,
                      imageLink: avatarController.eyesList[i],
                    ),
                  ),
              ],
            ),
          );
        });
  }
}

class EyesBrows extends StatelessWidget {
  const EyesBrows({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvatarController>(
        init: AvatarController(),
        builder: (_) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < avatarController.eyeBrowsList.length; i++)
                  InkWell(
                    onTap: () {
                      avatarController.selectedEyesBrows = i;
                      avatarController.update();
                    },
                    child: AssetCard(
                      isSelected: avatarController.selectedEyesBrows == i,
                      imageLink: avatarController.eyeBrowsList[i],
                    ),
                  ),
              ],
            ),
          );
        });
  }
}

class Nose extends StatelessWidget {
  const Nose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvatarController>(
        init: AvatarController(),
        builder: (_) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < avatarController.noseList.length; i++)
                  InkWell(
                    onTap: () {
                      avatarController.selectedNose = i;
                      avatarController.update();
                    },
                    child: AssetCard(
                      isSelected: avatarController.selectedNose == i,
                      imageLink: avatarController.noseList[i],
                    ),
                  ),
              ],
            ),
          );
        });
  }
}

class Mouth extends StatelessWidget {
  const Mouth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvatarController>(
        init: AvatarController(),
        builder: (_) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < avatarController.mouthList.length; i++)
                  InkWell(
                    onTap: () {
                      avatarController.selectedMouth = i;
                      avatarController.update();
                    },
                    child: AssetCard(
                      isSelected: avatarController.selectedMouth == i,
                      imageLink: avatarController.mouthList[i],
                    ),
                  ),
              ],
            ),
          );
        });
  }
}

class Hair extends StatelessWidget {
  const Hair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvatarController>(
        init: AvatarController(),
        builder: (_) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < avatarController.hairList.length; i++)
                  InkWell(
                    onTap: () {
                      avatarController.selectedHair = i;
                      avatarController.update();
                    },
                    child: AssetCard(
                      isSelected: avatarController.selectedHair == i,
                      imageLink: avatarController.hairList[i],
                    ),
                  ),
              ],
            ),
          );
        });
  }
}

class Face extends StatelessWidget {
  const Face({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvatarController>(
        init: AvatarController(),
        builder: (_) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < avatarController.faceList.length; i++)
                  InkWell(
                    onTap: () {
                      avatarController.selectedFace = i;
                      avatarController.update();
                    },
                    child: AssetCard(
                      isSelected: avatarController.selectedFace == i,
                      imageLink: avatarController.faceList[i],
                    ),
                  ),
              ],
            ),
          );
        });
  }
}

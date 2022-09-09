// // ignore_for_file: prefer_const_constructors_in_immutables, avoid_print, use_build_context_synchronously, must_be_immutable

// import 'dart:io';

// import 'package:celiver_rider_app/blocs/capture_image/capture_image_bloc.dart';
// import 'package:celiver_rider_app/constants/colors.dart';
// import 'package:celiver_rider_app/constants/design.dart';
// import 'package:celiver_rider_app/constants/validators.dart';
// import 'package:celiver_rider_app/global_view/global_widgets/custom_button.dart';
// import 'package:celiver_rider_app/global_view/global_widgets/custom_loader.dart';
// import 'package:celiver_rider_app/global_view/global_widgets/custom_text.dart';
// import 'package:celiver_rider_app/global_view/global_widgets/custom_text_field.dart';
// import 'package:celiver_rider_app/modules/authentication/sub_modules/sign_up/sign_up_bloc/sign_up_bloc.dart';
// import 'package:celiver_rider_app/modules/authentication/ui/screens/verification_screen.dart';
// import 'package:celiver_rider_app/repositories/rider_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';

// PanelController panelController = PanelController();

// class LicenseScreen extends StatelessWidget {
//   LicenseScreen({Key? key, required this.riderRepository}) : super(key: key);

//   RiderRepository riderRepository;

//   @override
//   Widget build(BuildContext context) {
//     return Ui(riderRepository: riderRepository);
//   }
// }

// class Ui extends StatelessWidget {
//   Ui({Key? key, required this.riderRepository}) : super(key: key);
//   RiderRepository riderRepository;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: CustomColors.backGroundColor,
//         body: MultiBlocProvider(
//           providers: [
//             BlocProvider<CaptureImageBloc>(
//               create: (BuildContext context) => CaptureImageBloc(
//                 riderRepository: riderRepository,
//               ),
//             ),
//             BlocProvider<SignUpBloc>(
//               create: (BuildContext context) => SignUpBloc(),
//             ),
//           ],
//           child: BlocListener<SignUpBloc, SignUpState>(
//             listener: (context, state) {
//               if (state is SignUpCreateAccountState) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute<void>(
//                     builder: (BuildContext context) => VerificationScreen(
//                       riderRepository: riderRepository,
//                     ),
//                   ),
//                 );
//               }
//             },
//             child: BlocBuilder<SignUpBloc, SignUpState>(
//               builder: (context, state) {
//                 if (state is SignUpCreateAccountProcessState) {
//                   return SizedBox(
//                     height: MediaQuery.of(context).size.height,
//                     width: MediaQuery.of(context).size.width,
//                     child: const CustomLoader(),
//                   );
//                 }
//                 return SlidingUpPanel(
//                   controller: panelController,
//                   maxHeight: 100.h,
//                   minHeight: 0.h,
//                   parallaxEnabled: true,
//                   parallaxOffset: .5,
//                   body: MainUi(),
//                   panelBuilder: (_) {
//                     return OptionalUi();
//                   },
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(18.r),
//                       topRight: Radius.circular(18.r)),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// enum ImageIndex { image_front, image_back, image_none }

// class MainUi extends StatelessWidget {
//   MainUi({
//     Key? key,
//   }) : super(key: key);

//   /* -------------------------------------------------------------------------- */
//   /*                                  Variables                                 */
//   /* -------------------------------------------------------------------------- */

//   final GlobalKey<FormState> _licenseKey = GlobalKey<FormState>();
//   final TextEditingController licenseController = TextEditingController();

//   ImageIndex _index = ImageIndex.image_none;

//   ImageIndex get optionalIndex => _index;

//   /* -------------------------------------------------------------------------- */
//   /*                                  Functions                                 */
//   /* -------------------------------------------------------------------------- */

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: Design.horizontalPadding,
//       ),
//       child: Form(
//         key: _licenseKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 226.h,
//             ),
//             CustomText(
//               text: "License",
//               color: CustomColors.textDarkColor,
//               fontWeight: FontWeight.w700,
//               fontSize: 40.sp,
//             ),
//             CustomText(
//               text: "Add driver's license ID and image",
//               color: CustomColors.textLightColor,
//               fontWeight: FontWeight.w700,
//               fontSize: 16.sp,
//             ),
//             SizedBox(
//               height: (7.5).h,
//             ),
//             CustomTextField(
//               title: "License ID",
//               controller: licenseController,
//               validator: CustomValidators().fieldValidator,
//               keyboardType: TextInputType.number,
//               onTap: () {},
//             ),
//             SizedBox(
//               height: (7.5).h,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ImageBox(
//                   onTap: () {
//                     if (panelController.isPanelClosed) {
//                       _index = ImageIndex.image_front;
//                       panelController.open();
//                     } else if (panelController.isPanelOpen) {
//                       panelController.close();
//                       _index = ImageIndex.image_none;
//                     }
//                   },
//                 ),
//                 ImageBox(
//                   onTap: () {
//                     if (panelController.isPanelClosed) {
//                       _index = ImageIndex.image_back;
//                       panelController.open();
//                     } else if (panelController.isPanelOpen) {
//                       panelController.close();
//                       _index = ImageIndex.image_none;
//                     }
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: (65).h,
//             ),
//             CustomButton(
//               text: 'Create Account',
//               onTap: () {
//                 if (_licenseKey.currentState!.validate()) {
//                   BlocProvider.of<SignUpBloc>(context).add(
//                     SignUpCreateAccountEvent(
//                         licenseNumber: licenseController.text),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ImageBox extends StatelessWidget {
//   ImageBox({
//     required this.onTap,
//     Key? key,
//   }) : super(key: key);
//   final void Function() onTap;

//   MainUi mainUi = MainUi();

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: BlocConsumer<CaptureImageBloc, CaptureImageState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           var imageAddedState = state as ImageAddedState;

//           if (state is ImageAddedState ||
//               (mainUi.optionalIndex == ImageIndex.image_front
//                   ? imageAddedState.image_front != ''
//                   : imageAddedState.image_back != '')) {
//             return Container(
//               height: 114.h,
//               width: 175.w,
//               decoration: BoxDecoration(
//                 color: CustomColors.backGroundColor,
//                 borderRadius: BorderRadius.circular(Design.radius),
//                 border: Border.all(color: CustomColors.foreGroundColor),
//               ),
//               child: Stack(
//                 children: [
//                   if (mainUi.optionalIndex == ImageIndex.image_front
//                       ? imageAddedState.image_front != ''
//                       : imageAddedState.image_back != '')
//                     Padding(
//                       padding: EdgeInsets.only(
//                         top: 2.r,
//                         bottom: 1.r,
//                         left: 1.r,
//                         right: 1.r,
//                       ),
//                       child: Center(
//                         child: Image.file(
//                           mainUi.optionalIndex == 0
//                               ? File(imageAddedState.image_front)
//                               : File(imageAddedState.image_back),
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                   Center(
//                     child: CustomText(
//                       text: mainUi.optionalIndex == 0
//                           ? 'Front Side'
//                           : 'Back Side',
//                       fontWeight: FontWeight.w700,
//                       fontSize: 16.sp,
//                       color: CustomColors.textLightColor,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return Container(
//               height: 114.h,
//               width: 175.w,
//               decoration: BoxDecoration(
//                 color: CustomColors.backGroundColor,
//                 borderRadius: BorderRadius.circular(Design.radius),
//                 border: Border.all(color: CustomColors.foreGroundColor),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.camera_alt_outlined,
//                     color: CustomColors.foreGroundColor,
//                     size: 40.r,
//                   ),
//                   CustomText(
//                     text:
//                         mainUi.optionalIndex == 0 ? 'Front Side' : 'Back Side',
//                     fontWeight: FontWeight.w700,
//                     fontSize: 16.sp,
//                     color: CustomColors.textLightColor,
//                   )
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class OptionalUi extends StatelessWidget {
//   OptionalUi({
//     Key? key,
//   }) : super(key: key);

//   MainUi mainUi = MainUi();

//   void pickImage(
//       {required ImageSource source, required var captureImageBloc}) async {
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       panelController.close();
//       if (image == null) return;
//       captureImageBloc.add(
//         ImageAddedEvent(image: image.path, index: mainUi.optionalIndex),
//       );
//     } on PlatformException catch (err) {
//       print(err);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 35.w),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             InkWell(
//               onTap: () async {
//                 // ConstVar.captureImageBloc =
//                 //     BlocProvider.of<CaptureImageBloc>(context);
//                 pickImage(
//                   source: ImageSource.camera,
//                   captureImageBloc: BlocProvider.of<CaptureImageBloc>(context),
//                 );
//               },
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.camera_alt_outlined,
//                     color: CustomColors.foreGroundColor,
//                     size: 40.r,
//                   ),
//                   CustomText(
//                     text: 'Camera',
//                     fontWeight: FontWeight.w700,
//                     fontSize: 16.sp,
//                     color: CustomColors.textLightColor,
//                   )
//                 ],
//               ),
//             ),
//             InkWell(
//               onTap: () async {
//                 // ConstVar.captureImageBloc =
//                 //     BlocProvider.of<CaptureImageBloc>(context);
//                 pickImage(
//                   source: ImageSource.gallery,
//                   captureImageBloc: BlocProvider.of<CaptureImageBloc>(context),
//                 );
//               },
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.image_outlined,
//                     color: CustomColors.foreGroundColor,
//                     size: 40.r,
//                   ),
//                   CustomText(
//                     text: 'Gallery',
//                     fontWeight: FontWeight.w700,
//                     fontSize: 16.sp,
//                     color: CustomColors.textLightColor,
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

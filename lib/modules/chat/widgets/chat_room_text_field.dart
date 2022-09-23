import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/modules/chat/recording_controller.dart';

class ChatRoomTextField extends StatelessWidget {
  ChatRoomTextField({
    Key? key,
    required this.title,
    required this.controller,
    required this.recording,
    required this.groupChatId,
    required this.cameraFunction,
    required this.micFunction,
  }) : super(key: key);
  final String title;
  final TextEditingController controller;
  final RecordingController recording;
  final String groupChatId;
  void Function()? cameraFunction;
  void Function()? micFunction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: CustomColors.textLightColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      cursorColor: CustomColors.textLightColor,
      decoration: InputDecoration(
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: cameraFunction,
              child: Icon(
                Icons.camera_alt,
                color: CustomColors.textLightColor,
                size: 40.r,
              ),
            ),
            InkWell(
              onTap: micFunction,
              child: Icon(
                Icons.mic,
                color: CustomColors.textLightColor,
                size: 40.r,
              ),
            ),
          ],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: const Color(0xFFEDEDED).withOpacity(0.2),
            width: 2.r,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: const Color(0xFFEDEDED).withOpacity(0.2),
            width: 2.r,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 0.0,
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: const Color(0xFFEDEDED).withOpacity(0.2),
            width: 2.r,
          ),
        ),
        fillColor: const Color(0xFFEDEDED).withOpacity(0.2),
        filled: true,
        focusColor: const Color(0xFFEDEDED).withOpacity(0.2),
        isDense: true,
        hintText: title,
        hintStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: CustomColors.textLightColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

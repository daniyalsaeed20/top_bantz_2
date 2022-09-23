import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';

class ChatRoomRecordingField extends StatelessWidget {
  ChatRoomRecordingField({
    Key? key,
    this.onCancelTap,
  }) : super(key: key);

  void Function()? onCancelTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDED).withOpacity(0.2),
        boxShadow: [
          BoxShadow(
            color: CustomColors.blackColor.withOpacity(0.5),
            blurRadius: 5,
            spreadRadius: 3,
            offset: const Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.mic,
            color: CustomColors.themeColor,
            size: 45.r,
          ),
          RecordTimer(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: const LinearProgressIndicator(
                color: CustomColors.themeColor,
              ),
            ),
          ),
          InkWell(
            onTap: onCancelTap,
            child: Icon(
              Icons.close,
              color: Colors.red,
              size: 45.r,
            ),
          ),
        ],
      ),
    );
  }
}

class RecordTimer extends StatefulWidget {
  RecordTimer({
    Key? key,
    this.starter = true,
  }) : super(key: key);

  bool starter;

  @override
  State<RecordTimer> createState() => _RecordTimerState(
        starter: starter,
      );
}

class _RecordTimerState extends State<RecordTimer> {
  _RecordTimerState({
    required this.starter,
  });
  Duration duration = Duration();
  Timer? timer;

  bool starter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (starter) startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer!.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return CustomText(
      color: CustomColors.textLightColor,
      text: '$minutes : $seconds',
      fontSize: 18.sp,
    );
  }
}

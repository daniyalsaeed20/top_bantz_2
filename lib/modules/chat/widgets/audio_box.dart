import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/models/chat_message_model.dart';
import 'package:top_bantz_2/models/user_model.dart';

class AudioBox extends StatefulWidget {
  AudioBox({Key? key, required this.messageModel, required this.userModel})
      : super(key: key);

  ChatMessageModel messageModel;
  UserModel userModel;

  @override
  State<AudioBox> createState() => _AudioBoxState(
        url: messageModel.message,
        userModel: userModel,
      );
}

class _AudioBoxState extends State<AudioBox> {
  _AudioBoxState({
    required this.url,
    required this.userModel,
  });
  UserModel userModel;
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isAudioLoading = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  IconData playIcon = Icons.play_arrow;

  double playbackRate = 1.0;

  String url;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchAudio();
    audioPlayer.setPlaybackRate(playbackRate);
    onPlayerStateChanged();
    onAudioDurationChanged();
    onAudioPositionChanged();
  }

  // Future fetchAudio() async {
  //   await audioPlayer.setSourceUrl(url);
  // }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Timestamp timestamp = widget.messageModel.time as Timestamp;
    final DateTime dateTime = timestamp.toDate();
    final dateString = DateFormat('MMM d, h:mma').format(dateTime);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.messageModel.send_by != userModel.userName)
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: CustomColors.textYellowColor,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  widget.messageModel.image == ''
                      ? 'https://firebasestorage.googleapis.com/v0/b/top-bantz-db7af.appspot.com/o/users%2F0YcMUfXjw9S6hr2T5GPNWUGY5Bj1%2Fimage%2F0YcMUfXjw9S6hr2T5GPNWUGY5Bj1-1665643279140?alt=media&token=b4c227a3-ca48-4ded-ac6a-bac088d0e726'
                      : widget.messageModel.image,
                ),
              ),
            ),
          ),
        Column(
          crossAxisAlignment: widget.messageModel.send_by == userModel.userName
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (widget.messageModel.send_by != userModel.userName)
              Padding(
                padding: EdgeInsets.only(
                  left: widget.messageModel.send_by == userModel.userName
                      ? 48
                      : 16,
                  right: widget.messageModel.send_by == userModel.userName
                      ? 16
                      : 48,
                ),
                child: CustomText(
                  alignment: TextAlign.end,
                  text: widget.messageModel.send_by,
                  color: CustomColors.textMediumColor,
                  fontSize: 12.sp,
                ),
              ),
            Align(
              alignment: widget.messageModel.send_by == userModel.userName
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: widget.messageModel.send_by == userModel.userName
                      ? 48
                      : 16,
                  right: widget.messageModel.send_by == userModel.userName
                      ? 16
                      : 48,
                  top: 8,
                ),
                child: Container(
                  height: 83.h,
                  width: 250.w,
                  decoration: BoxDecoration(
                    color: widget.messageModel.send_by != userModel.userName
                        ? CustomColors.textWhiteColor
                        : CustomColors.themeColor,
                    boxShadow: [
                      BoxShadow(
                        color: CustomColors.blackColor.withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 3,
                        offset: const Offset(0, 3),
                      )
                    ],
                    // border: Border.all(
                    //   width: 2,
                    //   color: widget.messageModel.send_by == userModel.userName
                    //       ? CustomColors.backGroundColor
                    //       : CustomColors.blackColor.withOpacity(0.5),
                    // ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.r),
                      topRight: Radius.circular(8.r),
                      bottomLeft:
                          widget.messageModel.send_by == userModel.userName
                              ? Radius.circular(8.r)
                              : Radius.circular(0.r),
                      bottomRight:
                          widget.messageModel.send_by == userModel.userName
                              ? Radius.circular(0.r)
                              : Radius.circular(8.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: CircleAvatar(
                            backgroundColor: widget.messageModel.send_by ==
                                    userModel.userName
                                ? CustomColors.backGroundColor.withOpacity(0.2)
                                : CustomColors.blackColor.withOpacity(0.2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (url != 'null')
                                  InkWell(
                                    onTap: () async {
                                      if (isPlaying) {
                                        await audioPlayer.pause();
                                        setState(() {
                                          playIcon = Icons.play_arrow;
                                        });
                                      } else {
                                        await audioPlayer.play(url);
                                        setState(() {
                                          playIcon = Icons.pause;
                                        });
                                      }
                                    },
                                    child: Icon(
                                      playIcon,
                                      color: widget.messageModel.send_by ==
                                              userModel.userName
                                          ? CustomColors.backGroundColor
                                          : CustomColors.blackColor
                                              .withOpacity(0.5),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        // Icon(
                        //   Icons.multitrack_audio,
                        //   color: widget.messageModel.send_by == userModel.userName
                        //       ? CustomColors.backGroundColor
                        //       : CustomColors.blackColor.withOpacity(0.5),
                        // ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            CustomText(
                              text: formatTime(duration: position),
                              fontSize: 16.sp,
                              color: widget.messageModel.send_by ==
                                      userModel.userName
                                  ? CustomColors.backGroundColor
                                  : CustomColors.blackColor.withOpacity(0.5),
                            ),
                            if (isAudioLoading)
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                    color: widget.messageModel.send_by ==
                                            userModel.userName
                                        ? CustomColors.backGroundColor
                                        : CustomColors.blackColor
                                            .withOpacity(0.5),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        // Spacer(),
                        Row(
                          children: [
                            if (url == 'null')
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                    color: widget.messageModel.send_by ==
                                            userModel.userName
                                        ? CustomColors.backGroundColor
                                        : CustomColors.blackColor
                                            .withOpacity(0.5),
                                  ),
                                ),
                              ),

                            // InkWell(
                            //   onTap: () async {
                            //     await audioPlayer.stop();
                            //     setState(() {
                            //       isPlaying = false;
                            //       position = Duration.zero;
                            //       playIcon = Icons.play_arrow;
                            //     });
                            //   },
                            //   child: const Icon(
                            //     Icons.stop,
                            //     color: Colors.red,
                            //   ),
                            // ),
                          ],
                        ),
                        if (!isPlaying)
                          Icon(
                            Icons.multitrack_audio_rounded,
                            color: widget.messageModel.send_by ==
                                    userModel.userName
                                ? CustomColors.backGroundColor
                                : CustomColors.blackColor.withOpacity(0.5),
                            size: 45.r,
                          ),
                        if (isPlaying)
                          InkWell(
                            onTap: () async {
                              setState(() {
                                if (playbackRate == 1.0) {
                                  playbackRate = 1.5;
                                } else if (playbackRate == 1.5) {
                                  playbackRate = 2.0;
                                } else if (playbackRate == 2.0) {
                                  playbackRate = 3.0;
                                } else if (playbackRate == 3.0) {
                                  playbackRate = 0.5;
                                } else if (playbackRate == 0.5) {
                                  playbackRate = 1.0;
                                }
                              });
                              await audioPlayer.setPlaybackRate(playbackRate);
                            },
                            child: Container(
                              width: 50.w,
                              padding: EdgeInsets.symmetric(
                                vertical: 2.h,
                                horizontal: 5.w,
                              ),
                              decoration: BoxDecoration(
                                color: widget.messageModel.send_by ==
                                        userModel.userName
                                    ? CustomColors.backGroundColor
                                        .withOpacity(0.2)
                                    : CustomColors.blackColor.withOpacity(0.2),
                                // border: Border.all(
                                //   width: 2,
                                //   color: widget.messageModel.send_by ==
                                //           userModel.userName
                                //       ? CustomColors.backGroundColor
                                //       : CustomColors.blackColor.withOpacity(0.5),
                                // ),
                                borderRadius: BorderRadius.circular(45.r),
                              ),
                              child: CustomText(
                                text: playbackRate.toStringAsFixed(1) + 'x',
                                fontSize: 16.sp,
                                color: widget.messageModel.send_by ==
                                        userModel.userName
                                    ? CustomColors.backGroundColor
                                    : CustomColors.blackColor.withOpacity(0.5),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 16,
                left:
                    widget.messageModel.send_by == userModel.userName ? 48 : 16,
                right:
                    widget.messageModel.send_by == userModel.userName ? 16 : 48,
              ),
              child: CustomText(
                alignment: TextAlign.end,
                text: dateString,
                color: CustomColors.textMediumColor,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String formatTime({required Duration duration}) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  onPlayerStateChanged() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
        isAudioLoading = state == PlayerState.PLAYING;
        if (PlayerState.COMPLETED == state) {
          position = Duration.zero;
          playIcon = Icons.play_arrow;
        }
      });
    });
  }

  onAudioDurationChanged() {
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
  }

  onAudioPositionChanged() {
    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
        isAudioLoading = false;
      });
    });
  }
}

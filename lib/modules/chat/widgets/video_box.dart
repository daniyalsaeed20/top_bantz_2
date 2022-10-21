// ignore_for_file: no_logic_in_create_state

import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/models/chat_message_model.dart';
import 'package:top_bantz_2/models/user_model.dart';
import 'package:top_bantz_2/modules/chat/message_controller.dart';
import 'package:video_player/video_player.dart';

class VideoBox extends StatefulWidget {
  VideoBox({Key? key, required this.messageModel, required this.userModel})
      : super(key: key);

  ChatMessageModel messageModel;
  UserModel userModel;

  @override
  State<VideoBox> createState() => _VideoBoxState(
        url: messageModel.message,
        userModel: userModel,
      );
}

class _VideoBoxState extends State<VideoBox> {
  late VideoPlayerController controller;

  _VideoBoxState({
    required this.url,
    required this.userModel,
  });

  UserModel userModel;

  String url;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = VideoPlayerController.network(url)
      ..initialize().then((value) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final Timestamp timestamp = widget.messageModel.time as Timestamp;
    final DateTime dateTime = timestamp.toDate();
    final dateString = DateFormat('MMM d, h:mma').format(dateTime);
    return GetBuilder<MessageController>(
        init: MessageController(),
        builder: (messageController) {
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
                crossAxisAlignment:
                    widget.messageModel.send_by == userModel.userName
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                children: [
                  if (widget.messageModel.send_by != userModel.userName)
                    Padding(
                      padding: EdgeInsets.only(
                        left: widget.messageModel.send_by == userModel.userName
                            ? 48.w
                            : 16.w,
                        right: widget.messageModel.send_by == userModel.userName
                            ? 16.w
                            : 48.w,
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
                            ? 48.w
                            : 16.w,
                        right: widget.messageModel.send_by == userModel.userName
                            ? 16.w
                            : 48.w,
                        top: 8,
                      ),
                      child: Container(
                        height: 200.h,
                        width: 250.w,
                        decoration: BoxDecoration(
                          color: CustomColors.backGroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: CustomColors.blackColor.withOpacity(0.5),
                              blurRadius: 5,
                              spreadRadius: 3,
                              offset: const Offset(0, 3),
                            )
                          ],
                          border: Border.all(
                            width: 2,
                            color: CustomColors.textMediumColor,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.r),
                            topRight: Radius.circular(8.r),
                            bottomLeft: widget.messageModel.send_by ==
                                    userModel.userName
                                ? Radius.circular(8.r)
                                : Radius.circular(0.r),
                            bottomRight: widget.messageModel.send_by ==
                                    userModel.userName
                                ? Radius.circular(0.r)
                                : Radius.circular(8.r),
                          ),
                        ),
                        child:
                            //  messageController.videoUrl != 'null'
                            //     ?
                            Chewie(
                          controller: ChewieController(
                            allowFullScreen: true,
                            errorBuilder: (context, error) => '' != ""
                                ? InkWell(
                                    onTap: () => setState(() {}),
                                    child: const Icon(Icons.refresh))
                                : const Icon(Icons.error),
                            showControls: true,
                            videoPlayerController: controller,
                            autoPlay: false,
                            looping: false,
                            hideControlsTimer: const Duration(seconds: 1),
                          ),
                        ),
                        // : Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 16.w,
                      left: widget.messageModel.send_by == userModel.userName
                          ? 48.w
                          : 16.w,
                      right: widget.messageModel.send_by == userModel.userName
                          ? 16.w
                          : 48.w,
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
        });
  }
}

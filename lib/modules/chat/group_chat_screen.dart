import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/models/chat_message_model.dart';
import 'package:top_bantz_2/models/user_model.dart';
import 'package:top_bantz_2/modules/chat/message_controller.dart';
import 'package:top_bantz_2/modules/chat/recording_controller.dart';
import 'package:top_bantz_2/modules/chat/widgets/audio_box.dart';
import 'package:top_bantz_2/modules/chat/widgets/chat_room_recording_field.dart';
import 'package:top_bantz_2/modules/chat/widgets/chat_room_text_field.dart';
import 'package:top_bantz_2/modules/chat/widgets/image_box.dart';
import 'package:top_bantz_2/modules/chat/widgets/loader_box.dart';
import 'package:top_bantz_2/modules/chat/widgets/multi_media_options.dart';
import 'package:top_bantz_2/modules/chat/widgets/text_bubble.dart';
import 'package:top_bantz_2/modules/chat/widgets/video_box.dart';

class GroupChatScreen extends StatefulWidget {
  GroupChatScreen({
    Key? key,
    required this.groupName,
    required this.groupChatId,
    required this.userModel,
  }) : super(key: key);

  final String groupChatId, groupName;
  UserModel userModel;

  RecordingController recording = RecordingController();

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState(
      recording: recording,
      groupChatId: groupChatId,
      userModel: userModel,
      groupName: groupName);
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  _GroupChatScreenState({
    required this.recording,
    required this.groupChatId,
    required this.userModel,
    required this.groupName,
  });
  UserModel userModel;
  RecordingController recording;
  String groupChatId;
  String groupName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recording.init();
  }

  @override
  void dispose() {
    recording.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.blackColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CustomColors.transparentColor,
          title: CustomText(
            text: groupName,
            fontSize: 18.sp,
            color: CustomColors.textWhiteColor,
          ),
          centerTitle: true,
          leading: InkWell(
            // onTap: () => Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (_) => GroupInfo(
            //       groupName: groupName,
            //       groupId: groupChatId,
            //     ),
            //   ),
            // ),
            child: const Icon(Icons.menu),
          ),
        ),
        body: Body(
          recording: recording,
          groupChatId: groupChatId,
          userModel: userModel,
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  Body({
    Key? key,
    required this.recording,
    required this.groupChatId,
    required this.userModel,
  }) : super(key: key);

  RecordingController recording;

  UserModel userModel;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String groupChatId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      init: MessageController(),
      builder: (messageController) {
        return GetBuilder<RecordingController>(
          init: RecordingController(),
          builder: (recordingController) {
            return SizedBox(
              height: Get.height,
              child: Column(
                children: [
                  Expanded(
                    child: PaginateFirestore(
                      //item builder type is compulsory.
                      itemBuilder: (context, documentSnapshots, index) {
                        final data = documentSnapshots[index].data() as Map?;
                        if (data!['message'] == 'null' ||
                            data['time'] == 'null') {
                          return LoaderBox(
                            messageModel: ChatMessageModel(
                              message: data['message'],
                              send_by: data['sendBy'],
                              type: data['type'],
                              time: data['time'] ?? Timestamp(0, 0),
                            ),
                            userModel: userModel,
                          );
                        }
                        return ChatUiSelector(
                          userModel: userModel,
                          chatMessageModel: ChatMessageModel(
                            message: data['message'],
                            send_by: data['sendBy'],
                            type: data['type'],
                            time: data['time'] ?? Timestamp(0, 0),
                          ),
                        );
                      },
                      // orderBy is compulsory to enable pagination
                      query: _firestore
                          .collection('groups')
                          .doc(groupChatId)
                          .collection('chats')
                          .orderBy('time', descending: true),
                      //Change types accordingly
                      itemBuilderType: PaginateBuilderType.listView,
                      // to fetch real-time data
                      isLive: true,
                      reverse: true,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 5.h,
                            horizontal: 5.w,
                          ),
                          child: messageController.isRecorderActive
                              ? ChatRoomRecordingField(
                                  onCancelTap: () {
                                    messageController.isRecorderActive = false;
                                    messageController.update();
                                    recording.toggleRecording();
                                  },
                                )
                              : ChatRoomTextField(
                                  groupChatId: groupChatId,
                                  recording: recording,
                                  title: 'Write a reply...',
                                  controller:
                                      messageController.sendMessageController,
                                  cameraFunction: () {
                                    openPanel(
                                      recording: recording,
                                      groupchatId: groupChatId,
                                    );
                                  },
                                  micFunction: () async {
                                    messageController.isRecorderActive = true;
                                    messageController.update();
                                    await recording.toggleRecording();
                                  },
                                ),
                        ),
                      ),
                      // InkWell(
                      //   onTap: () => openPanel(
                      //     recording: recording,
                      //     groupchatId: groupChatId,
                      //   ),
                      //   child: const Icon(
                      //     Icons.more_vert,
                      //     color: CustomColors.textWhiteColor,
                      //   ),
                      // ),
                      SizedBox(
                        width: 5.w,
                      ),
                      InkWell(
                        onTap: () async {
                          if (messageController.isRecorderActive) {
                            messageController.isRecorderActive = false;
                            messageController.update();
                            await recording.toggleRecording();
                            var file = await recording.getAudioPath();
                            recording.uploadAudioForGroup(file, groupChatId);
                          } else {
                            messageController.onSendMessage(id: groupChatId);
                            // messageController.chatTemp();
                          }
                        },
                        child: const Icon(
                          Icons.send,
                          color: CustomColors.themeColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class ChatUiSelector extends StatelessWidget {
  ChatUiSelector(
      {Key? key, required this.chatMessageModel, required this.userModel})
      : super(key: key);
  ChatMessageModel chatMessageModel;
  UserModel userModel;

  @override
  Widget build(BuildContext context) {
    if (chatMessageModel.type == 'text') {
      return showMessage(
        messageModel: chatMessageModel,
        userModel: userModel,
      );
    } else if (chatMessageModel.type == 'vid') {
      return VideoBox(
        messageModel: chatMessageModel,
        userModel: userModel,
      );
    } else if (chatMessageModel.type == 'img') {
      return ImageBox(
        messageModel: chatMessageModel,
        userModel: userModel,
      );
    } else if (chatMessageModel.type == 'audio') {
      return AudioBox(
        messageModel: chatMessageModel,
        userModel: userModel,
      );
    }
    return SizedBox();
  }
}

class Panel extends StatelessWidget {
  Panel({
    Key? key,
    required this.recording,
    required this.groupchatId,
  }) : super(key: key);
  RecordingController recording;
  String groupchatId;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
        init: MessageController(),
        builder: (messageController) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // GetBuilder<RecordingController>(builder: (recordingController) {
              //   return InkWell(
              //     onTap: () async {
              //       messageController.isRecorderActive = true;
              //       messageController.update();
              //       Get.back();
              //       await recording.toggleRecording();
              //     },
              //     child: MultiMediaOption(
              //       icon: Icons.mic,
              //       title: 'Record Audio',
              //     ),
              //   );
              // }),
              MultiMediaOption(
                icon: Icons.image,
                title: 'Upload Image',
                onTap: () {
                  multiMediaOptionsDialog(
                      title: 'Upload Image', groupchatId: groupchatId);
                },
              ),
              MultiMediaOption(
                icon: Icons.video_camera_back_outlined,
                title: 'Upload Video',
                onTap: () {
                  multiMediaOptionsDialog(
                      title: 'Upload Video', groupchatId: groupchatId);
                },
              ),
            ],
          );
        });
  }
}

dynamic openPanel({
  required RecordingController recording,
  required String groupchatId,
}) {
  multiMediaDialog(recording: recording, groupchatId: groupchatId);
}

dynamic multiMediaOptionsDialog({
  required String title,
  required String groupchatId,
}) {
  return Get.defaultDialog(
    title: title,
    middleText: '',
    actions: [
      InkWell(
        onTap: () {
          if (title == 'Upload Video') {
            Get.back();
            getVideo(ImageSource.camera, groupchatId);
          }
          if (title == 'Upload Image') {
            Get.back();
            getImage(ImageSource.camera, groupchatId);
          }
        },
        child: MultiMediaOption(
          icon: Icons.camera_alt_outlined,
          title: 'From Camera',
        ),
      ),
      InkWell(
        onTap: () {
          if (title == 'Upload Video') {
            Get.back();
            getVideo(ImageSource.gallery, groupchatId);
          }
          if (title == 'Upload Image') {
            Get.back();
            getImage(ImageSource.gallery, groupchatId);
          }
        },
        child: MultiMediaOption(
          icon: Icons.image_outlined,
          title: 'From Gallery',
        ),
      ),
    ],
    backgroundColor: CustomColors.textMediumColor.withOpacity(0.8),
    titleStyle: TextStyle(
      color: CustomColors.textWhiteColor,
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
    ),
    radius: 8.r,
  );
}

dynamic multiMediaDialog({
  required RecordingController recording,
  required String groupchatId,
}) {
  return Get.defaultDialog(
    title: 'Upload Multimedia',
    middleText: '',
    actions: [
      Panel(
        recording: recording,
        groupchatId: groupchatId,
      )
    ],
    backgroundColor: CustomColors.textMediumColor.withOpacity(0.8),
    titleStyle: TextStyle(
      color: CustomColors.textWhiteColor,
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
    ),
    radius: 8.r,
  );
}

Future getVideo(
  ImageSource source,
  // isGroup,
  groupChatId,
) async {
  ImagePicker _picker = ImagePicker();
  File? videoFile;

  await _picker.pickVideo(source: source).then((xFile) {
    if (xFile != null) {
      videoFile = File(
        xFile.path,
      );

      MessageController().uploadVideoForGroup(videoFile, groupChatId);
    }
  });
}

Future getImage(ImageSource value, groupChatId) async {
  ImagePicker _picker = ImagePicker();
  File? imageFile;

  await _picker.pickImage(source: value).then((xFile) {
    if (xFile != null) {
      imageFile = File(
        xFile.path,
      );

      MessageController().uploadImage(imageFile, groupChatId);
    }
  });
}

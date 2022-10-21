import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/models/chat_message_model.dart';
import 'package:top_bantz_2/models/user_model.dart';

class ImageBox extends StatelessWidget {
  ImageBox({Key? key, required this.messageModel, required this.userModel})
      : super(key: key);

  ChatMessageModel messageModel;
  UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final Timestamp timestamp = messageModel.time as Timestamp;
    final DateTime dateTime = timestamp.toDate();
    final dateString = DateFormat('MMM d, h:mma').format(dateTime);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (messageModel.send_by != userModel.userName)
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: CustomColors.textYellowColor,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  messageModel.image == ''
                      ? 'https://firebasestorage.googleapis.com/v0/b/top-bantz-db7af.appspot.com/o/users%2F0YcMUfXjw9S6hr2T5GPNWUGY5Bj1%2Fimage%2F0YcMUfXjw9S6hr2T5GPNWUGY5Bj1-1665643279140?alt=media&token=b4c227a3-ca48-4ded-ac6a-bac088d0e726'
                      : messageModel.image,
                ),
              ),
            ),
          ),
        Column(
          crossAxisAlignment: messageModel.send_by == userModel.userName
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (messageModel.send_by != userModel.userName)
              Padding(
                padding: EdgeInsets.only(
                  left: messageModel.send_by == userModel.userName ? 48 : 16,
                  right: messageModel.send_by == userModel.userName ? 16 : 48,
                ),
                child: CustomText(
                  alignment: TextAlign.end,
                  text: messageModel.send_by,
                  color: CustomColors.textMediumColor,
                  fontSize: 12.sp,
                ),
              ),
            Align(
              alignment: messageModel.send_by == userModel.userName
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: messageModel.send_by == userModel.userName ? 48 : 16,
                  right: messageModel.send_by == userModel.userName ? 16 : 48,
                  top: 8,
                ),
                child: InkWell(
                  onTap: () => viewImageDialog(
                      url: messageModel.message, context: context),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 200.w,
                    ),
                    height: 200.h,
                    // width: 200.w,
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
                        bottomLeft: messageModel.send_by == userModel.userName
                            ? Radius.circular(8.r)
                            : Radius.circular(0.r),
                        bottomRight: messageModel.send_by == userModel.userName
                            ? Radius.circular(0.r)
                            : Radius.circular(8.r),
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: messageModel.message.toString() != ""
                          ? messageModel.message.toString()
                          : "Loading",
                      fit: BoxFit.fitHeight,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          messageModel.message != ""
                              ? const Icon(Icons.refresh)
                              : const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 16,
                left: messageModel.send_by == userModel.userName ? 48 : 16,
                right: messageModel.send_by == userModel.userName ? 16 : 48,
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
}

dynamic viewImageDialog({required BuildContext context, required String url}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text("Simple Alert"),
        // content: Text("This is an alert message."),
        actions: [
          CachedNetworkImage(
            imageUrl: url != "" ? url : "Loading",
            fit: BoxFit.fitHeight,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                url != "" ? const Icon(Icons.refresh) : const Icon(Icons.error),
          ),
        ],
      );
    },
  );
}

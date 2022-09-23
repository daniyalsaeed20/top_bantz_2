import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel {
  ChatMessageModel({
    required this.type,
    required this.message,
    required this.send_by,
    required this.time,
  });
  String send_by;
  String type;
  String message;
  Timestamp time;
}

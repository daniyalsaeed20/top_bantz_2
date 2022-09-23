import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:top_bantz_2/constants/shared_prefs.dart';
import 'package:top_bantz_2/models/chat_room_model.dart';
import 'package:top_bantz_2/modules/chat/sound_recorder.dart';
import 'package:uuid/uuid.dart';

class RecordingController extends GetxController {
  /* -------------------------------------------------------------------------- */
  /*                                  Variables                                 */
  /* -------------------------------------------------------------------------- */

  ChatRoomModel? chatroom;
  String groupchatId = '';
  bool isGroup = false;

  FlutterSoundRecorder? _audioRecorder;

  bool _isRecorderInitialized = false;
  bool get isRecording => _audioRecorder!.isRecording;

  static String audioPath = '';

  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /* -------------------------------------------------------------------------- */
  /*                                    Lists                                   */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await _audioRecorder!.openAudioSession();
    _isRecorderInitialized = true;
  }

  void dispose() {
    if (!_isRecorderInitialized) return;
    _audioRecorder?.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialized = false;
  }

  Future _record() async {
    if (!_isRecorderInitialized) return;
    await _audioRecorder!.startRecorder(toFile: pathToSaveAudio);
  }

  Future _stop() async {
    if (!_isRecorderInitialized) return;
    await _audioRecorder!.stopRecorder();
  }

  Future toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
      audioPath = await getAudioPath();
    }
  }

  Future getAudioPath() async {
    return await _audioRecorder!.getRecordURL(path: pathToSaveAudio);
  }

  Future uploadAudioForGroup(audioFile, groupChatId) async {
    var userDataModel = await MySharedPrefrences.getUserData();
    String fileName = Uuid().v1();
    User? user = _auth.currentUser;

    String video = "audio";
    int status = 1;

    Map<String, dynamic> chatData = {
      "sendBy": userDataModel.userName,
      "message": 'null',
      "type": "aud",
      "time": FieldValue.serverTimestamp(),
    };

    var docId;
    await _firestore
        .collection('groups')
        .doc(groupChatId)
        .collection('chats')
        .add(chatData)
        .then((value) => docId = value.id);

    var ref = FirebaseStorage.instance
        .ref()
        .child('images')
        .child("${DateTime.now()}");

    var uploadTask =
        await ref.putFile(File(audioFile)).catchError((error) async {
      await _firestore
          .collection('groups')
          .doc(groupChatId)
          .collection('chats')
          .doc(docId)
          .delete();

      status = 0;
    });
    if (status == 1) {
      String audioUrl = await uploadTask.ref.getDownloadURL();

      await _firestore
          .collection('groups')
          .doc(groupChatId)
          .collection('chats')
          .doc(docId)
          .update({
        "type": video,
        "message": audioUrl,
      });

      print(audioUrl);
    }
  }
}

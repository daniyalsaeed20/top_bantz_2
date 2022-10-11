// ignore_for_file: depend_on_referenced_packages, library_prefixes, avoid_print, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:top_bantz_2/models/user_model.dart';

class UserServices {
  /* -------------------------------------------------------------------------- */
  /*                                  Variables                                 */
  /* -------------------------------------------------------------------------- */
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  // final String? _userId = FirebaseAuth.instance.currentUser!.uid;

  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */

  Future setUserDocument({required UserModel userModel}) async {
    try {
      await _userCollection.doc(userModel.userId).set(userModel.toMap());
    } on Exception catch (err) {
      print(err);
    }
  }

  Future updateUserDocument({
    required Map<String, dynamic> toMap,
    required userId,
  }) async {
    try {
      await _userCollection.doc(userId).update(toMap);
    } on Exception catch (err) {
      print(err);
    }
  }

  getUserDocument() async {
    try {
      var snap = await _userCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      return UserModel.fromMap(snap);
    } on Exception catch (err) {
      print(err);
    }
  }

  uploadImage({
    required String image,
    required UserModel userModel,
  }) async {
    String downloadUrl = '';
    try {
      final fileName = basename(image);
      String destination;
      Reference ref;
      destination =
          'users/${FirebaseAuth.instance.currentUser!.uid}/image/$fileName';
      ref = FirebaseStorage.instance.ref(destination);
      UploadTask uploadTask = ref.putFile(File(image));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      downloadUrl = await taskSnapshot.ref.getDownloadURL();
      userModel.image = downloadUrl;
      await updateUserDocument(
          userId: FirebaseAuth.instance.currentUser!.uid,
          toMap: userModel.toMap());
    } on FirebaseException catch (err) {
      log(err.toString());
    }
    return downloadUrl;
  }
}

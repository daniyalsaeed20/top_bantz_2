// ignore_for_file: depend_on_referenced_packages, library_prefixes, avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:top_bantz_2/models/user_model.dart';

class UserServices {
  /* -------------------------------------------------------------------------- */
  /*                                  Variables                                 */
  /* -------------------------------------------------------------------------- */

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

  Future<UserModel> getUserDocument() async {
    try {
      await _userCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then(
        (value) {
          return UserModel.fromDocumentSnapshot(value);
        },
      );
    } on Exception catch (err) {
      print(err);
    }
    return UserModel();
  }
}

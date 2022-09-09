// ignore_for_file: avoid_print, prefer_final_fields
import 'package:firebase_auth/firebase_auth.dart';
import 'package:top_bantz_2/models/user_model.dart';
import 'package:top_bantz_2/services/user_services.dart';

enum ImageSelector { licenseFront, licenseBack, profile }

class UserRepository {
  UserRepository({required UserServices userServices})
      : _userServices = userServices;
  /* -------------------------------------------------------------------------- */
  /*                                  Variables                                 */
  /* -------------------------------------------------------------------------- */

  UserServices _userServices;
  late UserModel _userModel;

  /* -------------------------------------------------------------------------- */
  /*                                    Lists                                   */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */

  /* ----------------------------- Authentication ----------------------------- */

  Future<bool> isSignedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.currentUser!.reload();
      return FirebaseAuth.instance.currentUser!.emailVerified;
    } else {
      return false;
    }
  }

  registerWithCredentials({required UserModel userModel, password}) async {
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: userModel.email, password: password)
        .then(
      (UserCredential credentials) async {
        _userModel = userModel;
        userModel.userId = credentials.user!.uid;
        await _userServices.setUserDocument(
          userModel: userModel,
        );
      },
    );
  }

  signInWithCredentials(
      {required String email, required String password}) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  /* ------------------------------ Verification ------------------------------ */

  verifyAccount() async {
    try {
      return await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } on FirebaseException catch (err) {
      print(err);
    }
  }

  Future<bool> confirmVerification() async {
    await FirebaseAuth.instance.currentUser!.reload();
    return FirebaseAuth.instance.currentUser!.emailVerified;
  }

  /* ---------------------------------- Fetch --------------------------------- */

  getRiderDocument() async {
    _userModel = await _userServices.getUserDocument();
    print(_userModel);
  }
}

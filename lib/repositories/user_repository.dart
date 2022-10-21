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
  static UserModel userModel = UserModel();
  late String password;

  /* -------------------------------------------------------------------------- */
  /*                                    Lists                                   */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */

  /* ----------------------------- Authentication ----------------------------- */

  bool isSignedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  registerWithCredentials({required UserModel userModel, password}) async {
    UserCredential credentials = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: userModel.email, password: password);
    userModel = userModel;
    userModel.userId = credentials.user!.uid;
    await _userServices.setUserDocument(
      userModel: userModel,
    );
  }

  signInWithCredentials(
      {required String email, required String password}) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (err) {
      print(err);
    }
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

  getUserDocument() async {
    userModel = await _userServices.getUserDocument();
    return userModel;
  }

  updateUserData() async {
    await _userServices.updateUserDocument(
        toMap: userModel.toMap(),
        userId: FirebaseAuth.instance.currentUser!.uid);
    await getUserDocument();
  }

  uploadImage({
    required String image,
  }) async {
    await _userServices.uploadImage(
      image: image,
      userModel: userModel,
    );
  }
}

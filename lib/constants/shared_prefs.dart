import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_bantz_2/models/user_model.dart';

class MySharedPrefrences {
  static const userIdKey = 'userIdKey';
  static const userUserNameKey = 'userUserNameKey';
  static const userEmailKey = 'userEmailKey';
  static setUserData({required UserModel userModel}) async {
    await SharedPreferences.getInstance().then((value) {
      // value.setInt(Constant.userIdKey, userModel.uid!);
      value.setString(userIdKey, userModel.userId.toString());
      value.setString(userUserNameKey, userModel.userName.toString());
      value.setString(userEmailKey, userModel.email.toString());
    });
  }

  static Future<UserModel> getUserData() async {
    late UserModel userModel;
    await SharedPreferences.getInstance().then((value) {
      // null hendling
      value.getString(userIdKey) ?? value.setString(userIdKey, "");

      value.getString(userUserNameKey) ?? value.setString(userUserNameKey, "");

      value.getString(userEmailKey) ?? value.setString(userEmailKey, "");

      userModel = UserModel(
        // uid: value.getInt(Constant.userIdKey),
        userId: value.getString(userIdKey)!,
        userName: value.getString(userUserNameKey)!,
        email: value.getString(userEmailKey)!,
        //  password: value.getString(Constant.userPasswordkey),
      );
    });

    return userModel;
  }

  static Future clearUserData() async {
    await SharedPreferences.getInstance().then((value) => value.clear());
  }
}

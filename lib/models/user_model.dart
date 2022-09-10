import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    this.userName = '',
    this.email = '',
    this.dateOfBirth = '',
    this.contactNumber = '',
    this.userId = '',
  });

  String userName;
  String email;
  String dateOfBirth;
  String contactNumber;
  String userId;

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return UserModel(
      userName: doc["userName"],
      email: doc["email"],
      dateOfBirth: doc["dateOfBirth"],
      contactNumber: doc["contactNumber"],
      userId: doc['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "userName": userName,
      "email": email,
      "dateOfBirth": dateOfBirth,
      "contactNumber": contactNumber,
      "userId": userId,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    this.userName = '',
    this.email = '',
    this.dateOfBirth = '',
    this.contactNumber = '',
    this.userId = '',
    this.groupId = '',
    this.image = '',
    this.isPremium = false,
    this.points = 0
  });

  String userName;
  String email;
  String dateOfBirth;
  String contactNumber;
  String userId;
  String groupId;
  String image;
  bool isPremium;

  int points;

  factory UserModel.fromMap(DocumentSnapshot doc) {
    return UserModel(
      userName: doc["userName"],
      email: doc["email"],
      dateOfBirth: doc["dateOfBirth"],
      contactNumber: doc["contactNumber"],
      userId: doc['userId'],
      groupId: doc['groupId'],
      image: doc['image'],
      isPremium: doc['isPremium'],
      points: doc['points'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "userName": userName,
      "email": email,
      "dateOfBirth": dateOfBirth,
      "contactNumber": contactNumber,
      "userId": userId,
      "groupId": groupId,
      "image": image,
      "isPremium": isPremium,
      "points": points,
    };
  }
}

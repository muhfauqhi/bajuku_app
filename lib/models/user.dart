import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final Timestamp created;
  final String email;
  final String points;
  final String firstName;
  final String lastName;
  final String profilePicture;

  User(
      {this.uid,
      this.firstName,
      this.lastName,
      this.points,
      this.created,
      this.email,
      this.profilePicture});
}

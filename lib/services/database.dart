import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // Collection reference
  final firestoreInstance = Firestore.instance;

  Future createUser(String firstName, String lastName, String email)async {
    return await firestoreInstance.collection("users").add({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "address": {
        "street": "",
        "city": "",
      }
    }).then((value){
      print(value.documentID);
      firestoreInstance.collection("users").document(value.documentID).collection("clothes").add({
        "clothName": "",
        "category": "",
        "size": "",
      });
    });
  }

  Future createClothes(String name, String category, String size)async {
    return await firestoreInstance.collection("clothes").add({
      "clothName": name,
      "category": category,
      "size": size,
    });
  }
  }
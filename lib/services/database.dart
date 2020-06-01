import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future setUser(String firstName, String lastName, String email)async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return await firestoreInstance.collection('users').document(firebaseUser.uid).setData({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "address": {
        "street": "",
        "city": "",
      }
    });
  }

  Future setClothes(String name, String worn, String notes, String category, String size, String season, String price, String cost, String dateBought, String color, String status, String usedInOutfit, String url, String startDate, String endDate, String image)async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return await firestoreInstance.collection('users').document(firebaseUser.uid).collection('clothes').document().setData({
      "clothName": name,
      "worn": worn,
      "notes": notes,
      "category": category,
      "size": size,
      "season": season,
      "price": price,
      "cost": cost,
      "dateBought": dateBought,
      "color": color,
      "status": status,
      "usedInOutfit": usedInOutfit,
      "url": url,
      "startDate": startDate,
      "endDate": endDate,
      "image": image,
    });
  }

  Future setOutfit(String name)async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return await firestoreInstance.collection('users').document(firebaseUser.uid).collection('outfits').document().setData({
      "outfitName": name,
    });
  }

  Stream<QuerySnapshot> getClothesHome() async* {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance.collection('users').document(firebaseUser.uid).collection('clothes').snapshots();
  }
  }
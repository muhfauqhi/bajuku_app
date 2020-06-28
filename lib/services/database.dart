import 'package:bajuku_app/models/clothes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  // Collection reference
  final firestoreInstance = Firestore.instance;

  Future createUser(String firstName, String lastName, String email) async {
    return await firestoreInstance.collection("users").add({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "address": {
        "street": "",
        "city": "",
      }
    }).then((value) {
      print(value.documentID);
      firestoreInstance
          .collection("users")
          .document(value.documentID)
          .collection("clothes")
          .add({
        "clothName": "",
        "category": "",
        "size": "",
      });
    });
  }

  Future setUser(String firstName, String lastName, String email) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return await firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .setData({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "created": FieldValue.serverTimestamp(),
      "profilePicture": '',
    });
  }

  Future setClothes(
      String name,
      String brand,
      List<String> fabric,
      int worn,
      String notes,
      List<String> category,
      String size,
      List<String> season,
      String price,
      String cost,
      DateTime dateBought,
      String color,
      String status,
      int usedInOutfit,
      String url,
      String image) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return await firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('clothes')
        .document()
        .setData({
      "clothName": name,
      "fabric": fabric,
      "brand": brand,
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
      "startDate": FieldValue.serverTimestamp(),
      "endDate": FieldValue.serverTimestamp(),
      "updateDate": FieldValue.serverTimestamp(),
      "image": image,
    });
  }

  Future setOutfit(String image, String notes, String name, String totalCost,
      Map mapOfCloth, List<String> clothNameList) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return await firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('outfits')
        .add({
      "notes": notes,
      "outfitName": name,
      "image": image,
      "totalCost": totalCost,
      "taggedClothes": mapOfCloth,
      "taggedClothesName": clothNameList,
      "created": FieldValue.serverTimestamp(),
    });
  }

  Future setGivenOrSellClothes(Clothes clothes, String productDesc,
      String price, String condition, String type) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();

    updateGivenCloth(clothes.documentId, type);
    return await firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('sustainability')
        .add({
      "clothes": clothes.givenClothMap(),
      "productDesc": productDesc,
      "price": price,
      "condition": condition
    });
  }

  Stream<QuerySnapshot> getClothesHome() async* {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('clothes')
        .snapshots();
    print(firebaseUser.uid);
  }

  Stream<QuerySnapshot> getOutfitHome() async* {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('outfits')
        .snapshots();
    print(firebaseUser.uid);
  }

  Future<String> getUid() async {
    final FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    final String uid = firebaseUser.uid;
    return uid;
  }

  // Stream<QuerySnapshot> getClothes() async* {
  //   var firebaseUser = await FirebaseAuth.instance.currentUser();
  //   firestoreInstance.collection('users').document(firebaseUser.uid).collection('clothes').snapshots();
  //   print(firebaseUser.uid);
  // }

  Future getClothes(String category) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    if (category == 'All Items') {
      QuerySnapshot qn = await Firestore.instance
          .collection('users')
          .document(firebaseUser.uid)
          .collection('clothes')
          .getDocuments();
      return qn;
    } else if (category == 'Jacket') {
      QuerySnapshot qn = await Firestore.instance
          .collection('users')
          .document(firebaseUser.uid)
          .collection('clothes')
          .where('category', arrayContains: 'Jackets and Hoodies')
          .getDocuments();
      return qn;
    } else {
      QuerySnapshot qn = await Firestore.instance
          .collection('users')
          .document(firebaseUser.uid)
          .collection('clothes')
          .where('category', arrayContains: category)
          .getDocuments();
      return qn;
    }
  }

  Future getOutfit() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot qn = await Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('outfits')
        .getDocuments();
    return qn;
  }

  Future getSustainabilityClothes() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot qn = await Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('sustainability')
        .getDocuments();
    return qn;
  }

  updateWorn(selectedDoc) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('clothes')
        .document(selectedDoc)
        .updateData(
            {'updateDate': DateTime.now(), 'worn': FieldValue.increment(1)});
  }

  updateUsedInOutfit(selectedDoc) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('clothes')
        .document(selectedDoc)
        .updateData(
            {'usedInOutfit': FieldValue.increment(1)});
  }

  updateGivenCloth(documentId, String type) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('clothes')
        .document(documentId)
        .updateData({'status': type});
  }

  Future getClothesInSustainability(String category) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    if (category == 'All Items') {
      QuerySnapshot qn = await Firestore.instance
          .collection('users')
          .document(firebaseUser.uid)
          .collection('clothes')
          .where('status', isEqualTo: 'Available')
          .getDocuments();
      return qn;
    } else if (category == 'Jacket') {
      QuerySnapshot qn = await Firestore.instance
          .collection('users')
          .document(firebaseUser.uid)
          .collection('clothes')
          .where('category', arrayContains: 'Jackets and Hoodies').where('status', isEqualTo: 'Available')
          .getDocuments();
      return qn;
    } else {
      QuerySnapshot qn = await Firestore.instance
          .collection('users')
          .document(firebaseUser.uid)
          .collection('clothes')
          .where('category', arrayContains: category).where('status', isEqualTo: 'Available')
          .getDocuments();
      return qn;
    }
  }

  // Future <DocumentSnapshot> getDocuments() async {
  //   var firebaseUser = await FirebaseAuth.instance.currentUser();
  //   QuerySnapshot result = await Firestore.instance.collection('users').document(firebaseUser.uid).collection('clothes').getDocuments();
  //   List<DocumentSnapshot> data = result.data;
  // }
}

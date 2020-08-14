import 'package:bajuku_app/models/clothes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  // Collection reference
  final firestoreInstance = Firestore.instance;
  final CollectionReference _userRef = Firestore.instance.collection('users');

  Future getClothesByCategory() async {
    final FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    return await _userRef
        .document(firebaseUser.uid)
        .collection('clothes')
        .orderBy('startDate', descending: true)
        .getDocuments();
  }

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
      "points": FieldValue.increment(0),
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
    updatePoints(5);
    var date = DateTime.now();
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
      "endDate": DateTime(date.year, date.month + 6, date.day),
      "updateDate": Timestamp.fromDate(DateTime.now()),
      "image": image,
    });
  }

  Future setOutfits(String notes, String name, String image, String totalCost, List<dynamic> taggedClothes) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    updatePoints(3);
    return await firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('outfits')
        .add({
          'notes': notes,
          'outfitName': name,
          'image': image,
          'totalCost': totalCost,
          'tagged': taggedClothes,
          'created': FieldValue.serverTimestamp(),
        });
  }

  Future setOutfit(String image, String notes, String name, String totalCost,
      dynamic clothesList) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    updatePoints(3);
    return await firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('outfits')
        .add({
      "notes": notes,
      "outfitName": name,
      "image": image,
      "totalCost": totalCost,
      "tagged": clothesList,
      "created": FieldValue.serverTimestamp(),
    });
  }

  Future setGivenOrSellClothes(Clothes clothes, String productDesc,
      String price, String condition, String type, String location) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    updateGivenCloth(clothes.documentId, type);
    updatePoints(10);
    return await firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('sustainability')
        .add({
      "created": FieldValue.serverTimestamp(),
      "productDesc": productDesc,
      "price": price,
      "condition": condition,
      'location': location,
      "clothes": clothes.toMap(),
    });
  }

  Future<String> getUid() async {
    final FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    final String uid = firebaseUser.uid;
    return uid;
  }

  Future getClothes(String category) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    if (category == 'All Items') {
      QuerySnapshot qn = await Firestore.instance
          .collection('users')
          .document(firebaseUser.uid)
          .collection('clothes')
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

  Future getClothesAvailable() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot qn = await Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('clothes')
        .where('status', isEqualTo: 'Available')
        .getDocuments();
    return qn;
  }

  Future getOutfit() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot qn = await Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('outfits')
        .orderBy('created', descending: true)
        .getDocuments();
    return qn;
  }

  Future getSustainabilityClothes(String type) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot qn = await Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('sustainability')
        .where('clothes.status', isEqualTo: type)
        .getDocuments();
    return qn;
  }

  deleteClothes(selectedDoc) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('clothes')
        .document(selectedDoc)
        .delete();
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

  updatePlannerDate(selectedDoc, selectedDate) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('clothes')
        .document(selectedDoc)
        .updateData({'endDate': selectedDate});
  }

  updateUsedInOutfit(selectedDoc) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('clothes')
        .document(selectedDoc)
        .updateData({'usedInOutfit': FieldValue.increment(1)});
  }

  updateGivenCloth(documentId, String type) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    updateGivenJournal(type, documentId);
    firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('clothes')
        .document(documentId)
        .updateData({'status': type});
  }

  updateGivenJournal(String type, documentId) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot result = await firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('outfits')
        .getDocuments();
    result.documents.forEach((e) {
      e.data['tagged'].forEach((k, v) {
        if (documentId == v['documentId']) {
          v['status'] = type;
          firestoreInstance
              .collection('users')
              .document(firebaseUser.uid)
              .collection('outfits')
              .document(e.documentID)
              .setData({
            'tagged': {
              '$k': v,
            }
          }, merge: true);
        }
      });
    });
  }

  updatePoints(var points) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .updateData({'points': FieldValue.increment(points)});
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
          .where('category', arrayContains: 'Jackets and Hoodies')
          .where('status', isEqualTo: 'Available')
          .getDocuments();
      return qn;
    } else {
      QuerySnapshot qn = await Firestore.instance
          .collection('users')
          .document(firebaseUser.uid)
          .collection('clothes')
          .where('category', arrayContains: category)
          .where('status', isEqualTo: 'Available')
          .getDocuments();
      return qn;
    }
  }

  Future getTotalClothes() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot qn = await Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('clothes')
        .orderBy('startDate', descending: true)
        .getDocuments();
    return qn;
  }

  Future getTotalValueClothes() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot qn = await Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('clothes')
        .getDocuments();
    return qn;
  }

  Future getProfile() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot qn = await Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .get();
    return qn;
  }
}

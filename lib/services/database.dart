
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
      String season,
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

  Future setOutfit( String image) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return await firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('outfits')
        .add({
      // "outfitName": name,
      "image": image,
      "created": FieldValue.serverTimestamp(),
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

  Future getClothesDetail() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('clothes')
        .getDocuments();
    return querySnapshot;
    // QuerySnapshot qn = await Firestore.instance.collection('users').document(firebaseUser.uid).collection('clothes').getDocuments().then((value) {
    //   value.documents.forEach((element) {
    //     // print(element.documentID);
    //     print(element.data);
    //   });
    // });
  }

  // Future <DocumentSnapshot> getDocuments() async {
  //   var firebaseUser = await FirebaseAuth.instance.currentUser();
  //   QuerySnapshot result = await Firestore.instance.collection('users').document(firebaseUser.uid).collection('clothes').getDocuments();
  //   List<DocumentSnapshot> data = result.data;
  // }
}

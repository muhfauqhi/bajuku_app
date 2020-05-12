import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // Collection reference
  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference clothCollection = Firestore.instance.collection('clothes');

  Future updateUserData(var clothId, String notes, String size, String fabric, String season, String brand, String status, String category, String color, int price, int wear, Timestamp date, int worn, int usedInOutfit)async{
  return await clothCollection.document(uid).setData({
    'clothId': clothId,
    'notes': notes,
    'size': size,
    'fabric': fabric,
    'season': season,
    'brand': brand,
    'category': category,
    'color': color,
    'price': price,
    'wear': wear,
    'date': Timestamp.now(),
    'worn': worn,
    'usedInOutfit': usedInOutfit,
  });
    }
  }
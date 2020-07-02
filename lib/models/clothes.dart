import 'package:cloud_firestore/cloud_firestore.dart';

class Clothes {
  String documentId;
  String brand;
  List category;
  String clothName;
  String color;
  String cost;
  Timestamp dateBought;
  Timestamp endDate;
  List fabric;
  String image;
  String price;
  String notes;
  List season;
  String size;
  Timestamp startDate;
  String status;
  Timestamp updateDate;
  String url;
  int usedInOutfit;
  int worn;

  Clothes(
    this.documentId,
    this.brand,
    this.category,
    this.clothName,
    this.color,
    this.cost,
    this.dateBought,
    this.endDate,
    this.fabric,
    this.image,
    this.price,
    this.notes,
    this.season,  
    this.size,
    this.startDate,
    this.status,
    this.updateDate,
    this.url,
    this.usedInOutfit,
    this.worn,
  );

  Map<String, dynamic> toMap() {
    return {
      "documentId": documentId,
      "brand": brand,
      "category": category,
      "clothName": clothName,
      "color": color,
      "cost": cost,
      "dateBought": dateBought,
      "endDate": endDate,
      "fabric": fabric,
      "image": image,
      "price": price,
      "notes": notes,
      "season": season,
      "size": size,
      "startDate": startDate,
      "status": status,
      "updateDate": updateDate,
      "url": url,
      "usedInOutfit": usedInOutfit,
      "worn": worn
    };
  }

  Map<String, dynamic> toMapWithOffset(String offset) {
    return {
      offset: toMap(),
    };
  }
}

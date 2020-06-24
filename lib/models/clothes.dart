import 'package:cloud_firestore/cloud_firestore.dart';

class Clothes {
  String documentId;
  String brand;
  List category;
  String clothName;
  String color;
  String cost;
  Timestamp dateBought;
  String endDate;
  List fabric;
  String image;
  String price;
  String notes;
  List season;
  String size;
  String startDate;
  String status;
  String updateDate;
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
}

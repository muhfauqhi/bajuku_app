import 'package:cloud_firestore/cloud_firestore.dart';

class Outfit{
  var image;
  var notes;
  var outfitName;
  var taggedClothes;
  var taggedClothesName;
  var totalCost;
  Timestamp created;

  Outfit(this.image, this.notes, this.outfitName, this.taggedClothes, this.taggedClothesName, this.totalCost, this.created);

}
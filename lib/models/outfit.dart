import 'package:cloud_firestore/cloud_firestore.dart';

class Outfit {
  var image;
  var notes;
  var outfitName;
  var tagged;
  var totalCost;
  Timestamp created;

  Outfit(this.image, this.notes, this.outfitName, this.tagged,
      this.totalCost, this.created);
}

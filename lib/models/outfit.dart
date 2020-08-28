import 'package:cloud_firestore/cloud_firestore.dart';

class Outfit {
  final documentId;
  final image;
  final notes;
  final outfitName;
  final tagged;
  final totalCost;
  Timestamp created;

  Outfit(this.documentId,this.image, this.notes, this.outfitName, this.tagged, this.totalCost,
      this.created);
}

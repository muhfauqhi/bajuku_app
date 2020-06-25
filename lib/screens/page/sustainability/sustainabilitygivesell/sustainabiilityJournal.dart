import 'package:bajuku_app/models/outfit.dart';
import 'package:bajuku_app/screens/template/detailOutfit.dart';
import 'package:flutter/material.dart';

class SustainDetailJournal extends StatelessWidget {
  final Outfit outfit;
  final String type;

  SustainDetailJournal({Key key, this.outfit, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutfitDetail(
      title: 'Your Journal',
      outfit: outfit,
      buttonWorn: false,
      type: type,
    );
  }
}

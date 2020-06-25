import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/template/detailClothes.dart';
import 'package:flutter/material.dart';

class SustainDetailWardrobe extends StatelessWidget {
  final Clothes clothes;
  final String title;
  final String type;

  SustainDetailWardrobe({this.clothes, this.title, this.type});

  @override
  Widget build(BuildContext context) {
    return ClothesDetail(
      title: title,
      clothes: clothes,
      buttonWorn: false,
      type: type,
    );
  }
}

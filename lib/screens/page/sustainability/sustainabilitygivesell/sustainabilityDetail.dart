import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/template/detailClothes.dart';
import 'package:flutter/material.dart';

class SustainDetail extends StatelessWidget {
  final Clothes clothes;
  final String title;

  SustainDetail({this.clothes, this.title});

  @override
  Widget build(BuildContext context) {
    return ClothesDetail(
      title: title,
      clothes: clothes,
      buttonWorn: false,
    );
  }
}

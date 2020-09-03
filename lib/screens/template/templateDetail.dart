import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/template/detailClothes.dart';
import 'package:flutter/material.dart';

class TemplateDetail extends StatelessWidget {
  final Clothes clothes;
  TemplateDetail({this.clothes});
  @override
  Widget build(BuildContext context) {
    return ClothesDetail(
      title: 'Clothes Detail',
      clothes: clothes,
      buttonWorn: true,
    );
  }
}
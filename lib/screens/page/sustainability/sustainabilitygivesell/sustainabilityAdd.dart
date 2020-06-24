import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:flutter/material.dart';

class SustainAdd extends StatelessWidget {
  final Clothes clothes;
  final String title;

  SustainAdd({this.clothes, this.title});
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      titleStyle: false,
      leadingActive: true,
      title: title,
      headerWidget: [],
      body: Text('test'),
    );
  }
}

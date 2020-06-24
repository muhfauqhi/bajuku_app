import 'package:bajuku_app/models/givenClothes.dart';
import 'package:flutter/material.dart';

class CardSmall extends StatelessWidget {
  final GivenClothes givenClothes;

  CardSmall({this.givenClothes});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Small'),
    );
  }
}
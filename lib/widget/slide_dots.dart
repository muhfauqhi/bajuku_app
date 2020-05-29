import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      height: isActive? 12 : 8,
      width: isActive? 12 : 8,
      decoration: BoxDecoration(
        color: Hexcolor('#33444F'),
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      );
  }
}
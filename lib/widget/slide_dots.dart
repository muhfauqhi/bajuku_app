import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SlideDots extends StatelessWidget {
  final bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: isActive ? Hexcolor('#33444F') : Hexcolor('#D3D3D3'),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Indicator extends StatelessWidget {
  final String color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: Hexcolor('#$color'),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff505050)),
        )
      ],
    );
  }
}

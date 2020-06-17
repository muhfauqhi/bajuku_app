import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TagsPositioned extends StatefulWidget {
  final Rect myRect;
  final String documentId;
  final String clothName;
  final String category;

  TagsPositioned({this.myRect, this.documentId, this.category, this.clothName});

  @override
  _TagsPositionedState createState() => _TagsPositionedState();
}

class _TagsPositionedState extends State<TagsPositioned> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
      rect: widget.myRect,
      child: Container(
        padding: EdgeInsets.all(5),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.clothName,
                style: TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.w600,
                  color: Hexcolor('#3F4D55'),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.category,
                style: TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.w600,
                  color: Hexcolor('#859289'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class BottomNavbar extends StatefulWidget {
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Hexcolor('#F8F8F8'),
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            height: 30,
            width: 30,
            child: GestureDetector(
              child: Image.asset('assets/images/undoCloth.png'),
              onTap: () {},
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
            height: 30,
            width: 30,
            child: GestureDetector(
              child: Image.asset('assets/images/autoremove.png'),
              onTap: () {},
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            height: 30,
            width: 30,
            child: GestureDetector(
              child: Image.asset('assets/images/eraser.png'),
              onTap: () {},
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            height: 30,
            width: 30,
            child: GestureDetector(
              child: Image.asset('assets/images/cropcloth.png'),
              onTap: () {},
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            height: 30,
            width: 30,
            child: GestureDetector(
              child: Image.asset('assets/images/redo.png'),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

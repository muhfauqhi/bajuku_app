import 'dart:io';

import 'package:bajuku_app/screens/page/outfit/tagImage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomNavbarOutfit extends StatefulWidget {
  final File file;
  final List<Widget> children;

  CustomNavbarOutfit({this.file, this.children});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomNavbarOutfit> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Hexcolor('#F8F8F8'),
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            height: 35,
            width: 35,
            child: GestureDetector(
              child: Image.asset('assets/images/homenav.png'),
              onTap: () {},
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            height: 35,
            width: 35,
            child: GestureDetector(
              child: Image.asset('assets/images/cil_tags.png'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => new TagImage(
                      file: widget.file,
                      children: widget.children,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            height: 35,
            width: 35,
            child: GestureDetector(
              child: Image.asset('assets/images/profilenav.png'),
              onTap: () {},
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            height: 35,
            width: 35,
            child: GestureDetector(
              child: Image.asset('assets/images/profilenav.png'),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/page/outfit/tagImage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomNavbarOutfit extends StatefulWidget {
  final File file;
  final List<Widget> children;
  final List<Clothes> clothesList;

  CustomNavbarOutfit({this.file, this.children, this.clothesList});

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
            height: 40,
            width: 40,
            child: GestureDetector(
              child: Image.asset('assets/images/uil_image-edit.png'),
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
                      clothesList: widget.clothesList,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            height: 30,
            width: 30,
            child: GestureDetector(
              child: Image.asset('assets/images/undo.png'),
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

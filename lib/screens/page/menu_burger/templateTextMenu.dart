import 'package:bajuku_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TextMenu extends StatefulWidget {
  final route;
  final String text;
  TextMenu({this.route, this.text});

  @override
  _TextMenuState createState() => _TextMenuState();
}

class _TextMenuState extends State<TextMenu> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 42,
        child: Container(
          margin: EdgeInsets.only(left: 30, top: 5),
          child: Text(
            widget.text,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Hexcolor(color())),
          ),
        ),
      ),
      onTap: () async {
        if (widget.text == 'Logout') {
          await _auth.signOut();
        } else {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => widget.route));
        }
      },
    );
  }

  String color() {
    if (widget.text == 'Logout') {
      return "#D96969";
    } else {
      return "#516E6F";
    }
  }
}

import 'package:bajuku_app/screens/page/addItem/addChoice.dart';
import 'package:bajuku_app/screens/page/menu_burger/routingPage/profile.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainablehome.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
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
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new SustainableHome(
                              title: 'Sustainability',
                            )));
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            height: 35,
            width: 35,
            child: GestureDetector(
              child: Image.asset('assets/images/addnav.png'),
              onTap: () {
                showDialog(
                  context: context,
                  child: AddChoiceDialog(),
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
              onTap: () {
              },
            ),
          ),
        ],
      ),
    );
  }
}

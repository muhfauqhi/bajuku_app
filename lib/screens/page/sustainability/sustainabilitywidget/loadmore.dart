import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LoadMore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
            margin: EdgeInsets.only(right: 15.0),
            child: Divider(
              thickness: 2.0,
              height: 150,
            )),
      ),
      Text(
        'Load More',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
          color: Hexcolor('#3F4D55')
        ),
      ),
      Expanded(
        child: Container(
            margin: EdgeInsets.only(left: 15.0),
            child: Divider(
              thickness: 2.0,
              height: 150,
            )),
      ),
    ]);
  }
}

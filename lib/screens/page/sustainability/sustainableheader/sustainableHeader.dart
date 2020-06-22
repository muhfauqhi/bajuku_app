import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HeaderWidget extends StatelessWidget {
  final String asset;
  final String title;
  final bool headerButton;
  HeaderWidget({this.asset, this.title, this.headerButton});

  @override
  Widget build(BuildContext context) {
    return headerButton ? buildButton() : buildTitle();
  }

  Widget buildButton() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: GestureDetector(
            child: Image.asset(
              'assets/images/$asset',
              height: 50,
            ),
            onTap: () {
              // TODO: implement onTap
            },
          ),
        ),
        buildTitle(),
      ],
    );
  }

  Widget buildTitle() {
    return Column(
      children: [
        Divider(
          color: Hexcolor('#FFFFFF'),
          thickness: 2.0,
        ),
        Row(
          children: <Widget>[
            Container(
              width: 340,
              margin: EdgeInsets.only(left: 25, top: 12),
              child: Text(
                '$title',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  color: Hexcolor('#3F4D55'),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              child: Image.asset(
                'assets/images/jam_settings-alt.png',
                height: 25,
              ),
            )
          ],
        ),
      ],
    );
  }
}

import 'package:bajuku_app/models/company.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CardLarge extends StatelessWidget {
  final Company company;
  final Function onTap;

  CardLarge({this.company, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20.0, top: 20.0),
                child: Image.asset(
                  'assets/images/${company.asset}.png',
                  width: 80,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                margin: EdgeInsets.only(left: 20.0, bottom: 15.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                      alignment: Alignment(-1, 0),
                      child: Text(
                        company.title,
                        style: TextStyle(
                          color: Hexcolor('#3F4D55'),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      company.text,
                      style: TextStyle(
                        color: Hexcolor('#859289'),
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20.0, top: 30.0),
                child: GestureDetector(
                  child: Text(
                    'Read the detail of the organisation here',
                    style: TextStyle(
                      color: Hexcolor('#E1B359'),
                      fontSize: 8.0,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 65.0),
                child: GestureDetector(
                  child: Image.asset(
                    'assets/images/${company.button}Button.png',
                    height: 40.0,
                  ),
                  onTap: () {
                    onTap();
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

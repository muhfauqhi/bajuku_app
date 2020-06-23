import 'package:bajuku_app/screens/page/sustainability/sustainabilitywidget/loadmore.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainablebuildtemplate.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainabledonate.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainablegiven.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainableheader/sustainableHeader.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainablesale.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainableupkeep.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SustainableHome extends StatefulWidget {
  final String title;
  SustainableHome({this.title});
  @override
  _SustainableHomeState createState() => _SustainableHomeState();
}

class _SustainableHomeState extends State<SustainableHome> {
  @override
  Widget build(BuildContext context) {
    return SustainableTemplate(
      title: widget.title,
      headerWidget: Column(
        children: <Widget>[
          Container(
            color: Hexcolor('#FFFFFF'),
            height: 108.0,
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  buildButton(15.0, 25.0, 'Given.png',
                      SustainableGiven(title: 'Given')),
                  buildButton(
                      15.0, 0.0, 'Sale.png', SustainableSale(title: 'Sale')),
                  buildButton(15.0, 0.0, 'Group14.png',
                      SustainableUpkeep(title: 'Upkeep')),
                  buildButton(25.0, 0.0, 'Group13.png',
                      SustainableDonate(title: 'Donate')),
                ],
              ),
            ),
          ),
          HeaderWidgetSustainability(
            title: 'Feed',
            titleActive: true,
            headerButton: false,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(25),
              child: Column(
                children: [
                  buildFeed('feed1', 'Ryan Young', sustain('Sale'), '20 Mins',
                      'Trench Coat Zara', '€5', ' 89'),
                  buildFeed('feed2', 'Emily Blunt', sustain('Given'), 'An Hour',
                      'HnM Khaki Trousers', 'Free', ' 21'),
                ],
              ),
            ),
            LoadMore(),
          ],
        ),
      ),
    );
  }

  Widget sustain(var text) {
    if (text == 'Sale') {
      return Text(
        text,
        style: TextStyle(
            color: color(text), fontSize: 16.0, fontWeight: FontWeight.bold),
      );
    } else {
      return Text(
        text,
        style: TextStyle(
            color: color(text), fontSize: 16.0, fontWeight: FontWeight.bold),
      );
    }
  }

  Hexcolor color(var type) {
    if (type == 'Sale') {
      return Hexcolor('#E1B359');
    } else {
      return Hexcolor('#4AA081');
    }
  }

  Widget buildFeed(var profile, var profileName, var sustain, var time,
      var title, var price, var likes) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5.0),
          height: 50,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 35.0),
                child: Image.asset('assets/images/profile$profile.png'),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      profileName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      '$time Ago',
                      style: TextStyle(
                        color: Hexcolor('#9D9D9D'),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 118,
                margin: EdgeInsets.only(bottom: 15.0, left: 10),
                child: Row(
                  children: [
                    Text(
                      'Created for ',
                      style: TextStyle(
                        color: Hexcolor('#9D9D9D'),
                        fontSize: 12.0,
                      ),
                    ),
                    sustain
                  ],
                ),
              ),
              Container(
                child: Image.asset(
                  'assets/images/more.png',
                  height: 13,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 300,
          child: Image.asset('assets/images/$profile.png'),
        ),
        Container(
          height: 50,
          margin: EdgeInsets.only(bottom: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Container(
                    width: 250,
                    margin: EdgeInsets.only(left: 35.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        letterSpacing: 1.0,
                        color: Hexcolor('#3F4D55'),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/love.png',
                          height: 15.0,
                        ),
                        Text(
                          likes,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                            color: Hexcolor('#859289'),
                            fontSize: 12.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment(-1, 0),
                margin: EdgeInsets.only(left: 35.0),
                child: Text(
                  price,
                  style: TextStyle(
                    letterSpacing: 1.0,
                    color: Hexcolor('#859289'),
                    fontSize: 16.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildButton(var right, var left, var asset, var sustainable) {
    return Container(
      margin: EdgeInsets.only(right: right, left: left),
      child: GestureDetector(
        child: Image.asset(
          'assets/images/$asset',
          height: 65,
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => sustainable));
        },
      ),
    );
  }
}

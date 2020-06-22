import 'package:bajuku_app/screens/page/sustainability/sustainablebuildtemplate.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainabledonate.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainablegiven.dart';
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
      headerWidget: Container(
        color: Hexcolor('#FFFFFF'),
        height: 108.0,
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              buildButton(15.0, 25.0, 'Given.png', SustainableGiven(title: 'Given')),
              buildButton(15.0, 0.0, 'Sale.png', SustainableSale(title: 'Sale')),
              buildButton(15.0, 0.0, 'Group14.png', SustainableUpkeep(title: 'Upkeep')),
              buildButton(25.0, 0.0, 'Group13.png', SustainableDonate(title: 'Donate')),
            ],
          ),
        ),
      ),
      body: Column(
        children: [],
      ),
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
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> sustainable));
        },
      ),
    );
  }
}

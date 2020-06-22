import 'package:bajuku_app/screens/page/sustainability/sustainablebuildtemplate.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainableheader/sustainableHeader.dart';
import 'package:flutter/material.dart';

class SustainableGiven extends StatefulWidget {
  final String title;
  SustainableGiven({this.title});
  @override
  _SustainableGivenState createState() => _SustainableGivenState();
}

class _SustainableGivenState extends State<SustainableGiven> {
  @override
  Widget build(BuildContext context) {
    return SustainableTemplate(
      title: widget.title,
      headerWidget: HeaderWidget(asset: 'buttongiven.png', title: widget.title,),
      body: Text(''),
    );
  }
}

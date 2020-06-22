import 'package:bajuku_app/screens/page/sustainability/sustainablebuildtemplate.dart';
import 'package:flutter/material.dart';

class SustainableUpkeep extends StatefulWidget {
  final String title;
  SustainableUpkeep({this.title});
  @override
  _SustainableUpkeepState createState() => _SustainableUpkeepState();
}

class _SustainableUpkeepState extends State<SustainableUpkeep> {
  @override
  Widget build(BuildContext context) {
    return SustainableTemplate(
      title: widget.title,
      headerWidget: Text(''),
      body: Text(''),
    );
  }
}

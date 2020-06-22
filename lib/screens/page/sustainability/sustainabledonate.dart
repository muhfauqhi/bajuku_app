import 'package:bajuku_app/screens/page/sustainability/sustainablebuildtemplate.dart';
import 'package:flutter/material.dart';

class SustainableDonate extends StatefulWidget {
  final String title;
  SustainableDonate({this.title});
  @override
  _SustainableDonateState createState() => _SustainableDonateState();
}

class _SustainableDonateState extends State<SustainableDonate> {
  @override
  Widget build(BuildContext context) {
    return SustainableTemplate(
      title: widget.title,
      headerWidget: Text(''),
      body: Text(''),
    );
  }
}

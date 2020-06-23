import 'package:bajuku_app/screens/page/sustainability/sustainabilitywidget/sustainabilitygridview.dart';
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
      headerWidget: HeaderWidgetSustainability(
        asset: 'buttongiven.png',
        title: widget.title + ' Items',
        headerButton: true,
        titleActive: false,
      ),
      body: GridViewSustainability(),
    );
  }
}

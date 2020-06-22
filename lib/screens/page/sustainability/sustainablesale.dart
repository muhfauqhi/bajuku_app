import 'package:bajuku_app/screens/page/sustainability/sustainablebuildtemplate.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainableheader/sustainableHeader.dart';
import 'package:flutter/material.dart';

class SustainableSale extends StatefulWidget {
  final String title;
  SustainableSale({this.title});
  @override
  _SustainableSaleState createState() => _SustainableSaleState();
}

class _SustainableSaleState extends State<SustainableSale> {
  @override
  Widget build(BuildContext context) {
    return SustainableTemplate(
      title: widget.title,
      headerWidget: HeaderWidgetSustainability(
        asset: 'buttonsale.png',
        title: widget.title + ' Items',
        headerButton: true,
      ),
      body: Text(''),
    );
  }
}

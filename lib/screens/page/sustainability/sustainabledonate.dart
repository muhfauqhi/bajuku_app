import 'package:bajuku_app/screens/home/bottomnavigationbar.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainabilitywidget/sustainabilitygridview.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainablebuildtemplate.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainableheader/sustainableHeader.dart';
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
      // bottomNavigationBar: CustomBottomNavigationBar(),
      title: widget.title,
      headerWidget: HeaderWidgetSustainability(
        headerButton: false,
        title: 'Charity Organisations',
        titleActive: false,
      ),
      body: GridViewSustainability(
        category: 'Donate',
        cardLarge: true,
        crossAxisCount: 1,
        itemCount: 4,
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: MediaQuery.of(context).size.height /
            (MediaQuery.of(context).size.width / 1.25),
      ),
    );
  }
}

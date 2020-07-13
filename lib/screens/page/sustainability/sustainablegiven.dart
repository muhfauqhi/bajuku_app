import 'package:bajuku_app/models/sustainabilityClothes.dart';
import 'package:bajuku_app/screens/home/bottomnavigationbar.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainabilitywidget/sustainabilitygridview.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainablebuildtemplate.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainableheader/sustainableHeader.dart';
import 'package:bajuku_app/services/database.dart';
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
      bottomNavigationBar: CustomBottomNavigationBar(),
      title: widget.title,
      headerWidget: HeaderWidgetSustainability(
        type: 'Given',
        asset: 'buttongiven.png',
        title: widget.title + ' Items',
        headerButton: true,
        titleActive: false,
      ),
      body: FutureBuilder(
        future: DatabaseService().getSustainabilityClothes('Given'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('');
          } else {
            List<SustainabilityClothes> sustainClothList = [];
            for (var i in snapshot.data.documents) {
              sustainClothList.add(
                SustainabilityClothes(
                  i.data['productDesc'],
                  i.data['price'],
                  i.data['condition'],
                  i.data['clothes'],
                  i.data['location'],
                ),
              );
            }
            return GridViewSustainability(
              sustainabilityClothes: sustainClothList,
              category: '',
              cardLarge: false,
              crossAxisCount: 2,
              itemCount: sustainClothList.length,
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.25),
            );
          }
        },
      ),
    );
  }
}

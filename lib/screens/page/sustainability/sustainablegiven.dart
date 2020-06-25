import 'package:bajuku_app/models/givenClothes.dart';
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
        asset: 'buttongiven.png',
        title: widget.title + ' Items',
        headerButton: true,
        titleActive: false,
      ),
      body: FutureBuilder(
        future: DatabaseService().getGivenClothes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('');
          } else {
            List<GivenClothes> givenClothList = [];
            for (var i in snapshot.data.documents) {
              givenClothList.add(
                GivenClothes(
                  i.data['clothes'],
                  i.data['productDesc'],
                  i.data['price'],
                  i.data['condition'],
                ),
              );
            }
            return GridViewSustainability(
              givenCloth: givenClothList,
              category: '',
              cardLarge: false,
              crossAxisCount: 2,
              itemCount: givenClothList.length,
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

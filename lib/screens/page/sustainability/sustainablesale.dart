import 'package:bajuku_app/models/givenClothes.dart';
import 'package:bajuku_app/screens/home/bottomnavigationbar.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainabilitywidget/sustainabilitygridview.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainablebuildtemplate.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainableheader/sustainableHeader.dart';
import 'package:bajuku_app/services/database.dart';
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
      bottomNavigationBar: CustomBottomNavigationBar(),
      headerWidget: HeaderWidgetSustainability(
        asset: 'buttonsale.png',
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
          }),
    );
  }
}

import 'package:bajuku_app/models/sustainabilityClothes.dart';
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
      // bottomNavigationBar: CustomBottomNavigationBar(),
      headerWidget: HeaderWidgetSustainability(
        type: 'Sold',
        asset: 'buttonsale.png',
        title: widget.title + ' Items',
        headerButton: true,
        titleActive: false,
      ),
      body: FutureBuilder(
          future: DatabaseService().getSustainabilityClothes('Sold'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('');
            } else {
              List<SustainabilityClothes> sustainClothList = [];
              for (var i in snapshot.data.documents) {
                sustainClothList.add(
                  SustainabilityClothes(
                    i.data['clothes'],
                    i.data['productDesc'],
                    i.data['price'],
                    i.data['condition'],
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
          }),
    );
  }
}

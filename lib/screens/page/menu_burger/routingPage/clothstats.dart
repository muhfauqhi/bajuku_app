import 'package:bajuku_app/screens/page/menu_burger/template/sliverappbartemplate.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ClothingStats extends StatelessWidget {
  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return MenuBurgerScaffold(
      title: 'Clothing Statistic',
      profileName: 'Test Toang',
      profilePict: 'TT',
      profileCreated: '2020',
      leftBox: FutureBuilder(
        future: databaseService.getTotalClothes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('');
          } else {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Item Counts',
                    style: myTextStyle(
                      FontWeight.w600,
                      16.0,
                      FontStyle.normal,
                      '#000000',
                      1.0,
                    ),
                  ),
                  Text(
                    snapshot.data.documents.length.toString(),
                    style: myTextStyle(
                      FontWeight.w800,
                      20.0,
                      FontStyle.normal,
                      '#6EAAB8',
                      1.0,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      rightBox: FutureBuilder(
        future: databaseService.getTotalClothes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('');
          } else {
            List<String> clothesPrice = [];
            var total = 0.0;
            for (var i in snapshot.data.documents) {
              clothesPrice.add(
                i.data['price'],
              );
            }
            List<double> clothesPriceTotal =
                clothesPrice.map(double.parse).toList();
            clothesPriceTotal.forEach((e) {
              total += e;
            });
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Total Closet Value',
                    style: myTextStyle(
                      FontWeight.w600,
                      16.0,
                      FontStyle.normal,
                      '#000000',
                      1.0,
                    ),
                  ),
                  Text(
                    '€ ' + total.toString(),
                    style: myTextStyle(
                      FontWeight.w800,
                      20.0,
                      FontStyle.normal,
                      '#D96969',
                      1.0,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      contentSliver: Text(''),
      body: Text(''),
    );
  }

  TextStyle myTextStyle(FontWeight fontWeight, double fontSize,
      FontStyle fontStyle, String color, double letterSpacing) {
    return TextStyle(
      fontSize: fontSize,
      fontStyle: fontStyle,
      color: Hexcolor('$color'),
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    );
  }
}

import 'package:bajuku_app/screens/page/menu_burger/template/sliverappbartemplate.dart';
import 'package:bajuku_app/screens/page/menu_burger/template/statlisttemplate.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SustainAbilityStats extends StatelessWidget {
  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return MenuBurgerScaffold(
      title: 'Sustainability Statistic',
      profileName: 'Michella Yosephin',
      profilePict: 'MY',
      profileCreated: '2019',
      leftBox: FutureBuilder(
        future: databaseService.getProfile(),
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
                    'Points',
                    style: myTextStyle(
                      FontWeight.w600,
                      16.0,
                      FontStyle.normal,
                      '#000000',
                      1.0,
                    ),
                  ),
                  Text(
                    snapshot.data['points'].toString(),
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
        future: databaseService.getSustainabilityClothes('Sold'),
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
                    'Total Earnings',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            StatsListTemplate(
              widget: 'normal',
              color: '#FBFBFB',
              marginTop: 5.0,
              titleText: 'Clothes Given',
              subtitleText: '',
              function: () {
                print('Halo');
              },
            ),
            StatsListTemplate(
              widget: 'normal',
              color: '#F8F8F8',
              marginTop: 25.0,
              titleText: 'Recently Added',
              subtitleText: '10 most recently added',
              function: () {
                print('Halo');
              },
            ),
            StatsListTemplate(
              widget: 'normal',
              color: '#FBFBFB',
              marginTop: 25.0,
              titleText: 'Clothes donated',
              subtitleText: 'in 6 months',
              function: () {
                print('Halo');
              },
            ),
            StatsListTemplate(
              widget: 'normal',
              color: '#F8F8F8',
              marginTop: 25.0,
              titleText: 'Clothes sold',
              subtitleText: '',
              function: () {
                print('Halo');
              },
            ),
            StatsListTemplate(
              widget: 'custom',
              color: '#FBFBFB',
              marginTop: 25.0,
              titleText: 'Cost per Wear',
              subtitleText: 'The best and the worst',
              customTextStyle: myTextStyle(
                  FontWeight.normal, 12.0, FontStyle.normal, '#3F4D55', 1.0),
              function: () {
                print('Halo');
              },
            ),
            StatsListTemplate(
              widget: 'custom',
              color: '#F8F8F8',
              marginTop: 25.0,
              titleText: 'Purchase Price',
              subtitleText: 'The most expensive and least expensive',
              customTextStyle: myTextStyle(
                  FontWeight.normal, 12.0, FontStyle.normal, '#3F4D55', 1.0),
              function: () {
                print('Halo');
              },
            ),
          ],
        ),
      ),
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

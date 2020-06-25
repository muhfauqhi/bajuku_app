import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainabilitygivesell/sustainabilityWardrobe.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SustainCategory extends StatelessWidget {
  final List<Clothes> clothesList;
  final String title;
  final String type;

  SustainCategory({this.clothesList, this.title, this.type});
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      actions: [
        GestureDetector(
          child: Container(
            margin: EdgeInsets.only(right: 10.0),
            child: Image.asset(
              'assets/images/close.png',
              width: 25,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
      leadingActive: true,
      titleStyle: true,
      titleTextStyle: TextStyle(
        color: Hexcolor('#3F4D55'),
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
      title: title,
      headerWidget: [],
      body: Container(
        margin: EdgeInsets.only(left: 25.0, right: 25.0),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: clothesList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Card(
                elevation: 2.0,
                child: Container(
                  child: Image.network(
                    clothesList[index].image,
                    fit: BoxFit.fitWidth,
                  ),
                  decoration: BoxDecoration(
                    color: Hexcolor('#FFFFFF'),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SustainDetailWardrobe(
                      clothes: clothesList[index],
                      title: title,
                      type: type,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

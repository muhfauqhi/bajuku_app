import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainabilitygivesell/sustainabilityCategory.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SustainScaffoldWardrobe extends StatelessWidget {
  final String type;

  SustainScaffoldWardrobe({Key key, this.type}) : super(key: key);

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
      leadingActive: false,
      titleStyle: true,
      titleTextStyle: TextStyle(
        color: Hexcolor('#3F4D55'),
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
      title: 'Your Wardrobe',
      headerWidget: [],
      body: Column(
        children: <Widget>[
          rowCategory('All Items', 'allitems', 'Jacket', 'jacket_asset'),
          rowCategory('Jeans', 'jeans_asset', 'Bags', 'bags_asset'),
        ],
      ),
    );
  }

  Widget rowCategory(var cat1, var catAsset1, var cat2, var catAsset2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildWidget(cat1, catAsset1),
        buildWidget(cat2, catAsset2),
      ],
    );
  }

  Widget buildWidget(var category, var asset) {
    return FutureBuilder(
      future: DatabaseService().getClothes(category),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Container(
                        alignment: Alignment(-1, 0),
                        child: Image.asset(
                          'assets/images/$asset.png',
                          width: 175,
                        ),
                      ),
                      onTap: () {
                        List<Clothes> clothesList = [];
                        for (var i in snapshot.data.documents) {
                          clothesList.add(
                            Clothes(
                              i.documentID,
                              i.data['brand'],
                              i.data['category'],
                              i.data['clothName'],
                              i.data['color'],
                              i.data['cost'],
                              i.data['dateBought'],
                              i.data['endDate'],
                              i.data['fabric'],
                              i.data['image'],
                              i.data['price'],
                              i.data['notes'],
                              i.data['season'],
                              i.data['size'],
                              i.data['startDate'],
                              i.data['status'],
                              i.data['updateDate'],
                              i.data['url'],
                              i.data['usedInOutfit'],
                              i.data['worn'],
                            ),
                          );
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SustainCategory(
                              clothesList: clothesList,
                              title: category,
                              type: type,
                            ),
                          ),
                        );
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5.0),
                      alignment: Alignment(-1, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            category,
                            style: textStyle('#3F4D55', FontWeight.bold, 1.0),
                          ),
                          Text(
                            snapshot.data.documents.length.toString() +
                                ' Pieces',
                            style: textStyle('#859289'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Text('');
      },
    );
  }

  TextStyle textStyle(var color, [var bold, var letterSpacing]) {
    return TextStyle(
      letterSpacing: letterSpacing,
      fontWeight: bold,
      fontSize: 16.0,
      color: Hexcolor(color),
    );
  }
}

import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainabilitygivesell/sustainabilityCategory.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:bajuku_app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SustainScaffoldWardrobe extends StatelessWidget {
  final String type;

  SustainScaffoldWardrobe({Key key, this.type}) : super(key: key);

  final DatabaseService _databaseService = DatabaseService();

  Future fetchData() async {
    List<String> categories = [];
    QuerySnapshot snapshot = await _databaseService.getClothesByCategory();
    String urlLastImage;
    Set<Map<String, Object>> categoryWithImage = {};
    int index = 0;
    var documents = snapshot.documents;

    if (documents.isEmpty || documents.length == 0) {
      return null;
    } else {
      documents.forEach((e) {
        var category = e.data['category'][0];
        var status = e.data['status'];

        if (!categories.any((element) => element.contains(category))) {
          if (status == 'Available') {
            categories.add(category);
          }
        }
      });

      categories.forEach((e) {
        var i = 0;
        documents.forEach((doc) {
          if (doc.data['category'][0] == e &&
              doc.data['status'] == 'Available') {
            i++;
            if (categoryWithImage.isEmpty) {
              categoryWithImage.add({
                e: i,
                'image': doc.data['image'],
              });
            } else if (categoryWithImage
                .toList()
                .any((element) => element.containsKey(e))) {
              categoryWithImage
                  .toList()
                  .elementAt(index)
                  .update(e, (value) => i);
            } else if (!categoryWithImage
                .toList()
                .any((element) => element.containsKey(e))) {
              categoryWithImage.add({
                e: i,
                'image': doc.data['image'],
              });
            }
          }
        });
        index++;
      });
      return categoryWithImage;
    }
  }

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
      body: Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null) {
                  return Container();
                } else {
                  return GridView.builder(
                    itemCount: snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 15.0,
                    ),
                    itemBuilder: (context, index) {
                      List<Clothes> clothesList = [];

                      // clothesList.add(
                      //   Clothes(documentId, brand, category, clothName, color, cost, dateBought, endDate, fabric, image, price, notes, season, size, startDate, status, updateDate, url, usedInOutfit, worn)
                      // );
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SustainCategory(
                                            // clothesList: clothesList,
                                            type: type,
                                            title:
                                                '${snapshot.data.toList()[index].keys.elementAt(0)}',
                                          )));
                            },
                            child: Card(
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        '${snapshot.data.toList()[index].values.elementAt(1)}'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${snapshot.data.toList()[index].keys.elementAt(0)}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Color(0xff3F4D55),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                Text(
                                  '${snapshot.data.toList()[index].values.elementAt(0)} Pieces',
                                  style: TextStyle(
                                    color: Color(0xff859289),
                                    fontSize: 16.0,
                                    letterSpacing: 1.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              } else {
                return Loading();
              }
            }),
      ),
      // body: Column(
      //   children: <Widget>[
      //     rowCategory('All Items', 'allitems', 'Jacket', 'jacket_asset'),
      //     rowCategory('Jeans', 'jeans_asset', 'Bags', 'bags_asset'),
      //   ],
      // ),
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
      future: DatabaseService().getClothesInSustainability(category),
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

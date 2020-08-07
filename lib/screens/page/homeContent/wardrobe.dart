import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/template/templateCategories.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class Wardrobe extends StatelessWidget {
  final CollectionReference userRef;
  final String uid;
  Wardrobe({this.userRef, this.uid});

  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment(1, 0),
            width: MediaQuery.of(context).size.width * 0.75,
            child: IconButton(
              icon: Image.asset(
                'assets/images/seeall@3x.png',
                width: 40,
              ),
              iconSize: 40,
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new TemplateCategories(
                              categories: "All Items",
                            )));
              },
            ),
          ),
          _buildAllItems(context),
          Container(
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
                future: DatabaseService().getClothes('All Items'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 50),
                              child: Text(
                                '',
                                style: TextStyle(
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Hexcolor('#3F4D55'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 50, right: 83),
                              child: Text(
                                'Pieces',
                                style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Hexcolor('#859289'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 80),
                              child: Text(
                                '',
                                style: TextStyle(
                                  letterSpacing: 1.0,
                                  color: Hexcolor('#859289'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 20.0),
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Row(
                            children: <Widget>[
                              Text(
                                snapshot.data.documents.length.toString(),
                                style: TextStyle(
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Hexcolor('#3F4D55'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Text(
                                  'Pieces',
                                  style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Hexcolor('#859289'),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: StreamBuilder(
                                    stream: userRef.document(uid).snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Text('');
                                      } else {
                                        var m =
                                            snapshot.data['created'].toDate();
                                        var y =
                                            snapshot.data['created'].toDate();
                                        String month =
                                            new DateFormat('MMMM').format(m);
                                        String year =
                                            new DateFormat('yy').format(y);
                                        return Container(
                                          width: 180,
                                          alignment: Alignment(1, 0),
                                          child: Text(
                                            'Since ' + month + ' \'' + year,
                                            style: TextStyle(
                                              letterSpacing: 1.0,
                                              color: Hexcolor('#859289'),
                                            ),
                                          ),
                                        );
                                      }
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                }),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment(-0.4, 0),
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Image.asset(
                    "assets/images/categories_asset.png",
                    width: 150.0,
                    height: 25.0,
                  ),
                ),
                Container(
                  alignment: Alignment(0.9, 0),
                  child: IconButton(
                      icon: new Image.asset('assets/images/seeall@3x.png'),
                      iconSize: 40,
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new TemplateCategories(
                                      categories: "All Items",
                                    )));
                      }),
                ),
              ],
            ),
          ),
          _buildCategories(context),
        ],
      ),
    );
  }

  Widget _buildCategories(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          _buildTemplateRowCategory(
            'Tops',
            'Jacket',
            'assets/images/tops_asset.png',
            'assets/images/jacket_asset.png',
            TemplateCategories(
              categories: "Tops",
            ),
            TemplateCategories(
              categories: "Jackets and Hoodies",
            ),
          ),
          _buildTemplateRowCategory(
            'Jeans',
            'Bags',
            'assets/images/jeans_asset.png',
            'assets/images/bags_asset.png',
            TemplateCategories(categories: "Jeans"),
            TemplateCategories(categories: "Bags"),
          ),
        ],
      ),
    );
  }

  Widget _buildAllItems(var context) {
    return StreamBuilder(
        stream: userRef
            .document(uid)
            .collection('clothes')
            .orderBy('startDate', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data.documents.isEmpty) {
              return GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: AspectRatio(
                    aspectRatio: 2 / 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        'assets/images/allitems.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new TemplateCategories(
                                categories: "All Items",
                              )));
                },
              );
            } else {
              List<Clothes> clothesList = [];
              for (var i in snapshot.data.documents) {
                if (i.data['status'] == 'Available') {
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
              }
              return GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        '${clothesList[clothesList.length - 1].image}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new TemplateCategories(
                                categories: "All Items",
                              )));
                },
              );
            }
          } else {
            return Text('');
          }
        });
  }

  Future<String> getCurrentUID() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid;
    return uid;
  }

  Widget _buildTemplateRowCategory(
      var leftCategory,
      var rightCategory,
      var leftAsset,
      var rightAsset,
      var leftCategoryRoute,
      var rightCategoryRoute) {
    return Container(
      margin: EdgeInsets.only(bottom: 30.0),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              FutureBuilder(
                  future: DatabaseService().getClothes(leftCategory),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('');
                    } else {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: GestureDetector(
                                child: Container(
                                  child: Image.asset(
                                    leftAsset,
                                    fit: BoxFit.cover,
                                    height: 150.0,
                                    width: 150.0,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              leftCategoryRoute));
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Text(
                                leftCategory,
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Hexcolor('#3F4D55'),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Text(
                                snapshot.data.documents.length.toString() +
                                    " Pieces",
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0,
                                  color: Hexcolor('#859289'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
            ],
          ),
          Column(
            children: <Widget>[
              FutureBuilder(
                  future: DatabaseService().getClothes(rightCategory),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('');
                    } else {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: GestureDetector(
                                child: Container(
                                  child: Image.asset(
                                    rightAsset,
                                    fit: BoxFit.cover,
                                    height: 150.0,
                                    width: 150.0,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              rightCategoryRoute));
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Text(
                                rightCategory,
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Hexcolor('#3F4D55'),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Text(
                                snapshot.data.documents.length.toString() +
                                    " Pieces",
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0,
                                  color: Hexcolor('#859289'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:bajuku_app/screens/template/templateCategories.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Wardrobe extends StatelessWidget {
  final CollectionReference userRef;
  final String uid;
  Wardrobe({this.userRef, this.uid});
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 260),
            child: IconButton(
                icon: new Image.asset('assets/images/seeall@3x.png'),
                iconSize: 40,
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new TemplateCategories(
                                categories: "All Items",
                              )));
                }),
          ),
          _buildAllItems(context),
          FutureBuilder(
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
                            padding: const EdgeInsets.only(left: 50, right: 83),
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
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 50),
                            child: Text(
                              snapshot.data.documents.length.toString(),
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
                            padding: const EdgeInsets.only(left: 50, right: 83),
                            child: Text(
                              'Pieces',
                              style: TextStyle(
                                letterSpacing: 1.0,
                                color: Hexcolor('#859289'),
                              ),
                            ),
                          ),
                          StreamBuilder(
                              stream: userRef.document(uid).snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text('');
                                } else {
                                  var m = snapshot.data['created'].toDate();
                                  var y = snapshot.data['created'].toDate();
                                  String month =
                                      new DateFormat('MMMM').format(m);
                                  String year = new DateFormat('yy').format(y);
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
                        ],
                      ),
                    ],
                  );
                }
              }),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 50, right: 83),
                child: Image.asset(
                  "assets/images/categories_asset.png",
                  width: 150.0,
                  height: 25.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: IconButton(
                    icon: new Image.asset('assets/images/seeall@3x.png'),
                    iconSize: 40,
                    onPressed: () {
                      Navigator.of(context).pop();
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
          _buildCategories(),
        ],
      ),
    );
  }

  Column _buildCategories() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 3.0),
          child: _buildTemplateRowCategory('Tops', 'Jacket', 'assets/images/tops_asset.png', 'assets/images/jacket_asset.png', TemplateCategories(
                                            categories: "Tops",
                                          ), TemplateCategories(
                                            categories: "Jackets and Hoodies",
                                          )),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: _buildTemplateRowCategory('Jeans', 'Bags', 'assets/images/jeans_asset.png', 'assets/images/bags_asset.png', TemplateCategories(categories: "Jeans"), TemplateCategories(categories: "Bags")),
        ),
      ],
    );
  }

  GestureDetector _buildAllItems(var context) {
    return GestureDetector(
      child: Card(
        child: Image.asset(
          'assets/images/allitems.png',
          fit: BoxFit.cover,
        ),
        elevation: 0.0,
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => new TemplateCategories(
                      categories: "All items",
                    )));
      },
    );
  }

  Widget _buildTemplateRowCategory(var leftCategory, var rightCategory,var leftAsset, var rightAsset, var leftCategoryRoute, var rightCategoryRoute){
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            FutureBuilder(
                future: DatabaseService().getClothes(leftCategory),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text('');
                  } else {
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 50.0, right: 11),
                          child: GestureDetector(
                            child: new Card(
                              child: new Image.asset(
                                leftAsset,
                                fit: BoxFit.cover,
                                height: 150.0,
                                width: 150.0,
                              ),
                              elevation: 0.0,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          leftCategoryRoute));
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          margin: EdgeInsets.only(left: 50.0),
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
                          width: 150,
                          margin: EdgeInsets.only(left: 50.0),
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
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(),
                          child: GestureDetector(
                            child: new Card(
                              child: new Image.asset(
                                rightAsset,
                                fit: BoxFit.cover,
                                height: 150.0,
                                width: 150.0,
                              ),
                              elevation: 0.0,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          rightCategoryRoute));
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          margin: EdgeInsets.only(left: 15.0),
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
                          width: 150,
                          margin: EdgeInsets.only(left: 15.0),
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
                    );
                  }
                }),
          ],
        ),
      ],
    );
  }
}

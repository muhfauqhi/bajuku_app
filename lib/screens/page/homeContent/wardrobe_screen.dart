import 'package:bajuku_app/models/homescreen.dart';
import 'package:bajuku_app/screens/template/templateCategories.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:bajuku_app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WardrobeScreen extends StatefulWidget {
  @override
  _WardrobeScreenState createState() => _WardrobeScreenState();
}

class _WardrobeScreenState extends State<WardrobeScreen> {
  final DatabaseService _databaseService = DatabaseService();
  HomeScreenModel _homeScreenModel = HomeScreenModel();

  @override
  void initState() {
    super.initState();
  }

  Future check() async {
    String check = await getData();
    if (check == null) {
      return null;
    } else {
      return 'Success';
    }
  }

  Future getData() async {
    List<String> categories = [];
    QuerySnapshot data = await _databaseService.getClothesByCategory();
    DocumentSnapshot user = await _databaseService.getProfile();
    Set<Map<String, Object>> categoryWithImage = {};
    int index = 0;
    var documents = data.documents;

    if (documents.isEmpty) {
      return null;
    } else {
      Timestamp timestamp = user.data['created'];
      DateTime date = timestamp.toDate();
      String month = DateFormat('MMMM').format(date);
      String year = DateFormat('yy').format(date);
      String memberSince = month + ' \'' + year;
      String urlLastImage;

      documents.forEach((e) {
        var category = e.data['category'][0];
        var status = e.data['status'];

        if (!categories.any((element) => element.contains(category))) {
          categories.add(category);
        }

        if (status == 'Available') {
          urlLastImage = e.data['image'];
        }
      });

      categories.forEach((e) {
        var i = 0;
        documents.forEach((doc) {
          if (doc.data['category'][0] == e) {
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
      addModel(HomeScreenModel.model(
          documents.length, memberSince, categoryWithImage, urlLastImage));
      return 'Success';
    }
  }

  void addModel(HomeScreenModel model) {
    setState(() {
      _homeScreenModel = HomeScreenModel.model(model.clothesCount,
          model.memberSince, model.categories, model.imageUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: check(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return _buildWardrobeNoItem();
            } else {
              return _buildWardrobeWithItem();
            }
          } else {
            return Loading();
          }
        },
      ),
    );
  }

  Widget _buildWardrobeWithItem() {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => TemplateCategories(
                                categories: "All Items",
                              )));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 4.0,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage('${_homeScreenModel.imageUrl}'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${_homeScreenModel.clothesCount}',
                        style: TextStyle(
                          color: Color(0xff3F4D55),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      Text(
                        'Pieces',
                        style: TextStyle(
                          color: Color(0xff859289),
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Since ${_homeScreenModel.memberSince}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xff859289),
                      fontSize: 12.0,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Categories',
                        style: TextStyle(
                          color: Color(0xff3F4D55),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          letterSpacing: 1.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new TemplateCategories(
                                        categories: "All Items",
                                      )));
                        },
                        child: Text(
                          'See All',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xffE1C8B4),
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.80,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 15.0,
                    ),
                    itemCount: _homeScreenModel.categories.toList().length,
                    itemBuilder: (context, i) {
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new TemplateCategories(
                                              categories: "${_homeScreenModel.categories.toList().elementAt(i).keys.elementAt(0)}",
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
                                          '${_homeScreenModel.categories.toList().elementAt(i).values.elementAt(1)}'),
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
                                    '${_homeScreenModel.categories.toList().elementAt(i).keys.elementAt(0)}',
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
                                    '${_homeScreenModel.categories.toList().elementAt(i).values.elementAt(0)} Pieces',
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
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 50.0)
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWardrobeNoItem() {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image(
              image: AssetImage('assets/images/blank area.png'),
            ),
          ),
        ),
      ],
    );
  }
}

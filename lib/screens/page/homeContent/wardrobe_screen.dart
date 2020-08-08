import 'package:bajuku_app/models/homescreen.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    getData();
  }

  void getData() async {
    List<String> categories = [];
    QuerySnapshot data = await _databaseService.getClothesByCategory();
    Set<Map<String, Object>> categoryWithImage = {};
    int index = 0;
    var documents = data.documents;

    if (documents.isEmpty) {
      setState(() {
        _homeScreenModel = null;
      });
    } else {
      documents.forEach((e) {
        var category = e.data['category'][0];

        if (!categories.any((element) => element.contains(category))) {
          categories.add(category);
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
          documents.length, DateTime.now(), categoryWithImage));
    }
  }

  void addModel(HomeScreenModel model) {
    setState(() {
      _homeScreenModel = HomeScreenModel.model(
          model.clothesCount, model.memberSince, model.categories);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _homeScreenModel == null
            ? _buildWardrobeNoItem()
            : _buildWardrobeWithItem()
      ],
    );
  }

  Widget _buildWardrobeWithItem() {
    return Column(
      children: <Widget>[
        Container(
          height: 380,
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 4.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://stockx.imgix.net/products/streetwear/Supreme-Box-Logo-Hoodie-Heather-Grey.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1538080256'),
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
                'Since September \'20',
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
                    onTap: () {},
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
                          onTap: () {},
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
    );
  }

  Widget _buildWardrobeNoItem() {
    return Container(
      height: 400,
      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
      child: Image(
        image: AssetImage('assets/images/blank area.png'),
      ),
    );
  }
}

import 'package:bajuku_app/screens/Page/journal.dart';
import 'package:bajuku_app/screens/home/bottomnavigationbar.dart';
import 'package:bajuku_app/screens/page/add.dart';
import 'package:bajuku_app/screens/page/sustainable.dart';
import 'package:bajuku_app/screens/template/templateCategories.dart';
import 'package:bajuku_app/services/auth.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  final int currentIndex;
  Home({this.currentIndex});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  CollectionReference userRef;
  String uid;
  int _activeTabIndex;

  final List<Tab> myTabs = <Tab>[
    new Tab(
      text: 'Wardrobe',
    ),
    new Tab(
      text: 'Journal',
    )
  ];

  @override
  void initState() {
    super.initState();
    _getUserDoc();
    _getUid();
  }

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Hexcolor('#FBFBFB'),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              Container(
                child: SliverAppBar(
                  centerTitle: true,
                  leading: FlatButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    padding: EdgeInsets.all(0.0),
                    child: Image.asset(
                      'assets/images/burger_menu.png',
                      height: 35.0,
                      width: 35.0,
                    ),
                  ),
                  iconTheme: IconThemeData(
                    color: Hexcolor('#3F4D55'),
                  ),
                  backgroundColor: Hexcolor('#FBFBFB'),
                  expandedHeight: 50.0,
                  floating: false,
                  pinned: false,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Image.asset(
                      'assets/images/logo@3x.png',
                      width: 100,
                      height: 30,
                    ),
                  ),
                ),
              ),
              new SliverPadding(
                padding: EdgeInsets.all(0.0),
                sliver: new SliverList(
                  delegate: new SliverChildListDelegate([
                    TabBar(
                      labelColor: Hexcolor('#1C3949'),
                      unselectedLabelColor: Hexcolor('#D3D3D3'),
                      indicatorColor: Hexcolor('#859289'),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                      tabs: myTabs,
                      onTap: (index) {
                        setState(() {
                          _activeTabIndex = index;
                        });
                      },
                    ),
                    buildContainerProfile(context)
                  ]),
                ),
              ),
            ];
          },
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildWardrobe(),
              _buildJournal(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
      drawer: _buildDrawer(context),
    );
  }

  Widget buildContainerProfile(BuildContext context) {
    if (_activeTabIndex == 1) {
      return Container(
        color: Hexcolor('#FBFBFB'),
        margin: EdgeInsets.only(bottom: 0),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              width: 150,
              height: 90,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    child: Center(
                      child: Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: new BoxDecoration(
                          border:
                              Border.all(width: 3, color: Hexcolor('#F4D4B8')),
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: new NetworkImage(
                                "https://cdn.vox-cdn.com/thumbor/U7zc79wuh0qCZxPhGAdi3eJ-q1g=/1400x1400/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/19228501/acastro_190919_1777_instagram_0003.0.jpg"),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new TemplateCategories(
                                    categories: "Socks",
                                  )));
                    },
                  ),
                  Center(
                    child: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: GestureDetector(
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              color: Hexcolor('#E1C8B4'),
                              fontSize: 12,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new TemplateCategories(
                                          categories: "Socks",
                                        )));
                          },
                        )),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 10),
                width: 260,
                height: 90,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            '100',
                            style: TextStyle(
                                color: Hexcolor('#3F4D55'),
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          Text(
                            'Pieces',
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Hexcolor('#859289')),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            '10',
                            style: TextStyle(
                                color: Hexcolor('#3F4D55'),
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          Text(
                            'Outfits',
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Hexcolor('#859289')),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            '10',
                            style: TextStyle(
                                color: Hexcolor('#3F4D55'),
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          Text(
                            'Points',
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Hexcolor('#859289')),
                          )
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildJournal() {
    return FutureBuilder(
      future: DatabaseService().getOutfit(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('');
        } else {
          return Container(
            margin: EdgeInsets.only(top: 10),
            child: GridView.builder(
              primary: true,
              padding: EdgeInsets.only(left: 15, right: 15, top: 9, bottom: 20),
              shrinkWrap: false,
              itemCount: snapshot.data.documents.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 11, mainAxisSpacing: 11),
              itemBuilder: (context, index) {
                return Container(
                  width: 150,
                  height: 150,
                  child: GestureDetector(
                    child: ClipRRect(
                      child: Card(
                        child: Image.network(
                          snapshot.data.documents[index].data['image'],
                          fit: BoxFit.fitWidth,
                        ),
                        elevation: 0.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  SingleChildScrollView _buildWardrobe() {
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
          _buildAllItems(),
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
          child: _buildAccessoriesAndTops(),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: _buildBottomsAndFullBodyWear(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: _buildOuterwearAndInnerwear(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: _buildSocksAndFootwear(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 140),
          child: _buildBags(),
        ),
      ],
    );
  }

  Row _buildBags() {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            FutureBuilder(
                future: DatabaseService().getClothes('Bags'),
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
                                'assets/images/bags_asset.png',
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
                                          new TemplateCategories(
                                            categories: "Bags",
                                          )));
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          margin: EdgeInsets.only(left: 50.0),
                          child: Text(
                            'Bags',
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
      ],
    );
  }

  Row _buildSocksAndFootwear() {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            FutureBuilder(
                future: DatabaseService().getClothes('Socks'),
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
                                'assets/images/tops_asset.png',
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
                                          new TemplateCategories(
                                            categories: "Socks",
                                          )));
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          margin: EdgeInsets.only(left: 50.0),
                          child: Text(
                            'Socks',
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
                future: DatabaseService().getClothes('Footwear'),
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
                                'assets/images/tops_asset.png',
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
                                          new TemplateCategories(
                                            categories: "Footwear",
                                          )));
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            'Footwear',
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
                          margin: EdgeInsets.only(left: 15),
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

  Row _buildOuterwearAndInnerwear() {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            FutureBuilder(
                future: DatabaseService().getClothes('Outerwear'),
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
                                'assets/images/jacket_asset.png',
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
                                          new TemplateCategories(
                                            categories: "Outerwear",
                                          )));
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          margin: EdgeInsets.only(left: 50.0),
                          child: Text(
                            'Outerwear',
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
                future: DatabaseService().getClothes('Innerwear'),
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
                                'assets/images/tops_asset.png',
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
                                          new TemplateCategories(
                                            categories: "Innerwear",
                                          )));
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          margin: EdgeInsets.only(left: 15.0),
                          child: Text(
                            'Innerwear',
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

  Row _buildBottomsAndFullBodyWear() {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            FutureBuilder(
                future: DatabaseService().getClothes('Bottoms'),
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
                                'assets/images/jeans_asset.png',
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
                                          new TemplateCategories(
                                            categories: "Bottoms",
                                          )));
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          margin: EdgeInsets.only(left: 50.0),
                          child: Text(
                            'Bottoms',
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
                future: DatabaseService().getClothes('Full Body Wear'),
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
                                'assets/images/tops_asset.png',
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
                                          new TemplateCategories(
                                            categories: "Full Body Wear",
                                          )));
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          margin: EdgeInsets.only(left: 15.0),
                          child: Text(
                            'Full Body Wear',
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

  Row _buildAccessoriesAndTops() {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            FutureBuilder(
                future: DatabaseService().getClothes('Accesories'),
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
                                'assets/images/tops_asset.png',
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
                                          new TemplateCategories(
                                            categories: "Accesories",
                                          )));
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          margin: EdgeInsets.only(left: 50.0),
                          child: Text(
                            'Accesories',
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
                future: DatabaseService().getClothes('Tops'),
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
                                'assets/images/tops_asset.png',
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
                                          new TemplateCategories(
                                            categories: "Tops",
                                          )));
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          margin: EdgeInsets.only(left: 15.0),
                          child: Text(
                            'Tops',
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

  GestureDetector _buildAllItems() {
    return GestureDetector(
      child: Card(
        child: Image.asset(
          'assets/images/allitems.png',
          fit: BoxFit.cover,
        ),
        elevation: 0.0,
      ),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new TemplateCategories(
                      categories: "All Items",
                    )));
      },
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Hexcolor('#2F4F55')),
            child: Container(
              child: Column(
                children: <Widget>[
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image.network(
                        'https://cdn3.iconfinder.com/data/icons/furniture-175/64/clothes-cabinet-storage-furniture-wardrobe-512.png',
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Digidrobe',
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
            child: Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade400))),
              child: new ListTile(
                title: Text(
                  'Journal',
                  style: TextStyle(fontSize: 17.0),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new JournalPage()));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
            child: Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade400))),
              child: new ListTile(
                title: Text(
                  'Sustainable',
                  style: TextStyle(fontSize: 17.0),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new SustainablePage()));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
            child: Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade400))),
              child: new ListTile(
                title: FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text(
                    'Logout',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                ),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getUserDoc() async {
    final Firestore _firestore = Firestore.instance;

    setState(() {
      userRef = _firestore.collection('users');
    });
  }

  Future<void> _getUid() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();

    setState(() {
      uid = firebaseUser.uid;
    });
  }
}

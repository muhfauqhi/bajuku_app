import 'package:bajuku_app/screens/home/bottomnavigationbar.dart';
import 'package:bajuku_app/screens/page/homeContent/journal_screen.dart';
import 'package:bajuku_app/screens/page/homeContent/wardrobe_screen.dart';
import 'package:bajuku_app/screens/page/menu_burger/menuBurger.dart';
import 'package:bajuku_app/screens/page/profileheader/headerprofile.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:showcaseview/showcaseview.dart';

class Home extends StatefulWidget {
  final int currentIndex;
  Home({this.currentIndex});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  CollectionReference userRef;
  String uid;
  int _activeTabIndex = 0;

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
              SliverAppBar(
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
              // Wardrobe(
              //   userRef: userRef,
              //   uid: uid,
              // ),
              WardrobeScreen(),
              JournalScreen()
            ],
          ),
        ),
      ),
      bottomNavigationBar: FutureBuilder(
        future: DatabaseService().getTotalClothes(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return ShowCaseWidget(
              builder: Builder(
                  builder: (context) => CustomBottomNavigationBar(
                        indexNow: _activeTabIndex,
                        totalItem: snapshot.data.documents.length,
                      )),
            );
          } else {
            return Text("");
          }
        },
      ),
      drawer: MenuBurger(),
    );
  }

  Widget buildContainerProfile(BuildContext context) {
    if (_activeTabIndex == 1) {
      return HeaderProfile();
    } else {
      return Container();
    }
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

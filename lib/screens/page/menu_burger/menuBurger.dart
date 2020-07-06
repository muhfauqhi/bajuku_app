import 'package:bajuku_app/screens/home/home.dart';
<<<<<<< HEAD
import 'package:bajuku_app/screens/page/menu_burger/routingPage/profile.dart';
=======
import 'package:bajuku_app/screens/page/menu_burger/routingPage/clothstats.dart';
>>>>>>> e71037e913367b5ab7b489d0946d4ef46fe3b20f
import 'package:bajuku_app/screens/page/menu_burger/templateTextMenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MenuBurger extends StatefulWidget {
  @override
  _MenuBurgerState createState() => _MenuBurgerState();
}

class _MenuBurgerState extends State<MenuBurger> {
  CollectionReference userRef;
  String uid;

  @override
  void initState() {
    super.initState();
    _getUserDoc();
    _getUid();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Hexcolor('F4D4B8'),
        child: ListView(
          children: <Widget>[
            buildContainerHeader(),
            TextMenu(
              route: Home(),
              text: "Home",
            ),
            TextMenu(
              route: Home(),
              text: "Message",
            ),
            TextMenu(
              route: Home(),
              text: "Planner",
            ),
            TextMenu(
              route: Home(),
              text: "Outfit Looks",
            ),
            TextMenu(
              route: ClothingStats(
              ),
              text: "Clothing Stats",
            ),
            TextMenu(
              route: Home(),
              text: "Sustainability Stats",
            ),
            TextMenu(
              route: Home(),
              text: "Inspiration",
            ),
            TextMenu(
              route: Home(),
              text: "History",
            ),
            TextMenu(
              route: Home(),
              text: "My Rewards",
            ),
            Divider(),
            TextMenu(
              route: Home(),
              text: "Help",
            ),
            TextMenu(
              route: Home(),
              text: "Logout",
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainerHeader() {
    return Container(
      margin: EdgeInsets.only(bottom: 7),
      child: DrawerHeader(
        decoration: BoxDecoration(color: Hexcolor('#E1C8B4')),
        child: StreamBuilder(
          stream: userRef.document(uid).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text("");
            } else {
              return Row(
                children: <Widget>[
                  buildAvatar(snapshot),
                  Container(
                    margin: EdgeInsets.only(top: 45),
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Column(
                        children: <Widget>[
                          Text(
                            snapshot.data['firstName'].toString() +
                                " " +
                                snapshot.data['lastName'].toString(),
                            style: TextStyle(
                                color: Hexcolor('#3F4D55'),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                      'assets/images/sustPoint.png')),
                              Text(
                                snapshot.data['points'].toString() + " pts",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: Hexcolor('#4AA081')),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: GestureDetector(
                              child: Image.asset(
                                'assets/images/editProfileSideMenu.png',
                                height: 20,
                                width: 45,
                              ),
<<<<<<< HEAD
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new ProfilePage()));
                              },
=======
                              onTap: () {},
>>>>>>> e71037e913367b5ab7b489d0946d4ef46fe3b20f
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildAvatar(snapshot) {
    if (!snapshot.hasData) {
      return Text('');
    } else if (snapshot.data['profilePicture'].toString().isNotEmpty) {
      return Container(
        width: 60.0,
        height: 60.0,
        decoration: new BoxDecoration(
          border: Border.all(width: 3, color: Hexcolor('#F4D4B8')),
          shape: BoxShape.circle,
          image: new DecorationImage(
            fit: BoxFit.fitHeight,
            image: new NetworkImage(
                "https://cdn.vox-cdn.com/thumbor/U7zc79wuh0qCZxPhGAdi3eJ-q1g=/1400x1400/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/19228501/acastro_190919_1777_instagram_0003.0.jpg"),
          ),
        ),
      );
    } else {
      print(snapshot.data['profilePicture']);
      return Container(
        margin: EdgeInsets.only(left: 10),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Hexcolor('#37585A'),
          child: Text(
            snapshot.data['firstName']
                    .toString()
                    .substring(0, 1)
                    .toUpperCase() +
                snapshot.data['lastName']
                    .toString()
                    .substring(0, 1)
                    .toUpperCase(),
            style: TextStyle(color: Hexcolor('#C4C4C4')),
          ),
        ),
      );
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

import 'package:bajuku_app/screens/page/addItem/addChoice.dart';
import 'package:bajuku_app/screens/page/menu_burger/routingPage/profile.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainablehome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  CollectionReference userRef;
  String uid;

  @override
  void initState() {
    super.initState();
    _getUserDoc();
    _getUid();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Hexcolor('#F8F8F8'),
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            height: 35,
            width: 35,
            child: GestureDetector(
              child: Image.asset('assets/images/homenav.png'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new SustainableHome(
                              title: 'Sustainability',
                            )));
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            height: 35,
            width: 35,
            child: GestureDetector(
              child: Image.asset('assets/images/addnav.png'),
              onTap: () {
                showDialog(
                  context: context,
                  child: AddChoiceDialog(),
                );
              },
            ),
          ),
          StreamBuilder(
            stream: userRef.document(uid).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("");
              } else {
                return Container(
                  margin: EdgeInsets.all(5),
                  height: 35,
                  width: 35,
                  child: GestureDetector(
                    child: Image.asset('assets/images/profilenav.png'),
                    onTap: () {
                      var y = snapshot.data['created'].toDate();
                      String year = new DateFormat('yyyy').format(y);
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new ProfilePage(
                                    profileCreated: year,
                                    userPoints:
                                        snapshot.data['points'].toString(),
                                    firstName:
                                        snapshot.data['firstName'].toString(),
                                    lastName:
                                        snapshot.data['lastName'].toString(),
                                  )));
                    },
                  ),
                );
              }
            },
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

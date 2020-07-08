import 'package:bajuku_app/screens/page/menu_burger/routingPage/profile.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileHeader extends StatefulWidget {
  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
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
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Hexcolor('#FBFBFB'),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width * 0.4,
            height: 80,
            child: Container(
              child: Column(
                children: <Widget>[
                  StreamBuilder(
                    stream: userRef.document(uid).snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('');
                      } else if (snapshot.data['profilePicture']
                          .toString()
                          .isNotEmpty) {
                        return Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: new BoxDecoration(
                            border: Border.all(
                                width: 3, color: Hexcolor('#F4D4B8')),
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: new NetworkImage(
                                  "https://cdn.vox-cdn.com/thumbor/U7zc79wuh0qCZxPhGAdi3eJ-q1g=/1400x1400/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/19228501/acastro_190919_1777_instagram_0003.0.jpg"),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          child: CircleAvatar(
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
                              style: TextStyle(
                                color: Hexcolor('#C4C4C4'),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  Container(
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
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ProfilePage()));
                        },
                      )),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: 80,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buildWidget(
                      DatabaseService().getClothes('All Items'), "Clothes"),
                  buildWidget(DatabaseService().getOutfit(), "Outfits"),
                  StreamBuilder(
                      stream: userRef.document(uid).snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text('');
                        } else {
                          return Column(
                            children: <Widget>[
                              Text(
                                snapshot.data['points'].toString(),
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
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWidget(var future, var text) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Column(
                children: <Widget>[
                  Text(
                    snapshot.data.documents.length.toString(),
                    style: buildTextStyle('#3F4D55'),
                  ),
                  Text(
                    text,
                    style: buildTextStyle('#859289'),
                  )
                ],
              )
            : Text('');
      },
    );
  }

  TextStyle buildTextStyle(var hexcolor) {
    return TextStyle(
        color: Hexcolor(hexcolor),
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        fontSize: 16);
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

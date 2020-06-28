import 'package:bajuku_app/models/sustainabilityClothes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CardSmall extends StatefulWidget {
  final SustainabilityClothes sustainabilityClothes;

  CardSmall({this.sustainabilityClothes});

  @override
  _CardSmallState createState() => _CardSmallState();
}

class _CardSmallState extends State<CardSmall> {
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
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                widget.sustainabilityClothes.clothes['image'],
                height: 130,
                width: 140,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(left: 15.0),
                      width: 100,
                      child: Text(
                        widget.sustainabilityClothes.clothes['clothName'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Hexcolor('#3F4D55'),
                        ),
                        softWrap: false,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Container(
                    width: 20,
                    margin: EdgeInsets.only(right: 5),
                    child: Image.asset('assets/images/more.png'),
                  )
                ],
              ),
              Container(
                width: 140,
                margin: EdgeInsets.only(left: 0, top: 5),
                child: Text(
                  buildPriceText(),
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 12, color: Hexcolor('#859289')),
                ),
              ),
              Container(
                width: 200,
                margin: EdgeInsets.only(left: 13, top: 5),
                child: Row(
                  children: <Widget>[
                    StreamBuilder(
                        stream: userRef.document(uid).snapshots(),
                        builder: (context, snapshot) {
                          return Container(
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: Hexcolor('#37585A'),
                              child: Text(
                                snapshot.data['firstName']
                                        .toString()
                                        .substring(0, 1) +
                                    snapshot.data['lastName']
                                        .toString()
                                        .substring(0, 1),
                                style: TextStyle(color: Hexcolor('#C4C4C4'), fontSize: 12),
                              ),
                            ),
                          );
                        }),
                    Container(
                      width: 15,
                      height: 15,
                      margin: EdgeInsets.only(left: 100),
                      child: Image.asset('assets/images/love.png'))
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  String buildPriceText(){
    if(widget.sustainabilityClothes.price=="Free"){
      return widget.sustainabilityClothes.price;
    }else{
      return "€"+widget.sustainabilityClothes.price;
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

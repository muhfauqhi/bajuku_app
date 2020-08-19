import 'package:bajuku_app/screens/page/addItem/addChoiceDialog.dart';
import 'package:bajuku_app/screens/page/menu_burger/routingPage/profile.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainablehome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int indexNow;
  final int totalItem;
  CustomBottomNavigationBar({this.indexNow, this.totalItem});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.totalItem == 0) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context).startShowCase([_one, _two]));
    }
    // _getUserDoc();
    // _getUid();
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            height: 65,
            width: 65,
            child: GestureDetector(
              child: Image.asset('assets/images/sustainabilitybottom.png'),
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
          Showcase(
            titleTextStyle: TextStyle(
              color:
                  widget.indexNow == 0 ? Color(0xff3F4D55) : Color(0xffE1C8B4),
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
            overlayColor: Colors.white,
            descTextStyle: TextStyle(
              color:
                  widget.indexNow == 0 ? Color(0xff3F4D55) : Color(0xffE1C8B4),
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
            overlayOpacity: 0.1,
            showcaseBackgroundColor:
                widget.indexNow == 0 ? Color(0xffE1C8B4) : Color(0xff3F4D55),
            disableAnimation: true,
            shapeBorder: BeveledRectangleBorder(),
            textColor:
                widget.indexNow == 0 ? Color(0xff3F4D55) : Color(0xffFFDEBF),
            title: 'Add your first',
            key: widget.indexNow == 0 ? _one : _two,
            description: widget.indexNow == 0 ? 'clothes here' : 'outfit here',
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
              height: 60,
              width: 60,
              child: GestureDetector(
                child: Image.asset('assets/images/menubottom.png'),
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isDismissible: true,
                      enableDrag: false,
                      context: context,
                      builder: (context) => AddChoiceDialog());
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            height: 55,
            width: 55,
            child: GestureDetector(
              child: Image.asset('assets/images/profilebottom.png'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new ProfilePage()));
              },
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> _getUserDoc() async {
  //   final Firestore _firestore = Firestore.instance;

  //   setState(() {
  //     userRef = _firestore.collection('users');
  //   });
  // }

  // Future<void> _getUid() async {
  //   var firebaseUser = await FirebaseAuth.instance.currentUser();

  //   setState(() {
  //     uid = firebaseUser.uid;
  //   });
  // }
}

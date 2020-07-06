import 'package:bajuku_app/screens/page/menu_burger/template/sliverappbartemplate.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfilePage extends StatefulWidget {
  final String userPoints;

  ProfilePage({this.userPoints});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double newRating;
  double rating = 1220;

  @override
  Widget build(BuildContext context) {
    return MenuBurgerScaffold(
      title: ("Profile"),
      profileName: ("Michella"),
      profilePict: ("MM"),
      profileCreated: ("2019"),
      leftBox: Container(
        margin: EdgeInsets.only(left: 30),
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/sustPoint.png',
              width: 50,
              height: 45,
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Column(
                children: <Widget>[
                  Text("1220",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Hexcolor('#4AA081'))),
                  Text(
                    "Points",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      rightBox: Container(
        margin: EdgeInsets.only(left: 30),
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/shirtLogo.png',
              width: 20,
              height: 45,
            ),
            Container(
              margin: EdgeInsets.only(top: 40, left: 10),
              child: FutureBuilder(
                future: DatabaseService().getClothes("All Items"),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("");
                  } else {
                    return Column(
                      children: <Widget>[
                        Text(snapshot.data.documents.length.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Hexcolor('#4AA081'))),
                        Text(
                          "Clothes",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 13),
                        )
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      contentSliver: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 25, right: 25, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Sustainability Points",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  child: Image.asset(
                    'assets/images/helpicon.png',
                    height: 24,
                    width: 24,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                disabledActiveTrackColor: Hexcolor('#57686A'),
                disabledInactiveTrackColor: Hexcolor('#E1C8B4'),
                disabledThumbColor: Colors.redAccent,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
                trackHeight: 20,
              ),
              child: Slider(
                label: '$rating',
                value: rating,
                onChanged: null,
                min: 0,
                max: 3000,
                activeColor: Colors.white,
                inactiveColor: Color(0xFF8D8E98),
              ),
            ),
          )
        ],
      ),
      body: Text(""),
    );
  }
}

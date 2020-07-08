import 'package:bajuku_app/screens/page/menu_burger/template/sliverappbartemplate.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfilePage extends StatefulWidget {
  final String userPoints;
  final String profileName;
  final String profileCreated;
  final String firstName;
  final String lastName;

  ProfilePage(
      {this.userPoints,
      this.profileCreated,
      this.profileName,
      this.firstName,
      this.lastName});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MenuBurgerScaffold(
        title: ("Profile"),
        profileName: widget.profileName,
        profilePict: widget.firstName.substring(0, 1).toUpperCase() +
            widget.lastName.toString().substring(0, 1).toUpperCase(),
        profileCreated: widget.profileCreated,
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
                    Text(widget.userPoints,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Hexcolor('#4AA081'))),
                    Text(
                      "Points",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
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
                  label: widget.userPoints,
                  value: double.parse(widget.userPoints),
                  onChanged: null,
                  min: 0,
                  max: 3000,
                  activeColor: Colors.white,
                  inactiveColor: Color(0xFF8D8E98),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/bronze.png',
                        height: 25,
                        width: 35,
                      ),
                      Text(
                        "Sustainability\n  Conscious",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Hexcolor('#557A6D')),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Image.asset('assets/images/silver.png'),
                      Text("Sustainability\n     Warrior",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Hexcolor('#557A6D')))
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Image.asset('assets/images/gold.png'),
                      Text("Sustainability\n        Hero",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Hexcolor('#557A6D')))
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'My Rewards',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Hexcolor('#3F4D55'),
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 12,
                        color: Hexcolor('#E1C8B4'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 8, left: 8),
                    child: GestureDetector(
                      child: Image.asset(
                        'assets/images/disc50.png',
                        height: 75,
                      ),
                      onTap: () {},
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8, left: 8),
                    child: GestureDetector(
                      child: Image.asset(
                        'assets/images/disc25.png',
                        height: 75,
                      ),
                      onTap: () {},
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8, left: 8),
                    child: GestureDetector(
                      child: Image.asset(
                        'assets/images/disc20.png',
                        height: 75,
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Text(""));
  }
}

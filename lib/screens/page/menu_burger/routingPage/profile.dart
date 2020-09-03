import 'package:bajuku_app/screens/page/menu_burger/template/sliverappbartemplate.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:bajuku_app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final DatabaseService _databaseService = DatabaseService();

  Future fetchData() async {
    Map<String, dynamic> data;
    int totalClothes;
    DocumentSnapshot snapshot = await _databaseService.getProfile();
    QuerySnapshot documents = await _databaseService.getClothesByCategory();

    totalClothes = documents.documents.length;

    data = snapshot.data;
    data.putIfAbsent('totalClothes', () => totalClothes);

    return snapshot.data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String profilePict = (snapshot.data['firstName'].toString()[0] +
                  snapshot.data['lastName'].toString()[0])
              .toUpperCase();
          String profileName =
              (snapshot.data['firstName'].toString()[0].toUpperCase() +
                  snapshot.data['firstName'].toString().substring(1) +
                  ' ' +
                  snapshot.data['lastName'].toString()[0].toUpperCase() +
                  snapshot.data['lastName'].toString().substring(1));
          String profileCreated =
              DateFormat('yyyy').format(snapshot.data['created'].toDate());
          String points = snapshot.data['points'].toString();
          String totalCltohes = snapshot.data['totalClothes'].toString();
          return MenuBurgerScaffold(
              title: ("Profile"),
              profileName: profileName,
              profilePict: profilePict,
              profileCreated: profileCreated,
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
                          Text(points,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Hexcolor('#4AA081'))),
                          Text(
                            "Points",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 13),
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
                      child: Column(
                        children: <Widget>[
                          Text(totalCltohes,
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
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                      margin: EdgeInsets.only(top: 10),
                      child: Text(points + " Points",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Hexcolor('#4AA081')))),
                  Container(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        disabledActiveTrackColor: Hexcolor('#57686A'),
                        disabledInactiveTrackColor: Hexcolor('#E1C8B4'),
                        disabledThumbColor: Colors.redAccent,
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 0.0),
                        trackHeight: 20,
                      ),
                      child: Slider(
                        label: points,
                        value: double.parse(points),
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
                    margin: EdgeInsets.only(left: 20, right: 20, top: 30),
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
                          child: GestureDetector(
                            child: Image.asset(
                              'assets/images/disc50.png',
                              height: 75,
                            ),
                            onTap: () {},
                          ),
                        ),
                        Container(
                          child: GestureDetector(
                            child: Image.asset(
                              'assets/images/disc25.png',
                              height: 75,
                            ),
                            onTap: () {},
                          ),
                        ),
                        Container(
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
              body: Text(''));
        } else {
          return Loading();
        }
      },
    );
  }
}

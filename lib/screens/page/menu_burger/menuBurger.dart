import 'package:bajuku_app/screens/home/home.dart';
import 'package:bajuku_app/screens/page/menu_burger/routingPage/clothstats.dart';
import 'package:bajuku_app/screens/page/menu_burger/routingPage/planner.dart';
import 'package:bajuku_app/screens/page/menu_burger/routingPage/profile.dart';
import 'package:bajuku_app/screens/page/menu_burger/routingPage/sustainabilitystats.dart';
import 'package:bajuku_app/screens/page/menu_burger/templateTextMenu.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class MenuBurger extends StatefulWidget {
  @override
  _MenuBurgerState createState() => _MenuBurgerState();
}

class _MenuBurgerState extends State<MenuBurger> {
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
        if (!snapshot.hasData) {
          return Text('');
        } else {
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
          return _buildDrawer(profilePict, points, profileName, profileCreated);
        }
      },
    );
  }

  Widget _buildDrawer(String profilePict, String points, String profileName,
      String profileCreated) {
    return Drawer(
      child: Container(
        color: Hexcolor('F4D4B8'),
        child: ListView(
          children: <Widget>[
            _buildContainerHeader(profilePict, points, profileName),
            TextMenu(
              route: Home(),
              text: "Home",
            ),
            TextMenu(
              route: Home(),
              text: "Message",
            ),
            TextMenu(
              route: Planner(),
              text: "Planner",
            ),
            TextMenu(
              route: Home(),
              text: "Outfit Looks",
            ),
            TextMenu(
              route: ClothingStats(
                profileCreated: profileCreated,
                profileName: profileName,
                profilePict: profilePict,
              ),
              text: "Clothing Stats",
            ),
            TextMenu(
              route: SustainAbilityStats(
                profileCreated: profileCreated,
                profileName: profileName,
                profilePict: profilePict,
              ),
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
              text: "Logout",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainerHeader(
      String profilePict, String points, String profileName) {
    return Container(
      margin: EdgeInsets.only(bottom: 7),
      child: DrawerHeader(
        decoration: BoxDecoration(color: Hexcolor('#E1C8B4')),
        child: Row(
          children: <Widget>[
            _buildAvatar(profilePict),
            Container(
              margin: EdgeInsets.only(top: 45),
              child: Container(
                margin: EdgeInsets.only(left: 15),
                child: Column(
                  children: <Widget>[
                    Text(
                      profileName,
                      style: TextStyle(
                          color: Hexcolor('#3F4D55'),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Image.asset('assets/images/sustPoint.png')),
                        Text(
                          points + " pts",
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
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String profilePict) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            colors: [
              Color(0xffCEB39E),
              Color(0xffFFDEBF),
            ],
          ),
        ),
        padding: EdgeInsets.all(3.0),
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              colors: [
                Color(0xff1C3949),
                Color(0xff557A6D),
              ],
            ),
          ),
          child: Center(
            child: Text(
              profilePict,
              style: TextStyle(
                color: Color(0xffC4C4C4),
                fontSize: 20.0,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

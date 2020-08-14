import 'package:bajuku_app/models/profilemodel.dart';
import 'package:bajuku_app/screens/page/menu_burger/routingPage/profile.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:bajuku_app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HeaderProfile extends StatefulWidget {
  @override
  _HeaderProfileState createState() => _HeaderProfileState();
}

class _HeaderProfileState extends State<HeaderProfile> {
  final DatabaseService _databaseService = DatabaseService();

  Future<ProfileModel> getData() async {
    QuerySnapshot totalItems = await _databaseService.getTotalClothes();
    DocumentSnapshot profile = await _databaseService.getProfile();
    QuerySnapshot totalOutfits = await _databaseService.getOutfit();
    var name = (profile.data['firstName'].toString().substring(0, 1) +
            profile.data['lastName'].toString().toUpperCase().substring(0, 1))
        .toUpperCase();
    return ProfileModel.model(
        name,
        totalItems.documents.length.toString(),
        totalOutfits.documents.length.toString(),
        profile.data['points'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Circle Avatar
                  _buildColumnCircleAvatar(snapshot.data.name),
                  // Text Pieces
                  _buildColumnText('Pieces', snapshot.data.totalItems),
                  // Text Outfits
                  _buildColumnText('Outfits', snapshot.data.totalOutfits),
                  // Text Points
                  _buildColumnText('Points', snapshot.data.totalPoints),
                ],
              );
            } else {
              return Loading();
            }
          }),
    );
  }

  Widget _buildColumnCircleAvatar(String name) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
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
                  name,
                  style: TextStyle(
                    color: Color(0xffC4C4C4),
                    fontSize: 20.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          'Edit',
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xffE1C8B4),
          ),
        ),
      ],
    );
  }

  Widget _buildColumnText(String desc, String values) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          values,
          style: TextStyle(
            color: Color(0xff3F4D55),
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          desc,
          style: TextStyle(
            color: Color(0xff859289),
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}

import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainabilitygivesell/sustainabilityWardrobe.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:bajuku_app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SustainCategory extends StatelessWidget {
  final List<Clothes> clothesList;
  final String title;
  final String type;

  SustainCategory({this.clothesList, this.title, this.type});

  final DatabaseService _databaseService = DatabaseService();

  Future fetchData() async {
    QuerySnapshot snapshot = await _databaseService.getClothesByCategory();
    List<DocumentSnapshot> documents = snapshot.documents;
    List<DocumentSnapshot> categories = [];

    if (documents.isEmpty) {
      return null;
    } else {
      documents.forEach((e) {
        var category = e.data['category'][0];
        var status = e.data['status'];
        if (category == title) {
          if (status == 'Available') {
            categories.add(e);
          }
        }
      });
      return categories;
    }
  }

  Clothes _addClothes(List<dynamic> data, int i) {
    Clothes clothes = Clothes(
      data[i].documentID,
      data[i]['brand'],
      data[i]['category'],
      data[i]['clothName'],
      data[i]['color'],
      data[i]['cost'],
      data[i]['dateBought'],
      data[i]['endDate'],
      data[i]['fabric'],
      data[i]['image'],
      data[i]['price'],
      data[i]['notes'],
      data[i]['season'],
      data[i]['size'],
      data[i]['startDate'],
      data[i]['status'],
      data[i]['updateDate'],
      data[i]['url'],
      data[i]['usedInOutfit'],
      data[i]['worn'],
    );
    return clothes;
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      actions: [
        GestureDetector(
          child: Container(
            margin: EdgeInsets.only(right: 10.0),
            child: Image.asset(
              'assets/images/close.png',
              width: 25,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
      leadingActive: true,
      titleStyle: true,
      titleTextStyle: TextStyle(
        color: Hexcolor('#3F4D55'),
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
      title: title,
      headerWidget: [],
      body: Container(
        margin: EdgeInsets.only(left: 15.0, right: 15.0),
        child: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              var data = snapshot.data;
              return GridView.builder(
                shrinkWrap: true,
                itemCount: 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  if (snapshot.hasData) {
                    if (snapshot.data == null) {
                      return Loading();
                    } else {
                      Clothes clothes = _addClothes(data, index);
                      return GestureDetector(
                        child: Card(
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(data[index]['image']),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  SustainDetailWardrobe(
                                clothes: clothes,
                                title: clothes.clothName,
                                type: type,
                              ),
                            ),
                          );
                        },
                      );
                    }
                  } else {
                    return Loading();
                  }
                },
              );
            }),
      ),
    );
  }
}

import 'package:bajuku_app/models/outfit.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainabilitygivesell/sustainabiilityJournal.dart';
import 'package:bajuku_app/screens/template/templateDetailOutfits.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SustainScaffoldJournal extends StatelessWidget {
  final String type;
  SustainScaffoldJournal({this.type});

  final DatabaseService _databaseService = DatabaseService();

  Future fetchData() async {
    List id = [];
    List available = [];
    QuerySnapshot snapshot = await _databaseService.getOutfit();
    var documents = snapshot.documents;
    documents.forEach((e) {
      var list = e.data['tagged'];
      list.forEach((i) {
        String docId =
            i.values.toString().substring(1, i.values.toString().length - 1);
        if (id.length == 0) {
          id.add(docId);
        } else if (!id.contains(docId)) {
          id.add(docId);
        }
      });
    });
    for (var i in id) {
      DocumentSnapshot snapshot = await _databaseService.getCloth(i);
      var status = snapshot.data['status'];
      if (status == 'Available') {
        available.add(snapshot.data);
      }
    }
    return available;
  }

  Future<List<Outfit>> getData() async {
    List<Outfit> outfit = [];
    QuerySnapshot snapshot = await _databaseService.getOutfit();

    snapshot.documents.forEach((e) {
      outfit.add(Outfit(e.data['image'], e.data['notes'], e.data['outfitName'],
          e.data['tagged'], e.data['totalCost'], e.data['created']));
    });

    return outfit;
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
      leadingActive: false,
      titleStyle: true,
      titleTextStyle: TextStyle(
        color: Hexcolor('#3F4D55'),
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
      title: 'Your Journal',
      headerWidget: [],
      body: Container(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return GridView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    String image = data[index].image;
                    return GestureDetector(
                      child: Card(
                        elevation: 2.0,
                        child: Container(
                          child: Image.network(
                            image,
                            fit: BoxFit.cover,
                          ),
                          decoration: BoxDecoration(
                            color: Hexcolor('#FFFFFF'),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SustainDetailJournal(
                              outfit: snapshot.data[index],
                              type: type,
                            ),
                          ),
                        );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => DetailOutfits(
                        //       outfit: snapshot.data[index],
                        //     ),
                        //   ),
                        // );
                      },
                    );
                  });
            } else {
              return Text('');
            }
          },
        ),
      ),
    );
  }
}

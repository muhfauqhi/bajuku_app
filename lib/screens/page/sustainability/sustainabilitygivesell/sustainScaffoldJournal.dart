import 'dart:collection';

import 'package:bajuku_app/models/outfit.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainabilitygivesell/sustainabiilityJournal.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SustainScaffoldJournal extends StatelessWidget {
  final String type;
  SustainScaffoldJournal({this.type});

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
          future: DatabaseService().getOutfit(),
          builder: (context, snapshot) {
            List<Outfit> outfitList = [];

            if (snapshot.hasData) {
              for (var i in snapshot.data.documents) {
                for (var a in i.data['tagged'].values.toList()) {
                  if (a['status'] == 'Available') {
                    outfitList.add(
                      Outfit(
                        i.data['image'],
                        i.data['notes'],
                        i.data['outfitName'],
                        i.data['tagged'],
                        i.data['totalCost'],
                        i.data['created'],
                      ),
                    );
                    break;
                  }
                }
              }
              return GridView.builder(
                  shrinkWrap: true,
                  itemCount: outfitList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Card(
                        elevation: 2.0,
                        child: Container(
                          child: Image.network(
                            outfitList[index].image,
                            fit: BoxFit.fitWidth,
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
                              outfit: outfitList[index],
                              type: type,
                            ),
                          ),
                        );
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

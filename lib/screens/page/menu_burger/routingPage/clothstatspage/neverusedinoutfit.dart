import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class NeverUsed extends StatelessWidget {
  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Never Used In Outfit',
      leadingActive: true,
      titleStyle: false,
      headerWidget: [],
      body: FutureBuilder(
          future: databaseService.getTotalClothes(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('');
            } else {
              List<Clothes> clothesList = [];
              for (var i in snapshot.data.documents) {
                if (i.data['usedInOutfit'] < 1) {
                  clothesList.add(
                    Clothes(
                      i.documentID,
                      i.data['brand'],
                      i.data['category'],
                      i.data['clothName'],
                      i.data['color'],
                      i.data['cost'],
                      i.data['dateBought'],
                      i.data['endDate'],
                      i.data['fabric'],
                      i.data['image'],
                      i.data['price'],
                      i.data['notes'],
                      i.data['season'],
                      i.data['size'],
                      i.data['startDate'],
                      i.data['status'],
                      i.data['updateDate'],
                      i.data['url'],
                      i.data['usedInOutfit'],
                      i.data['worn'],
                    ),
                  );
                }
              }
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: clothesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(clothesList.elementAt(index).image),
                    ),
                    title: Text(
                      '${clothesList.elementAt(index).clothName}',
                      style: TextStyle(
                        color: Hexcolor('#3F4D55'),
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    subtitle: Text('Last used ' + 
                      DateFormat('d MMMM yyyy')
                          .format(
                              clothesList.elementAt(index).updateDate.toDate())
                          .toString(),
                      style: TextStyle(
                        color: Hexcolor('#9D9D9D'),
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}

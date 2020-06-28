import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SuggestionClothes extends StatefulWidget {
  @override
  _SuggestionClothesState createState() => _SuggestionClothesState();
}

class _SuggestionClothesState extends State<SuggestionClothes> {
  String clothName = '';
  String category = '';
  String documentId = '';
  String price = '';
  List<Clothes> clothesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(14.0),
                    child: TextFormField(
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal,
                          color: Hexcolor('#3F4D55'),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search your clothes',
                          prefixIcon: Icon(Icons.search),
                        )),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    child: Text('Cancel'),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            Expanded(
              child: FutureBuilder(
                  future: DatabaseService().getClothes('All Items'),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('');
                    } else {
                      for (var i in snapshot.data.documents) {
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
                      return ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: clothesList.length,
                        itemBuilder: (context, index) {
                          category = clothesList
                              .elementAt(index)
                              .category
                              .toString()
                              .substring(
                                  1,
                                  clothesList
                                          .elementAt(index)
                                          .category
                                          .toString()
                                          .length -
                                      1);
                          clothName = clothesList.elementAt(index).clothName;
                          documentId = clothesList.elementAt(index).documentId;
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  clothesList.elementAt(index).image),
                            ),
                            title: Text(clothName),
                            subtitle: Text(category),
                            onTap: () {
                              price = clothesList.elementAt(index).price;
                              category = clothesList
                                  .elementAt(index)
                                  .category
                                  .toString()
                                  .substring(
                                      1,
                                      clothesList
                                              .elementAt(index)
                                              .category
                                              .toString()
                                              .length -
                                          1);
                              clothName = clothesList.elementAt(index).clothName;
                              documentId =
                                  clothesList.elementAt(index).documentId;
                              Navigator.pop(context, {
                                'clothName': '$clothName',
                                'category': '$category',
                                'documentId': '$documentId',
                                'price': '$price',
                              });
                            },
                          );
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

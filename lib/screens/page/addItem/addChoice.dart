import 'package:bajuku_app/models/clothes.dart';
import 'package:bajuku_app/screens/page/addItem/add.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:flutter/material.dart';

class AddChoiceDialog extends StatefulWidget {
  @override
  _AddChoiceDialogState createState() => _AddChoiceDialogState();
}

class _AddChoiceDialogState extends State<AddChoiceDialog> {
  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      children: [
        Container(
          margin: EdgeInsets.only(top: 400),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 90,
                width: 90,
                child: GestureDetector(
                  child: Image.asset('assets/images/addclothes.png'),
                  onTap: () {
                    showDialog(
                        context: context,
                        child: AddItemDialog(
                          flagAdd: 'Wardrobe',
                        ));
                  },
                ),
              ),
              FutureBuilder(
                future: databaseService.getClothesAvailable(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      height: 90,
                      width: 90,
                      child: GestureDetector(
                        child: Image.asset('assets/images/addjournal.png'),
                      ),
                    );
                  } else {
                    List<Clothes> clothesList = [];
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
                    return Container(
                      height: 90,
                      width: 90,
                      child: GestureDetector(
                        child: Image.asset('assets/images/addjournal.png'),
                        onTap: () {
                          showDialog(
                            context: context,
                            child: AddItemDialog(
                              flagAdd: 'Journal',
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

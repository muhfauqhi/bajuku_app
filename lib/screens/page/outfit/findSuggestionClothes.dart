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
                      return ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          category = snapshot
                              .data.documents[index].data['category']
                              .toString()
                              .substring(
                                  1,
                                  snapshot.data.documents[index]
                                          .data['category']
                                          .toString()
                                          .length -
                                      1);
                          clothName =
                              snapshot.data.documents[index].data['clothName'];
                          documentId =
                              snapshot.data.documents[index].documentID;
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  snapshot.data.documents[index].data['image']),
                            ),
                            title: Text(clothName),
                            subtitle: Text(category),
                            onTap: () {
                              category = snapshot
                                  .data.documents[index].data['category']
                                  .toString()
                                  .substring(
                                      1,
                                      snapshot.data.documents[index]
                                              .data['category']
                                              .toString()
                                              .length -
                                          1);
                              clothName = snapshot
                                  .data.documents[index].data['clothName'];
                              documentId =
                                  snapshot.data.documents[index].documentID;
                              Navigator.pop(context, {
                                'clothName': '$clothName',
                                'category': '$category',
                                'documentId': '$documentId',
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

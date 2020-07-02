import 'package:bajuku_app/models/outfit.dart';
import 'package:bajuku_app/screens/template/templateDetailOutfit.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:flutter/material.dart';

class Journal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseService().getOutfit(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('');
        } else {
          return Container(
            margin: EdgeInsets.only(top: 10),
            child: GridView.builder(
              primary: true,
              padding: EdgeInsets.only(left: 15, right: 15, top: 9, bottom: 20),
              shrinkWrap: false,
              itemCount: snapshot.data.documents.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 11, mainAxisSpacing: 11),
              itemBuilder: (context, index) {
                return Container(
                  width: 150,
                  height: 150,
                  child: GestureDetector(
                    child: ClipRRect(
                      child: Card(
                        child: Image.network(
                          snapshot.data.documents[index].data['image'],
                          fit: BoxFit.fitWidth,
                        ),
                        elevation: 0.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onTap: () {
                      Outfit outfit = new Outfit(
                          snapshot.data.documents[index].data['image'],
                          snapshot.data.documents[index].data['notes'],
                          snapshot.data.documents[index].data['outfitName'],
                          snapshot.data.documents[index].data['tagged'],
                          snapshot.data.documents[index].data['totalCost'],
                          snapshot.data.documents[index].data['created']);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TemplateDetailOutfit(
                                    outfit: outfit,
                                  )));
                    },
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}

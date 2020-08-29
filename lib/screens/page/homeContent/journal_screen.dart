import 'package:bajuku_app/models/outfit.dart';
import 'package:bajuku_app/screens/template/templateDetailOutfits.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JournalScreen extends StatefulWidget {
  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Outfit>> getData() async {
    List<Outfit> outfit = [];
    QuerySnapshot snapshot = await _databaseService.getOutfit();

    snapshot.documents.forEach((e) {
      outfit.add(Outfit(e.documentID ,e.data['image'], e.data['notes'], e.data['outfitName'],
          e.data['tagged'], e.data['totalCost'], e.data['created']));
    });

    return outfit;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Divider(
                color: Colors.white,
                thickness: 4.0,
              ),
              // GridView Untuk Journal
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: _buildGridViewJournal(snapshot),
              )
            ],
          );
        } else {
          return Text('');
        }
      },
    );
  }

  Widget _buildGridViewJournal(AsyncSnapshot snapshot) {
    return GridView.builder(
      itemCount: snapshot.data.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailOutfits(
                  outfit: snapshot.data[i],
                ),
              ),
            );
          },
          child: Card(
            elevation: 0.0,
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage('${snapshot.data[i].image}'),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

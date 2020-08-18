import 'package:bajuku_app/models/outfit.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:bajuku_app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailOutfits extends StatefulWidget {
  final Outfit outfit;

  const DetailOutfits({Key key, this.outfit}) : super(key: key);

  @override
  _DetailOutfitsState createState() => _DetailOutfitsState();
}

class _DetailOutfitsState extends State<DetailOutfits> {
  final DatabaseService _databaseService = DatabaseService();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<String>> fetchData() async {
    List<String> name = [];
    for (var i in widget.outfit.tagged) {
      String docId =
          i.values.toString().substring(1, i.values.toString().length - 1);
      DocumentSnapshot snapshot = await _databaseService.getCloth(docId);
      var data = snapshot.data;
      name.add(data['clothName']);
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xff3F4D55),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Journal',
          style: TextStyle(
            color: Color(0xff3F4D55),
            letterSpacing: 1.0,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 0.85,
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.outfit.image),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          DateFormat('dd MMMM yyyy').format(DateTime.now()),
                          style: TextStyle(
                            color: Color(0xff3F4D55),
                            fontSize: 12.0,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          widget.outfit.notes,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _buildRowOutfit(
                                  'Outfit Name', widget.outfit.outfitName),
                              SizedBox(height: 20.0),
                              _buildRowOutfit(
                                  'Total Cost', widget.outfit.totalCost),
                              SizedBox(height: 25.0),
                              Text(
                                'Clothes you worn: ',
                                style: TextStyle(
                                    fontSize: 12.0, color: Color(0xff3F4D55)),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.outfit.tagged.length,
                          itemBuilder: (context, i) {
                            String name = snapshot.data[i];
                            return Text(
                              name,
                              style: TextStyle(
                                color: Color(0xff859289),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Loading();
            }
          }),
    );
  }

  Widget _buildRowOutfit(String desc, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          desc,
          style: TextStyle(
            color: Color(
              0xff859289,
            ),
            fontSize: 16.0,
          ),
        ),
        Text(
          desc == 'Total Cost' ? '€ ' + value : value,
          style: TextStyle(
            color: Color(
              0xff859289,
            ),
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

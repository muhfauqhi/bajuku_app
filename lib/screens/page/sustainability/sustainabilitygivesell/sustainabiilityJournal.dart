import 'package:bajuku_app/models/outfit.dart';
import 'package:bajuku_app/screens/page/image_editor/imageEditorOutfits.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainabilitygivesell/sustainabilityAddJournal.dart';
import 'package:bajuku_app/services/database.dart';
import 'package:bajuku_app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SustainDetailJournal extends StatefulWidget {
  final Outfit outfit;
  final String type;

  SustainDetailJournal({Key key, this.outfit, this.type}) : super(key: key);

  @override
  _SustainDetailJournalState createState() => _SustainDetailJournalState();
}

class _SustainDetailJournalState extends State<SustainDetailJournal> {
  final DatabaseService _databaseService = DatabaseService();
  List<DragItem> _children = List();

  Future<List<String>> fetchData() async {
    List<String> name = [];
    for (var i in widget.outfit.tagged) {
      List<String> offset = i.keys
          .toString()
          .substring(8, i.keys.toString().length - 2)
          .split(', ');
      String docId =
          i.values.toString().substring(1, i.values.toString().length - 1);
      DocumentSnapshot snapshot = await _databaseService.getCloth(docId);
      var data = snapshot.data;
      name.add(data['clothName']);
      double left = double.parse(offset[0]);
      double top = double.parse(offset[1]);
      String category = data['category']
          .toString()
          .substring(1, data['category'].toString().length - 1);
      setOffset(data['clothName'], category.toString(), left, top);
    }
    return name;
  }

  void setOffset(String name, String category, double dx, double dy) {
    _children.add(
      DragItem(
        draggable: false,
        name: name,
        category: category,
        locationWidget: Offset(dx, dy),
      ),
    );
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
                Stack(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 0.85,
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.outfit.image),
                      ),
                    ),
                    for (var i in _children) i,
                  ],
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
                        maxLines: 3,
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
                      SizedBox(height: 20.0),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.outfit.tagged.length,
                        itemBuilder: (context, i) {
                          String name = snapshot.data[i];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              name,
                              style: TextStyle(
                                color: Color(0xff859289),
                                fontSize: 16.0,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.0),
                      _buildRowOutfit('Points earned',
                          (snapshot.data.length * 3 + 3).toString()),
                      SizedBox(height: 50.0),
                      FlatButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  SustainAddJournal(
                                outfit: widget.outfit,
                                title: 'Journal',
                                type: widget.type,
                              ),
                            ),
                          );
                        },
                        child: Image(
                          image: AssetImage('assets/images/next.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Loading();
          }
        },
      ),
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

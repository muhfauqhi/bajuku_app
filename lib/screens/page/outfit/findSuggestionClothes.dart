import 'package:bajuku_app/models/clothes.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SuggestionClothes extends StatefulWidget {
  final List<Clothes> clothesList;

  SuggestionClothes({Key key, this.clothesList}) : super(key: key);

  @override
  _SuggestionClothesState createState() => _SuggestionClothesState();
}

class _SuggestionClothesState extends State<SuggestionClothes> {
  String clothName = '';
  String category = '';
  String documentId = '';
  String price = '';
  List<Clothes> tempClothesList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      tempClothesList = widget.clothesList;
    });
  }

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
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(),
                itemCount: widget.clothesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.clothesList.elementAt(index).image),
                    ),
                    title: Text(widget.clothesList.elementAt(index).clothName),
                    subtitle: Text(
                      widget.clothesList
                          .elementAt(index)
                          .category
                          .toString()
                          .substring(
                              1,
                              widget.clothesList
                                      .elementAt(index)
                                      .category
                                      .toString()
                                      .length -
                                  1),
                    ),
                    onTap: () {
                      Navigator.pop(context, widget.clothesList.elementAt(index));
                      widget.clothesList.removeAt(index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

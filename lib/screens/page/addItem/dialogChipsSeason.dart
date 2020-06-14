import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DialogChipSeason extends StatefulWidget {
  @override
  _DialogChipSeasonState createState() => _DialogChipSeasonState();
}

class _DialogChipSeasonState extends State<DialogChipSeason> {
  static List<String> season = [
    'Summer',
    'Autumn',
    'Spring',
    'Winter'
  ];
  bool flag=true;
  String temp;
  static List<String> tags;
  final _myController = TextEditingController();

  List<String> getTags() {
    return tags;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildChip() {
    if (flag) {
      return Row(
        children: [
          Container(
            width: 316,
            child: ChipsChoice<String>.multiple(
                itemConfig: ChipsChoiceItemConfig(
                  selectedColor: Hexcolor('#DFC2AA'),
                  unselectedColor: Hexcolor('#3F4D55'),
                  labelStyle: TextStyle(
                    color: Hexcolor('#3F4D55'),
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                  ),
                  elevation: 5.0,
                ),
                value: tags,
                options: ChipsChoiceOption.listFrom<String, String>(
                    source: season, value: (i, v) => v, label: (i, v) => v),
                onChanged: (val) => setState(() {
                      tags = val;
                    })),
          ),
        ],
      );
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        Container(
          height: 300,
          width: 300,
          child: Column(
            children: <Widget>[
            //   Container(
            //   padding: EdgeInsets.all(14.0),
            //   child: TextFormField(
            //     onSaved: (val) {
            //       return tags;
            //     },
            //     onChanged: (val) {
            //       if (val.isNotEmpty) {
            //         setState(() {
            //           flag = false;
            //           temp = val;
            //         });
            //       } else {
            //         setState(() {
            //           flag = true;
            //           temp = val;
            //         });
            //       }
            //     },
            //     controller: _myController,
            //     style: TextStyle(
            //       fontSize: 12.0,
            //       fontWeight: FontWeight.normal,
            //       fontStyle: FontStyle.normal,
            //       color: Hexcolor('#3F4D55'),
            //     ),
            //     decoration: InputDecoration(
            //         hintText: 'Search your fabric',
            //         suffixIcon: Icon(Icons.search)),
            //   ),
            // ),
            buildChip()
            ],
          ),
        )
      ],
    );
  }
}
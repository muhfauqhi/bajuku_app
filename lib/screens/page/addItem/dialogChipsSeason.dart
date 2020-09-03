import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DialogChipSeason extends StatefulWidget {
  @override
  _DialogChipSeasonState createState() => _DialogChipSeasonState();
}

class _DialogChipSeasonState extends State<DialogChipSeason> {
  static List<String> season = ['Summer', 'Autumn', 'Spring', 'Winter'];
  bool flag = true;
  static List<String> tags;

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
            width: MediaQuery.of(context).size.width * 0.7,
            child: ChipsChoice<String>.multiple(
                itemConfig: ChipsChoiceItemConfig(
                  selectedColor: Hexcolor('#3F4D55'),
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
      children: [
        Container(
          height: 125,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildChip(),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Image.asset('assets/images/ok.png'),
              ),
            ],
          ),
        )
      ],
    );
  }
}

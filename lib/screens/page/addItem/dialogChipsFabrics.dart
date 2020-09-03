import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DialogChipFabric extends StatefulWidget {
  @override
  _DialogChipFabricState createState() => _DialogChipFabricState();
}

class _DialogChipFabricState extends State<DialogChipFabric> {
  String temp;
  final _myController = TextEditingController();
  static List<String> tags;
  List<String> fabric = [
    'Acetate',
    'Bamboo',
    'Cotton',
    'Chiffon',
    'Chino',
    'Charmeuse',
    'Combed Cotton',
    'Coolmax',
    'Corduroy',
    'Ecosil Polyester',
    'Fleece',
    'Interlock Knit',
    'Jacquard',
    'Jersey',
    'Jeans',
    'Knit',
    'Leather',
    'Lace',
    'Latex',
    'Linen',
    'Lycra',
    'Lyocell',
    'Memory Foam',
    'Microfiber',
    'Microfleece',
    'Neoprene',
    'Nylon',
    'Pique',
    'Polyester',
    'Rayon',
    'Satin',
    'Silk',
    'Spandex',
    'Suede',
    'Tencel',
    'Tactel',
    'Thermastat',
    'Velvet',
    'Viscose',
    'Vinyl',
    'Wool',
    'Woven',
  ];

  List<String> cariJumlahAlphabet(List<String> tagsList) {
    List<String> alpha = [];
    for (int i = 0; i < tagsList.length; i++) {
      if (alpha
          .any((e) => e.contains(tagsList[i].substring(0, 1).toUpperCase()))) {
      } else {
        alpha.add(tagsList[i].substring(0, 1).toUpperCase());
      }
    }
    return alpha;
  }

  List<String> fabricListAlphabet;

  @override
  void initState() {
    super.initState();
    fabric.sort();
    fabricListAlphabet = cariJumlahAlphabet(fabric);
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool flag = true;

  List<String> getTags() {
    return tags;
  }

  Widget suggestionList() {
    if (flag) {
      return Expanded(
        child: ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            shrinkWrap: true,
            itemCount: fabricListAlphabet.length,
            itemBuilder: (context, idx) {
              return ListTile(
                title: Text(
                  fabricListAlphabet.elementAt(idx),
                  style: TextStyle(
                      color: Hexcolor('#E1C8B4'),
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal),
                ),
                subtitle: ChipsChoice<String>.multiple(
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
                        source: fabric
                            .where((e) =>
                                e.substring(0, 1) ==
                                fabricListAlphabet.elementAt(idx).toString())
                            .toList(),
                        value: (i, v) => v,
                        label: (i, v) => v),
                    onChanged: (val) => setState(() => tags = val)),
              );
            }),
      );
    } else {
      if (fabric.any((e) => e.toLowerCase().startsWith(temp))) {
        return ListTile(
          title: Text('Result'),
          subtitle: ChipsChoice<String>.multiple(
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
                  source: fabric
                      .where(
                          (e) => e.toUpperCase().startsWith(temp.toUpperCase()))
                      .toList(),
                  value: (i, v) => v,
                  label: (i, v) => v),
              onChanged: (val) => setState(() => tags = val)),
        );
      } else {
        return Text('Not found');
      }
    }
  }

  Widget buildChip() {
    if (tags != null) {
      return Row(
        children: [
          Expanded(
            child: Container(
              // width: MediaQuery.of(context).size.width,
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
                      source: tags, value: (i, v) => v, label: (i, v) => v),
                  onChanged: (val) => setState(() {
                        tags = val;
                      })),
            ),
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
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(14.0),
                child: TextFormField(
                  onSaved: (val) {
                    return tags;
                  },
                  onChanged: (val) {
                    if (val.isNotEmpty) {
                      setState(() {
                        flag = false;
                        temp = val;
                      });
                    } else {
                      setState(() {
                        flag = true;
                        temp = val;
                      });
                    }
                  },
                  controller: _myController,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: Hexcolor('#3F4D55'),
                  ),
                  decoration: InputDecoration(
                      hintText: 'Search your fabric',
                      suffixIcon: Icon(Icons.search)),
                ),
              ),
              buildChip(),
              Divider(),
              suggestionList(),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Image.asset('assets/images/ok.png'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path/path.dart';

class DialogChipFilter extends StatefulWidget {
  @override
  _DialogChipFilterState createState() => _DialogChipFilterState();
}

class _DialogChipFilterState extends State<DialogChipFilter> {
  String temp;
  List<String> tags = [];

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
        print('huruf ini sudah ada');
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

  bool flag = true;

  Widget suggestionList() {
    if (flag) {
      print(tags);
      return Expanded(
        child: ListView.builder(
            itemCount: fabricListAlphabet.length,
            itemBuilder: (context, idx) {
              return ListTile(
                title: Text(fabricListAlphabet.elementAt(idx)),
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
    if (tags.length > 0) {
      return Container(
        child: ChipsChoice<String>.multiple(
            value: tags,
            options: ChipsChoiceOption.listFrom<String, String>(
                source: tags, value: (i, v) => v, label: (i, v) => v),
            onChanged: (val) => setState(() => tags = val)),
      );
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              child: TextFormField(
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
            suggestionList(),
          ],
        ),
      ),
    );
  }
}

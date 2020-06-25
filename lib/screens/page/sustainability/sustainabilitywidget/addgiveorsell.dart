import 'package:bajuku_app/screens/page/sustainability/sustainabilitygivesell/sustainScaffoldJournal.dart';
import 'package:bajuku_app/screens/page/sustainability/sustainabilitygivesell/sustainabilityScaffoldWardrobe.dart';
import 'package:flutter/material.dart';

class SimpleDialogAddGiveOrSell extends StatelessWidget {
  final String type;

  SimpleDialogAddGiveOrSell({this.type});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          buttonImage('TakeaPicture', context, ''),
          Divider(height: 2),
          buttonImage('ChoosefromAlbum', context, ''),
          Divider(height: 2),
          buttonImage('ChoosefromWardrobe', context, SustainScaffoldWardrobe(type: type,)),
          Divider(height: 2),
          buttonImage('ChoosefromMyJournal', context, SustainScaffoldJournal(type: type)),
          Divider(height: 60),
        ],
      ),
    );
  }

  Widget buttonImage(var asset, var context, var route) {
    return GestureDetector(
      child: Image.asset(
        'assets/images/$asset.png',
        width: 300,
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => route));
      },
    );
  }
}

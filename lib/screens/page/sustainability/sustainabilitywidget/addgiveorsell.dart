import 'package:bajuku_app/screens/page/sustainability/sustainabilitygivesell/sustainabilityscaffold.dart';
import 'package:flutter/material.dart';

class SimpleDialogAddGiveOrSell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          buttonImage('TakeaPicture', context),
          Divider(height: 2),
          buttonImage('ChoosefromAlbum', context),
          Divider(height: 2),
          buttonImage('ChoosefromWardrobe', context),
          Divider(height: 2),
          buttonImage('ChoosefromMyJournal', context),
          Divider(height: 60),
        ],
      ),
    );
  }

  Widget buttonImage(var asset, var context) {
    return GestureDetector(
      child: Image.asset(
        'assets/images/$asset.png',
        width: 300,
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SustainScaffold()));
      },
    );
  }
}

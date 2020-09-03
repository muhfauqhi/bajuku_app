import 'package:bajuku_app/screens/page/addItem/add.dart';
import 'package:flutter/material.dart';

class AddChoiceDialog extends StatefulWidget {
  @override
  _AddChoiceDialogState createState() => _AddChoiceDialogState();
}

class _AddChoiceDialogState extends State<AddChoiceDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 70.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  child: AddItemDialog(
                    flagAdd: 'Wardrobe',
                  ));
            },
            child: Image(
              height: 90,
              image: AssetImage('assets/images/addclothes.png'),
            ),
          ),
          SizedBox(width: 30.0),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  child: AddItemDialog(
                    flagAdd: 'Journal',
                  ));
            },
            child: Image(
              height: 90,
              image: AssetImage('assets/images/addjournal.png'),
            ),
          ),
        ],
      ),
    );
  }
}

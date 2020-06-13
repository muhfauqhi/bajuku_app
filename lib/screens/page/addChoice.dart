import 'package:bajuku_app/screens/page/add.dart';
import 'package:flutter/material.dart';

class AddChoiceDialog extends StatefulWidget {
  @override
  _AddChoiceDialogState createState() => _AddChoiceDialogState();
}

class _AddChoiceDialogState extends State<AddChoiceDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      children: [
        Container(
          margin: EdgeInsets.only(top: 400),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 70,
                width: 70,
                child: GestureDetector(
                  child: Image.asset('assets/images/addclothes.png'),
                  onTap: () {
                    showDialog(context: context, child: AddItemDialog(flagAdd: 'Wardrobe',));
                  },
                ),
              ),
              Container(
                height: 70,
                width: 70,
                child: GestureDetector(
                  child: Image.asset('assets/images/addjournal.png'),
                  onTap: () {
                    showDialog(context: context, child: AddItemDialog(flagAdd: 'Journal',));
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

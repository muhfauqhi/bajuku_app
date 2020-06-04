import 'package:bajuku_app/screens/page/addItem.dart';
import 'package:flutter/material.dart';

class AddItemDialog extends StatefulWidget {
  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      useMaterialBorderRadius: true,
      children: <Widget>[
        SimpleDialogOption(
            onPressed: () { 
              Navigator.of(context).pop();
              Navigator.push(context, new MaterialPageRoute(
                        builder: (BuildContext context) => new AddItem())
              );
            },
            child: const Text('Add Item'),
          ),
          SimpleDialogOption(
            onPressed: () { },
            child: const Text('Add Journal'),
          ),
      ],
    );
  }
}
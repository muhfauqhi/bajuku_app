import 'package:bajuku_app/shared/constants.dart';
import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();

  String itemName = "";
  int worn;
  String notes;
  String size;
  String season;
  double price;
  double valueCost;
  var colors = <String>{};
  String status;
  int usedInOutfits;
  var categories = <String>{};
  String url;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
    appBar: new AppBar(
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      title: new Text('Add Item', 
      style: TextStyle(color: Colors.black)),
      centerTitle: true,
      backgroundColor: Colors.white,
    ),
    body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Cloth Name'),
                onChanged: (val){
                  setState(() => itemName = val);
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Worn'),
                obscureText: true,
                // onChanged: (val){
                //   setState(() => worn = val);
                // }
              ),
              SizedBox(height: 10.0),
            ]
          ),
        ),
    ),
  );
  }
}
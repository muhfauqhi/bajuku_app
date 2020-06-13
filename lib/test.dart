import 'package:bajuku_app/services/database.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }

  void setOutfit(String image) async{
    DatabaseService().setOutfit(image);
  }
}
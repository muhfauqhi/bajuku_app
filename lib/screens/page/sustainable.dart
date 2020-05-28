import 'package:flutter/material.dart';

class SustainablePage extends StatefulWidget {
  @override
  _SustainablePageState createState() => _SustainablePageState();
}

class _SustainablePageState extends State<SustainablePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Sustainable'),
        backgroundColor: Colors.red,
      ),
    );
  }
}


import 'package:bajuku_app/screens/page/profileheader/headerprofile.dart';
import 'package:bajuku_app/screens/page/profileheader/profileheader.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SustainableTemplate extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget headerWidget;
  final Widget bottomNavigationBar;

  SustainableTemplate({this.title, this.body, this.headerWidget, this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      leadingActive: true,
      titleStyle: false,
      bottomNavigationBar: bottomNavigationBar,
      title: title,
      headerWidget: [
        HeaderProfile(),
        headerWidget,
      ],
      body: body,
    );
  }
}

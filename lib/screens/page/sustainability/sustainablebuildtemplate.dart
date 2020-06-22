import 'package:bajuku_app/screens/page/profileheader/profileheader.dart';
import 'package:bajuku_app/screens/page/scaffold/myscaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SustainableTemplate extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget headerWidget;

  SustainableTemplate({this.title, this.body, this.headerWidget});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: title,
      headerWidget: [
        ProfileHeader(),
        headerWidget,
      ],
      body: body,
    );
  }
}

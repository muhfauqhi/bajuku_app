import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;
  final List<Widget> headerWidget;
  final String title;
  final Widget bottomNavigationBar;

  MyScaffold({this.body, this.headerWidget, this.title, this.bottomNavigationBar});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            Container(
              child: SliverAppBar(
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Hexcolor('#3F4D55'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: Hexcolor('FBFBFB'),
                expandedHeight: 50.0,
                floating: false,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      color: Hexcolor('#3F4D55'),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Container(
                    child: Column(
                      children: headerWidget,
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: body,
      ),
    );
  }
}
